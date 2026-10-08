# Underhallow Standard Isolated Asset Cleanup Pipeline V1

## 1. Purpose
The `asset_cleanup.py` pipeline utility provides a deterministic, reliable method for converting raw PixelLab-generated assets containing baked-in environmental/diorama terrain into isolated transparent game assets, while preserving the original artwork. 

## 2. Supported Asset Types
* **Organic (Tall and Low)**: e.g., Trees, Bushes.
* **Architectural**: e.g., Buildings, Cottages (defaults to REVIEW_REQUIRED for safety).

## 3. Methodology & Heuristics
This pipeline prioritizes the **Structural Isolator Principle**. It avoids global color deletion which could destroy legitimate asset structures. 

Based on the three initial benchmark samples, a successful heuristic was established for PixelLab organic generation: PixelLab organic terrain inherently drifts toward green (`g > r`), while architectural structures and woody trunks often drift toward red/brown (`r >= g`).
The cleanup tool performs:
1. **Color Profiling**: Identifies candidate "green" pixels (`g > r and g >= b`).
2. **Spatial Analysis**: Evaluates connected components to identify continuous masses.
3. **Conservative Removal**: Deletes green components exclusively located in the bottom half of the image, relying on non-green structural isolators (like trunks and foundations) to separate the asset from the terrain.
4. **Confidence Evaluation**: If a qualifying component is ambiguously large (>25% of total opaque pixels), it is preserved and the asset is marked `REVIEW_REQUIRED`.

## 4. Safety Philosophy
**Preserve ambiguous pixels.** If environmental terrain cannot be confidently separated from legitimate foliage or structure, the pipeline leaves the pixels intact and produces a `REVIEW_REQUIRED` state. It never redraws or alters colors generatively.

* `g > r && g >= b` is treated as a heuristic candidate generator, NOT a universal environmental classifier. Spatial position and size outrank color similarity. Green foliage is legitimate asset content.
* Surgical repair is strictly constrained. Operations that blindly add or delete pixels (like standard median filters) are prohibited. Repairs must target specific coordinates and colors (e.g., `--repair-sever-shadow-color`).

## 5. Structural-Isolator Principle
A structural isolator (such as cottage walls, tree trunks, or berry-bush roots) establishes that two similarly colored regions are actually separate components. For example, a brown trunk separates the green grass from the upper green canopy, allowing a connected-components algorithm to securely delete the grass without touching the canopy.

## 6. Result States
* **CLEAN**: Environmental contamination confidently removed. No manual repair necessary.
* **CLEAN_WITH_REPAIR**: Environmental contamination removed alongside a requested small deterministic surgical repair (e.g., specific shadow sever).
* **REVIEW_REQUIRED**: The pipeline identified a possible environmental region but lacked confidence, or the asset class requires manual verification. No destructive cleanup was performed.
* **UNSUPPORTED**: The asset structure does not match the current safe cleanup methodology.
* **ERROR**: A technical failure occurred (e.g., invalid PNG input, transparent image).

## 7. Usage
The pipeline is invoked as a Python CLI utility:
```bash
python tools/art_pipeline/asset_cleanup.py --input <source.png> --output <cleaned.png> --asset-class <class>
```
* **Classes:** `architectural`, `organic-tall`, `organic-low`, `rock-mineral`, `decorative`, `unknown`.
* **Optional Flags:** `--dry-run` (processes image without saving), `--report-out <path.json>` (saves detailed metrics).
* **Surgical Repair:** `--repair-sever-shadow-color <r,g,b>`, `--repair-sever-x-max <x>`, `--repair-sever-y-min <y>`.
