# Underhallow Standard Isolated Asset Cleanup Pipeline V1

## 1. Purpose
The `asset_cleanup.py` pipeline utility provides a deterministic, reliable method for converting raw PixelLab-generated assets containing baked-in environmental/diorama terrain into isolated transparent game assets, while preserving the original artwork. 

## 2. Supported Asset Types
* **Organic (Tall and Low)**: e.g., Trees, Bushes.
* **Architectural**: e.g., Buildings, Cottages.

## 3. Methodology
This pipeline prioritizes the **Structural Isolator Principle**. It avoids global color deletion which could destroy legitimate asset structures. 

Instead, the pipeline leverages the behavior of PixelLab generations: PixelLab organic terrain inherently drifts toward green (`g > r`), while architectural structures and woody trunks drift toward red/brown (`r >= g`).
The cleanup tool performs:
1. **Color Profiling**: Identifies "green" pixels (`g > r and g >= b`).
2. **Spatial Analysis**: Evaluates connected components to identify continuous masses.
3. **Conservative Removal**: Deletes green components exclusively located in the bottom half of the image, relying on non-green structural isolators (like trunks and foundations) to separate the asset from the terrain.

## 4. Safety Philosophy
**Preserve ambiguous pixels.** If environmental terrain cannot be confidently separated from legitimate foliage or structure (e.g. if the grass and the asset share the exact same palette and are physically connected), the pipeline leaves the pixels intact and produces a `REVIEW_REQUIRED` state. It never redraws or alters colors generatively.

## 5. Structural-Isolator Principle
A structural isolator (such as cottage walls, tree trunks, or berry-bush roots) establishes that two similarly colored regions are actually separate components. For example, the non-green brown foundation of the cottage separates the green grass from the upper walls, allowing a connected-components algorithm to securely delete the grass without touching the architecture.

## 6. Limitations
* **Direct Foliage Contact**: If an asset's foliage directly touches the environmental terrain without any intervening structural boundary (and both are green), the current spatial logic will merge them into one component. These assets will require manual review or a fallback strategy.

## 7. Result States
* **CLEAN**: Environmental contamination confidently removed. No manual repair necessary.
* **CLEAN_WITH_REPAIR**: Environmental contamination removed alongside a requested small deterministic surgical repair (e.g., median bottom smoothing).
* **REVIEW_REQUIRED**: The pipeline identified a possible environmental region but lacked confidence. No destructive cleanup was performed.
* **UNSUPPORTED**: The asset structure does not match the current safe cleanup methodology.
* **ERROR**: A technical failure occurred (e.g., invalid PNG input).

## 8. Usage
The pipeline is invoked as a Python CLI utility:
```bash
python tools/art_pipeline/asset_cleanup.py --input <source.png> --output <cleaned.png> --asset-class <class>
```
* **Classes:** `architectural`, `organic-tall`, `organic-low`, `rock-mineral`, `decorative`, `unknown`.
* **Optional Flags:** `--dry-run` (processes image without saving), `--report-out <path.json>` (saves detailed metrics).
* **Surgical Repair:** `--repair-smooth-bottom` (applies a median filter to remove jagged artifacts on structural bottoms).
