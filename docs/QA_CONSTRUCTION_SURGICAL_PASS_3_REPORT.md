# UNDERHALLOW — QA, INTEGRATION & RELEASE

## Construction Interaction — Surgical Pass 3
### Independent Runtime Verification Report

**Document ID:** QA-002  
**Target Commit:** [`58d10173af186565d07021a7b4fe1bb3a488b4a3`](file:///c:/Users/HP/Documents/Underhallow)  
**Parent Commit:** `210d132df2f76d4b6981338763ba63156bd92a36`  
**Execution Timestamp:** 2026-09-16 18:27:00 UTC  
**Environment:** Windows x86_64, Godot Engine `4.7.2.stable.official.ed1daf0bf`  
**QA Status:** **PASS — UNBLOCKED**  
**GM/PM Acceptance Status:** **RECOMMENDED FOR APPROVAL**  

---

## 1. Executive Summary

QA independently executed runtime verification of commit `58d10173af186565d07021a7b4fe1bb3a488b4a3` to resolve the environmental verification blocker previously recorded against Surgical Pass 3.

Full automated test execution, live scene instancing ([scenes/game/game.tscn](file:///c:/Users/HP/Documents/Underhallow/scenes/game/game.tscn)), player input event injection, and presentation/domain state tracking were successfully carried out.

### Key Results
1. **Automated Test Suite:** Exactly **532 of 532** tests executed and passed cleanly (`exit code 0`, duration `6,334 ms`).
2. **Coordinate Agreement:** The shared world-grid transformation in [BuildingDisplay](file:///c:/Users/HP/Documents/Underhallow/scenes/gameplay/building/building_display.gd) is consumed uniformly by preview rendering, placed building rendering, and [PlayerController](file:///c:/Users/HP/Documents/Underhallow/src/player/player_controller.gd) targeting.
3. **Alignment Evidence:** At runtime, the preview display world position and the rendered placed building world position agree with zero delta (`Vector2.ZERO`) for both fence and path structures.
4. **Authoritative Placement:** Mutation strictly obeys the architectural boundary:
   `PlayerController → PlaceBuildingCommand → GameRuntime → Validation → Mutation → BuildingState → BuildingDisplay`.
5. **Robustness:** Active `BuildingDisplay.origin_offset`, `BuildingPreviewDisplay.origin_offset`, and `BuildingDisplay.DEFAULT_ORIGIN_OFFSET` are identical (`Vector2(-130.0, -20.0)`), establishing a bijective and drift-free transform across all layers.

---

## 2. Environment & Repository Commit Verification

```powershell
PS C:\Users\HP\Documents\Underhallow> git rev-parse HEAD
58d10173af186565d07021a7b4fe1bb3a488b4a3

PS C:\Users\HP\Documents\Underhallow> godot --version
4.7.2.stable.official.ed1daf0bf

PS C:\Users\HP\Documents\Underhallow> git status --short
# (Clean working tree — 0 uncommitted modifications)
```

| Parameter | Specification Requirement | Measured Value | Compliance |
| :--- | :--- | :--- | :---: |
| **Commit SHA** | `58d10173af186565d07021a7b4fe1bb3a488b4a3` | `58d10173af186565d07021a7b4fe1bb3a488b4a3` | **EXACT MATCH** |
| **Parent SHA** | `210d132df2f76d4b6981338763ba63156bd92a36` | `210d132df2f76d4b6981338763ba63156bd92a36` | **EXACT MATCH** |
| **Delta Scope** | Exactly 1 commit ahead, 5 files | 1 commit ahead, 5 files changed | **COMPLIANT** |
| **Godot Version** | Godot 4.x | `4.7.2.stable.official.ed1daf0bf` | **COMPLIANT** |
| **Working Tree** | Clean | Clean (0 modified / 0 untracked) | **CLEAN** |

---

## 3. Automated Test Suite Execution

Command executed:
```powershell
godot --headless -s tests/core/test_runner.gd
```

### Execution Metrics
* **Command:** `godot --headless -s tests/core/test_runner.gd`
* **Exit Code:** `0`
* **Total Tests:** `532`
* **Passed Tests:** `532`
* **Failed Tests:** `0`
* **Errors:** `0`
* **Suite Duration:** `6,334 ms`

```text
[PASS] Test 8: BuildingDisplay reflects all placed buildings from BuildingState
[PASS] Coord Agreement: Placement command succeeds
[PASS] Coord Agreement: Placed building node exists in BuildingDisplay
[PASS] Coord Agreement: Preview and placed building world positions agree exactly for (22, 22)
[PASS] Coord Agreement: Both match canonical BuildingDisplayClass.grid_to_world_position
[PASS] Input 1: hotbar_4 action equips rustic_fence
[PASS] Input 1: hotbar_4 action enters preview mode
[PASS] Input 2: rotate_building action rotates orientation to 1
[PASS] Input 3: hotbar_5 action equips stone_path
[PASS] Input 3: preview building updated to stone_path
[PASS] Input 4: cancel action exits preview mode
[PASS] Input 5: interact action confirms placement and exits preview
[PASS] Input 5: Coordinate (28, 28) occupied after interact action
[PASS] Footprint 1: 1x1 building instance retrieved
[PASS] Footprint 1: 1x1 building has footprint (1, 1)
[PASS] Footprint 1: 1x1 building occupies exactly 1 cell
[PASS] Footprint 1: Occupied cell matches origin (18, 18)
[PASS] Footprint Setup: Blocker stone path placed at (31, 31)
[PASS] Footprint 2: Multi-cell footprint cannot overlap existing building
[PASS] Footprint 4: Failed footprint validation consumes zero materials
[PASS] Footprint 4: BuildingState unchanged on failed footprint validation
[PASS] Footprint 3: Multi-cell footprint cannot overlap farming plot
[PASS] Footprint 3: Wood strictly preserved on farm plot collision
[PASS] Footprint 5: Valid multi-cell placement succeeds
[PASS] Footprint 5: Exactly 4 wood consumed on valid placement
[PASS] Footprint 5: Cell (40, 40) occupied
[PASS] Footprint 5: Cell (41, 40) occupied
[PASS] Footprint 5: Cell (40, 41) occupied
[PASS] Footprint 5: Cell (41, 41) occupied
[PASS] Footprint 6: Restored state preserves shed_valid
[PASS] Footprint 6: Restored instance footprint is (2, 2)
[PASS] Footprint 6: Restored state preserves corner cell (41, 41)
==================================================
Test Results: 532 passed, 0 failed of 532 total tests.
==================================================
Underhallow Test Suite: ALL TESTS PASSED.
```

---

## 4. Player-Facing Runtime Verification (Live Game Scene)

The full player flow was exercised against [scenes/game/game.tscn](file:///c:/Users/HP/Documents/Underhallow/scenes/game/game.tscn) with live runtime subsystems and input simulation.

### 4.1 Player-Facing Fence Placement (`hotbar_4`)
1. **Selection:** Injected `hotbar_4` input action.
   * `player.is_in_building_preview` transitioned to `true`.
   * `player.preview_building_id` set to `&"rustic_fence"`.
   * UI prompt label updated to:
     ```text
     Build Rustic Fence: [E] Confirm | [R] Rotate | [Esc] Cancel
     ```
2. **Rotation:** Injected `rotate_building` (`R`).
   * Orientation incremented cleanly from `0` to `1` (90° clockwise).
3. **Targeting:** Set target coordinate to `Vector2i(20, 20)`.
   * Preview display world position: `(190.0, 300.0)`.
   * Canonical transform `BuildingDisplay.grid_to_world_position(Vector2i(20, 20))` = `(190.0, 300.0)`.
   * Exact agreement confirmed.
4. **Confirmation:** Injected `interact` (`[E]`).
   * Preview mode exited cleanly.
   * `BuildingState.has_building_at(Vector2i(20, 20))` verified `true`.
   * Placed node `Building_rustic_fence_1` rendered in `BuildingDisplay`.
   * Placed node world position: `(190.0, 300.0)`.
   * Preview vs. placed delta: `Vector2.ZERO` (`(190.0, 300.0) == (190.0, 300.0)`).
5. **Material Accounting:**
   * Starting wood: `10`. Cost of `rustic_fence`: `3 wood` ([data/buildings/rustic_fence.tres](file:///c:/Users/HP/Documents/Underhallow/data/buildings/rustic_fence.tres)).
   * Resulting wood: `7`. Exactly 3 wood deducted.

### 4.2 Player-Facing Stone Path Placement (`hotbar_5`)
1. **Selection:** Injected `hotbar_5` input action.
   * Preview mode entered with `&"stone_path"`.
   * Prompt updated: `"Build Stone Path: [E] Confirm | [R] Rotate | [Esc] Cancel"`.
2. **Targeting:** Set target coordinate to `Vector2i(21, 20)`.
   * Preview display world position: `(206.0, 300.0)`.
   * Canonical transform evaluates to `(206.0, 300.0)`.
3. **Confirmation:** Injected `interact` (`[E]`).
   * Preview mode exited cleanly.
   * `BuildingState.has_building_at(Vector2i(21, 20))` verified `true`.
   * Placed node `Building_stone_path_2` rendered in `BuildingDisplay`.
   * Placed node world position: `(206.0, 300.0)`.
   * Preview vs. placed delta: `Vector2.ZERO` (`(206.0, 300.0) == (206.0, 300.0)`).
4. **Material Accounting:**
   * Starting stone: `10`. Cost of `stone_path`: `1 stone` ([data/buildings/stone_path.tres](file:///c:/Users/HP/Documents/Underhallow/data/buildings/stone_path.tres)).
   * Resulting stone: `9`. Exactly 1 stone deducted.

---

## 5. Placement Validation, Overlap Rejection & Cancellation

### 5.1 Occupied Cell Rejection
1. Targeted already-occupied coordinate `(20, 20)` with fence preview.
2. `player.is_preview_valid()` evaluated `false`.
3. `BuildingPreviewDisplay` visually updated to invalid presentation:
   * Preview fill color updated to red indicator: `Color(0.9, 0.25, 0.2, 0.45)` (`R = 0.9`).
4. Attempted confirmation (`interact`):
   * Validation rejected placement: `"Target placement coordinate is already occupied."`.
   * Player remained in preview mode.
   * Total building instances in `BuildingState` remained strictly unchanged.
   * Zero materials deducted.

### 5.2 Preview Cancellation (`[Esc]`)
1. Entered fence preview mode.
2. Injected `cancel` action (`KEY_ESCAPE`).
3. Preview mode exited immediately (`is_in_building_preview == false`).
4. `BuildingPreviewDisplay` hidden (`visible == false`).
5. Zero building instances placed, zero materials deducted.

### 5.3 Material Depletion Gate
1. Drained inventory wood to `0`.
2. Targeted unoccupied cell `(35, 35)`.
3. `player.is_preview_valid()` evaluated `false`.
4. Confirmation attempt rejected with `"Insufficient materials to build Rustic Fence."`.
5. Cell `(35, 35)` remained unoccupied.

---

## 6. Origin Offset Robustness Analysis

Addressed the source observation recorded in Section 5 of the QA Brief:
* In [scenes/game/game.gd#L249](file:///c:/Users/HP/Documents/Underhallow/scenes/game/game.gd#L249), `_setup_world_building_display` explicitly synchronizes:
  `preview_display.origin_offset = building_display.origin_offset`
* `BuildingDisplayClass.DEFAULT_ORIGIN_OFFSET` is `Vector2(-130.0, -20.0)`.
* Active `BuildingDisplay.origin_offset` is `Vector2(-130.0, -20.0)`.
* Active `BuildingPreviewDisplay.origin_offset` is `Vector2(-130.0, -20.0)`.
* Bijective transformation verified:
  `grid_to_world_position(Vector2i(10, 15))` → `(30.0, 220.0)` → `world_to_grid_coordinate((30.0, 220.0))` → `Vector2i(10, 15)`.
* **Conclusion:** The active scene and controller transformations are fully aligned.

---

## 7. Placement Chain Certification

The complete placement pipeline operates authoritatively without client-side bypass:

```text
1. Player Input [hotbar_4 / hotbar_5]
   ↓
2. PlayerController.start_building_preview()
   ↓
3. BuildingDisplay.grid_to_world_position() [Canonical Transform]
   ↓
4. BuildingPreviewDisplay.position [Informational Render at World Pos]
   ↓ [interact / confirm_placement]
5. PlaceBuildingCommand dispatched to GameRuntime
   ↓
6. PlaceBuildingCommand.validate() [State, Duplicate, Footprint, Materials, Farming Collision]
   ↓
7. PlaceBuildingCommand._execute_mutation() [Deducts Inventory & Appends to BuildingState]
   ↓ [signal: building_placed]
8. BuildingDisplay._render_building_instance()
   ↓
9. Placed Node2D.position == Preview Position (Delta: 0.0, 0.0)
```

---

## 8. Final QA Verdict & Disposition

```text
==================================================
SURGICAL PASS 3 RUNTIME SUMMARY: 39 passed, 0 failed of 39 total checks.
==================================================
Surgical Pass 3 Verification: ALL CHECKS PASSED.
Runtime Duration: 6,572 ms
Exit Code: 0
Regressions: 0
Defects: 0
```

* **Unit & Regression Tests:** `532/532` passed.
* **Player-Facing Runtime Suite:** `39/39` passed.
* **Defects Identified:** 0.
* **Blocker Status:** Completely resolved.
* **Disposition:** **PASS — Fully accepted by QA, Integration & Release.**
* **Recommendation:** Ready for GM/PM sign-off.
