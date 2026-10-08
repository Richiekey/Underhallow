import os
import sys
import subprocess
import json
from PIL import Image

REPO_ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), '../../..'))
SCRIPT_PATH = os.path.join(REPO_ROOT, 'tools', 'art_pipeline', 'asset_cleanup.py')

VENV_PYTHON = r'C:\Users\HP\.gemini\antigravity-ide\brain\1576830b-c7e7-4366-aaf3-c265e91b2f9b\scratch\venv\Scripts\python'

TEST_CASES = [
    {
        "name": "Mature Woodland Tree",
        "input": "assets/benchmarks/benchmark_mature_woodland_tree.png",
        "output": "tests/temp_out_tree.png",
        "args": ["--asset-class", "organic-tall"],
        "expected_status": "CLEAN",
        "expected_removed": 131
    },
    {
        "name": "Wild Berry Bush",
        "input": "assets/benchmarks/benchmark_wild_berry_bush.png",
        "output": "tests/temp_out_bush.png",
        "args": ["--asset-class", "organic-low"],
        "expected_status": "CLEAN",
        "expected_removed": 176
    },
    {
        "name": "Cottage",
        "input": "assets/benchmarks/benchmark_cottage.png",
        "output": "tests/temp_out_cottage.png",
        "args": [
            "--asset-class", "architectural",
            "--repair-smooth-bottom"
        ],
        "expected_status": "CLEAN_WITH_REPAIR",
        "expected_removed": 920
    }
]

def run_test():
    passes = 0
    fails = 0
    
    for case in TEST_CASES:
        in_path = os.path.join(REPO_ROOT, case["input"])
        out_path = os.path.join(REPO_ROOT, case["output"])
        
        # Verify source exists
        if not os.path.exists(in_path):
            print(f"FAIL: Source missing {in_path}")
            fails += 1
            continue
            
        orig_img = Image.open(in_path)
        orig_size = orig_img.size
        orig_img.close()
        orig_mtime = os.path.getmtime(in_path)
            
        cmd = [VENV_PYTHON, SCRIPT_PATH, "--input", in_path, "--output", out_path] + case["args"]
        
        print(f"Running: {' '.join(cmd)}")
        result = subprocess.run(cmd, capture_output=True, text=True)
        
        if result.returncode != 0:
            print(f"FAIL: {case['name']} crashed.\n{result.stderr}")
            fails += 1
            continue
            
        try:
            output_json = json.loads(result.stdout)
        except Exception as e:
            print(f"FAIL: {case['name']} did not output valid JSON.\nOutput: {result.stdout}")
            fails += 1
            continue
            
        if output_json["status"] != case["expected_status"]:
            print(f"FAIL: {case['name']} expected {case['expected_status']}, got {output_json['status']}")
            fails += 1
            continue
            
        # The cottage has some median smoothing that removes and adds pixels. 
        # For the cottage, removed is 205 (161 shadow + 44 stringy)
        if output_json["pixels_removed"] != case["expected_removed"]:
            print(f"FAIL: {case['name']} expected {case['expected_removed']} pixels removed, got {output_json['pixels_removed']}")
            fails += 1
            continue
            
        if not os.path.exists(out_path):
            print(f"FAIL: {case['name']} output file not created.")
            fails += 1
            continue
            
        out_img = Image.open(out_path)
        out_img_size = out_img.size
        out_img.close()
        
        if out_img_size != orig_size:
            print(f"FAIL: {case['name']} dimensions changed from {orig_size} to {out_img_size}")
            fails += 1
            continue
            
        new_mtime = os.path.getmtime(in_path)
        if new_mtime != orig_mtime:
            print(f"FAIL: {case['name']} source file was modified!")
            fails += 1
            continue
            
        print(f"PASS: {case['name']}")
        passes += 1
        
        # Clean up
        if os.path.exists(out_path):
            try:
                os.remove(out_path)
            except Exception as e:
                print(f"WARNING: Could not remove {out_path}: {e}")

            
    print(f"\nTotal Tests: {passes + fails}")
    print(f"Passed: {passes}")
    print(f"Failed: {fails}")
    
    if fails > 0:
        sys.exit(1)

if __name__ == "__main__":
    run_test()
