import argparse
import sys
import os
import json
from PIL import Image
from collections import Counter, deque

def get_opaque_bounds(pixels, width, height):
    min_x, max_x = width, -1
    min_y, max_y = height, -1
    opaque_count = 0
    for y in range(height):
        for x in range(width):
            if pixels[x, y][3] > 0:
                opaque_count += 1
                if x < min_x: min_x = x
                if x > max_x: max_x = x
                if y < min_y: min_y = y
                if y > max_y: max_y = y
    return min_x, max_x, min_y, max_y, opaque_count

def is_green(r, g, b):
    return g > r and g >= b

def get_connected_components(pixels, width, height, condition_fn):
    visited = set()
    components = []
    for y in range(height):
        for x in range(width):
            if pixels[x, y][3] > 0 and condition_fn(pixels[x, y][:3]) and (x, y) not in visited:
                comp = []
                queue = deque([(x, y)])
                visited.add((x, y))
                while queue:
                    cx, cy = queue.popleft()
                    comp.append((cx, cy))
                    # 8-way connectivity
                    for dx in [-1, 0, 1]:
                        for dy in [-1, 0, 1]:
                            if dx == 0 and dy == 0: continue
                            nx, ny = cx + dx, cy + dy
                            if 0 <= nx < width and 0 <= ny < height:
                                if pixels[nx, ny][3] > 0 and condition_fn(pixels[nx, ny][:3]) and (nx, ny) not in visited:
                                    visited.add((nx, ny))
                                    queue.append((nx, ny))
                components.append(comp)
    return components

def process_image(args):
    def save_report_and_return(report):
        if args.report_out:
            os.makedirs(os.path.dirname(os.path.abspath(args.report_out)), exist_ok=True)
            with open(args.report_out, 'w') as f:
                json.dump(report, f, indent=2)
        return report

    if not os.path.exists(args.input):
        return save_report_and_return({"status": "ERROR", "message": f"Input not found: {args.input}"})
        
    if os.path.abspath(args.input) == os.path.abspath(args.output):
        return save_report_and_return({"status": "ERROR", "message": "Source and output paths must not be the same to protect source asset."})

    img = Image.open(args.input).convert('RGBA')
    pixels = img.load()
    width, height = img.size
    
    orig_min_x, orig_max_x, orig_min_y, orig_max_y, orig_opaque = get_opaque_bounds(pixels, width, height)
    
    report = {
        "source": args.input,
        "output": args.output,
        "dimensions": f"{width}x{height}",
        "classification": args.asset_class,
        "original_opaque": orig_opaque,
        "final_opaque": 0,
        "pixels_removed": 0,
        "pixels_added": 0,
        "alpha_changes": 0,
        "components_removed": 0,
        "new_colors": 0,
        "cleanup_strategy": "",
        "status": "UNSUPPORTED",
        "surgical_repair": "NONE",
        "warnings": []
    }
    
    if orig_opaque == 0:
        report["status"] = "ERROR"
        report["warnings"].append("Image is completely transparent.")
        return save_report_and_return(report)

    pixels_removed_total = 0
    components_removed_total = 0
    
    if args.asset_class in ["organic-tall", "organic-low"]:
        report["cleanup_strategy"] = "Green connected-component spatial isolation"
        
        green_comps = get_connected_components(pixels, width, height, lambda rgb: is_green(*rgb))
        mid_y = orig_min_y + (orig_max_y - orig_min_y) * 0.5
        
        has_ambiguous_removals = False
        for comp in green_comps:
            comp_min_y = min([p[1] for p in comp])
            if comp_min_y > mid_y:
                # Confidence check: if component is suspiciously large (>25% of opaque pixels), mark review required
                if len(comp) > orig_opaque * 0.25:
                    has_ambiguous_removals = True
                    report["warnings"].append(f"Component too large for confident removal ({len(comp)} pixels).")
                    continue
                    
                for (x, y) in comp:
                    pixels[x, y] = (0, 0, 0, 0)
                    pixels_removed_total += 1
                components_removed_total += 1
                
        report["status"] = "REVIEW_REQUIRED" if has_ambiguous_removals else "CLEAN"

    elif args.asset_class == "architectural":
        report["cleanup_strategy"] = "Architectural baseline (Optional shadow sever)"
        report["status"] = "REVIEW_REQUIRED"
    else:
        report["warnings"].append("Unknown asset class, no cleanup performed.")
        
    # Surgical Repair Phase
    if args.repair_sever_shadow_color and args.repair_sever_x_max is not None:
        r_c, g_c, b_c = [int(v) for v in args.repair_sever_shadow_color.split(',')]
        sever_x = int(args.repair_sever_x_max)
        sever_y_min = int(args.repair_sever_y_min) if args.repair_sever_y_min else 0
        
        shadow_comps = get_connected_components(pixels, width, height, lambda rgb: rgb == (r_c, g_c, b_c))
        repair_applied = False
        for comp in shadow_comps:
            comp_min_x = min([p[0] for p in comp])
            comp_max_y = max([p[1] for p in comp])
            if comp_min_x <= sever_x and comp_max_y >= sever_y_min:
                removed_this_shadow = 0
                for (x, y) in comp:
                    if x <= sever_x:
                        pixels[x, y] = (0, 0, 0, 0)
                        pixels_removed_total += 1
                        removed_this_shadow += 1
                if removed_this_shadow > 0:
                    components_removed_total += 1
                    repair_applied = True
                    report["surgical_repair"] = f"Severed shadow {r_c},{g_c},{b_c} at x<={sever_x} (y>={sever_y_min})"
                    
        if repair_applied and report["status"] in ["CLEAN", "REVIEW_REQUIRED"]:
            report["status"] = "CLEAN_WITH_REPAIR"

    report["pixels_removed"] = pixels_removed_total
    report["alpha_changes"] = pixels_removed_total
    report["components_removed"] = components_removed_total
    
    # Calculate final
    _, _, _, _, fin_opaque = get_opaque_bounds(pixels, width, height)
    report["final_opaque"] = fin_opaque
    
    if not args.dry_run:
        os.makedirs(os.path.dirname(os.path.abspath(args.output)), exist_ok=True)
        img.save(args.output)
        
    return save_report_and_return(report)

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Underhallow Asset Cleanup Pipeline V1")
    parser.add_argument("--input", required=True, help="Path to source PNG")
    parser.add_argument("--output", required=True, help="Path to output PNG")
    parser.add_argument("--asset-class", required=True, choices=["architectural", "organic-tall", "organic-low", "rock-mineral", "decorative", "unknown"])
    parser.add_argument("--dry-run", action="store_true", help="Run analysis without saving output")
    parser.add_argument("--report-out", help="Path to save JSON report")
    
    parser.add_argument("--repair-sever-shadow-color", help="RGB color of shadow to sever (e.g. '51,27,33')")
    parser.add_argument("--repair-sever-x-max", type=int, help="Maximum X coordinate to sever shadow")
    parser.add_argument("--repair-sever-y-min", type=int, help="Minimum Y coordinate (component max Y) to sever shadow")
    
    args = parser.parse_args()
    
    result = process_image(args)
    print(json.dumps(result, indent=2))
    
    if result["status"] == "ERROR":
        sys.exit(1)
    sys.exit(0)
