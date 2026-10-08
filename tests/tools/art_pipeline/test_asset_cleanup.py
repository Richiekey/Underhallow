import os
import sys
import subprocess
import json
from PIL import Image

def run_cleanup(*args):
    cmd = [sys.executable, "tools/art_pipeline/asset_cleanup.py"] + list(args)
    result = subprocess.run(cmd, capture_output=True, text=True)
    return result

def create_test_image(path, mode="RGBA", size=(10, 10), color=(0, 0, 0, 0)):
    os.makedirs(os.path.dirname(os.path.abspath(path)), exist_ok=True)
    img = Image.new(mode, size, color)
    img.save(path)

def test_dry_run():
    out_path = "tests/temp_dry_run.png"
    if os.path.exists(out_path):
        os.remove(out_path)
    res = run_cleanup("--input", "assets/benchmarks/benchmark_mature_woodland_tree.png", "--output", out_path, "--asset-class", "organic-tall", "--dry-run", "--report-out", "tests/temp_report.json")
    assert res.returncode == 0
    assert not os.path.exists(out_path), "Dry run should not create output file"
    with open("tests/temp_report.json") as f:
        data = json.load(f)
        assert data["status"] == "CLEAN"

def test_collision():
    res = run_cleanup("--input", "assets/benchmarks/benchmark_mature_woodland_tree.png", "--output", "assets/benchmarks/benchmark_mature_woodland_tree.png", "--asset-class", "organic-tall")
    assert res.returncode != 0
    assert "Source and output paths must not be the same" in res.stdout or "Source and output paths must not be the same" in res.stderr

def test_transparent_image():
    create_test_image("tests/temp_transparent.png", color=(0, 0, 0, 0))
    res = run_cleanup("--input", "tests/temp_transparent.png", "--output", "tests/temp_out.png", "--asset-class", "organic-tall", "--report-out", "tests/temp_report.json")
    assert res.returncode != 0
    with open("tests/temp_report.json") as f:
        data = json.load(f)
        assert data["status"] == "ERROR"
        assert "Image is completely transparent." in data["warnings"]

def test_rgb_image():
    create_test_image("tests/temp_rgb.png", mode="RGB", color=(255, 0, 0))
    res = run_cleanup("--input", "tests/temp_rgb.png", "--output", "tests/temp_out.png", "--asset-class", "architectural", "--report-out", "tests/temp_report.json")
    assert res.returncode == 0
    with open("tests/temp_report.json") as f:
        data = json.load(f)
        assert data["status"] == "REVIEW_REQUIRED"

def test_review_required_large_component():
    # Create an image that is mostly green at the bottom
    img = Image.new("RGBA", (10, 10), (0, 0, 0, 0))
    pixels = img.load()
    # Top pixel (non-green)
    pixels[5, 2] = (100, 50, 50, 255)
    # Bottom huge green component (9 pixels, > 25% of 10 opaque)
    for x in range(1, 10):
        pixels[x, 8] = (50, 200, 50, 255)
    img.save("tests/temp_large_green.png")
    
    res = run_cleanup("--input", "tests/temp_large_green.png", "--output", "tests/temp_out.png", "--asset-class", "organic-tall", "--report-out", "tests/temp_report.json")
    assert res.returncode == 0
    with open("tests/temp_report.json") as f:
        data = json.load(f)
        assert data["status"] == "REVIEW_REQUIRED"
        assert data["pixels_removed"] == 0

def test_unknown_class():
    res = run_cleanup("--input", "assets/benchmarks/benchmark_mature_woodland_tree.png", "--output", "tests/temp_out.png", "--asset-class", "unknown", "--report-out", "tests/temp_report.json")
    assert res.returncode == 0
    with open("tests/temp_report.json") as f:
        data = json.load(f)
        assert data["status"] == "UNSUPPORTED"
        assert "Unknown asset class" in data["warnings"][0]

def test_deterministic_repeatability():
    run_cleanup("--input", "assets/benchmarks/benchmark_mature_woodland_tree.png", "--output", "tests/temp_out1.png", "--asset-class", "organic-tall", "--report-out", "tests/temp_report1.json")
    run_cleanup("--input", "assets/benchmarks/benchmark_mature_woodland_tree.png", "--output", "tests/temp_out2.png", "--asset-class", "organic-tall", "--report-out", "tests/temp_report2.json")
    
    with open("tests/temp_report1.json") as f:
        d1 = json.load(f)
    with open("tests/temp_report2.json") as f:
        d2 = json.load(f)
        
    assert d1["pixels_removed"] == d2["pixels_removed"]
    assert d1["final_opaque"] == d2["final_opaque"]
    
    # Also verify preservation of colors (no unexplained new colors)
    assert d1["new_colors"] == 0
    
def test_cottage_repair():
    # We use benchmark_cottage_cleaned.png for the shadow sever test since the new algorithm defaults to REVIEW_REQUIRED for architecture
    res = run_cleanup("--input", "assets/benchmarks/benchmark_cottage_cleaned.png", "--output", "tests/temp_out.png", "--asset-class", "architectural", "--repair-sever-shadow-color", "51,27,33", "--repair-sever-x-max", "45", "--repair-sever-y-min", "90", "--report-out", "tests/temp_report.json")
    assert res.returncode == 0
    with open("tests/temp_report.json") as f:
        data = json.load(f)
        assert data["status"] == "CLEAN_WITH_REPAIR"
        assert data["pixels_removed"] > 0

if __name__ == "__main__":
    tests = [
        test_dry_run,
        test_collision,
        test_transparent_image,
        test_rgb_image,
        test_review_required_large_component,
        test_unknown_class,
        test_deterministic_repeatability,
        test_cottage_repair
    ]
    
    passed = 0
    for t in tests:
        try:
            t()
            print(f"PASS: {t.__name__}")
            passed += 1
        except Exception as e:
            print(f"FAIL: {t.__name__} - {e}")
            
    print(f"\nTotal: {len(tests)} | Passed: {passed} | Failed: {len(tests) - passed}")
    if passed != len(tests):
        sys.exit(1)
