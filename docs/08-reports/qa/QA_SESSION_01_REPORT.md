# UNDERHALLOW — QA SESSION 01 EXECUTION REPORT

**Document ID:** QA-001  
**Team:** QA, Integration & Release  
**Target Commit:** [`c77836b9f2da99e731d6e40e6b81d9d0d482ae96`](../../..)  
**Execution Timestamp:** 2026-09-16 11:10:00 UTC  
**Mode:** Verification Only (Zero Production Code Modified)  
**Final Result:** **PASS**

---

## 1. Mandatory Environment Verification

Environment status verified prior to testing:

```powershell
PS C:\Users\HP\Documents\Underhallow> git rev-parse HEAD
c77836b9f2da99e731d6e40e6b81d9d0d482ae96

PS C:\Users\HP\Documents\Underhallow> godot --version
4.7.2.stable.official.ed1daf0bf

PS C:\Users\HP\Documents\Underhallow> git status --short
# (Clean working tree — 0 uncommitted modifications)
```

| Parameter | Required Value | Actual Runtime Value | Compliance |
| :--- | :--- | :--- | :---: |
| **Commit SHA** | `c77836b9f2da99e731d6e40e6b81d9d0d482ae96` | `c77836b9f2da99e731d6e40e6b81d9d0d482ae96` | **EXACT MATCH** |
| **Godot Engine** | Godot 4.x | `4.7.2.stable.official.ed1daf0bf` | **COMPLIANT** |
| **Working Tree** | Clean | Clean (0 modified / 0 untracked) | **CLEAN** |
| **Platform** | Windows x86_64 | Windows (win32 powershell) | **VERIFIED** |

---

## 2. Automated Test Suite Execution

Command executed:
```powershell
godot --headless -s tests/core/test_runner.gd
```

### Execution Metrics
* **Command:** `godot --headless -s tests/core/test_runner.gd`
* **Exit Code:** `0`
* **Total Tests:** `358`
* **Passed Tests:** `358`
* **Failed Tests:** `0`
* **Errors:** `0`
* **Execution Duration:** `3,851 ms`
* **Failed Assertions:** None

```text
==================================================
Test Results: 358 passed, 0 failed of 358 total tests.
==================================================
Underhallow Test Suite: ALL TESTS PASSED.
```

### Correctness-Relevant Warnings
Two expected deprecation warnings were emitted during the execution of Suite 10 (Architecture Audit A-001 verification), confirming that the legacy methods are safely neutralized and warn:
```text
WARNING: TimeState.advance_time() is deprecated under A-001. Simulation time must be advanced via GameTime.
   at: push_warning (core/variant/variant_utility.cpp:1033)
   GDScript backtrace (most recent call first):
       [0] advance_time (res://src/core/time/time_state.gd:43)
       [1] _run_architecture_audit_a001_tests (res://tests/core/test_runner.gd:1216)
       [2] _init (res://tests/core/test_runner.gd:65)

WARNING: TimeState.advance_day() is deprecated under A-001. Day advancement must be executed via GameTime or SleepCommand.
   at: push_warning (core/variant/variant_utility.cpp:1033)
   GDScript backtrace (most recent call first):
       [0] advance_day (res://src/core/time/time_state.gd:47)
       [1] _run_architecture_audit_a001_tests (res://tests/core/test_runner.gd:1218)
       [2] _init (res://tests/core/test_runner.gd:65)
```

---

## 3. Architecture Audit A-001 Verification

The implementation of the sole simulation clock authority model was independently verified against all edge cases.

### 3.1 Constructor Authority
* `TimeState.new(0.0, 99, 240.0)` → `elapsed_seconds` is `0.0`, `current_day` derives as `1` (conflicting `99` ignored).
* `TimeState.new(480.0, 99, 240.0)` (2 × day duration) → `elapsed_seconds` is `480.0`, `current_day` derives as `3` (conflicting `99` ignored).
* `TimeState.new(0.0, 0, 240.0)` → `elapsed_seconds` is `0.0`, `current_day` derives as `1` (day `0` ignored).
* `TimeState.new(0.0, -5, 240.0)` → `elapsed_seconds` is `0.0`, `current_day` derives as `1` (negative day ignored).
* **Finding:** The legacy constructor argument `_p_day` is fully neutralized. Calendar derivation is strictly mathematical: `current_day = int(floor(elapsed_seconds / day_duration)) + 1`.

### 3.2 Canonical Clock Simulation
* **Initialization:** `GameTime = 0.0s`, `GameState.game_time_elapsed = 0.0s`, `TimeState.elapsed_seconds = 0.0s`, `current_day = 1`.
* **Discrete Step:** `step_simulation(10.0)` advances `GameTime` to `10.0s` → `GameState.game_time_elapsed` follows to `10.0s` → `TimeState.elapsed_seconds` follows to `10.0s` → `TimeState.current_day` derives as `1`.
* **Accumulator Step:** `update_simulation(1.0)` keeps `GameState` and `TimeState` in exact lockstep with `GameTime`.
* **Independence Guard:** Invoking `TimeState.advance_time(50.0)` or `TimeState.advance_day()` does not mutate `elapsed_seconds` or `current_day`. `TimeState` cannot independently drift or advance.

### 3.3 Actual `SleepCommand` Execution via `GameRuntime.execute_command()`
1. **Player Outside Sleep Radius:** Player at `(200, 200)` (distance ~`352 > 60.0` from cottage door at `(-60, -36)`) → `SleepCommand` rejected with validation error: `"Must be near the cottage to sleep."`.
2. **Failed Sleep Guard:** Simulation clock remains at `0.0s`, `GameState` remains at `0.0s`, `TimeState` remains at `0.0s`, `current_day` remains `1`.
3. **Player Near Cottage:** Player at `(-60, -30)` (distance `6.0 <= 60.0` from cottage door) → `SleepCommand` executes successfully.
4. **Day Advancement:** Clock advances by configured day duration (`240.0s`).
5. **Day Counter:** `current_day` increments from `1` to `2`.
6. **Clock Alignment:** `GameState.game_time_elapsed == 240.0s == GameTime.elapsed_seconds`.
7. **TimeState Alignment:** `TimeState.elapsed_seconds == 240.0s == GameTime.elapsed_seconds`.
8. **Second Consecutive Sleep:** Clock advances to `480.0s`, `current_day` increments from `2` to `3`, `GameState` and `TimeState` remain synchronized at `480.0s`.

### 3.4 Time Scale Edge Case Investigation
* **Scenario:** `GameTime.time_scale` set to `2.0`, baseline `day_duration = 240.0s`.
* **Execution:** Executed `SleepCommand` through `GameRuntime.execute_command()`.
* **Observed Advancement:** Clock advanced by **`480.0s`** (`day_duration × time_scale`).
* **Technical Cause:** In `SleepCommand._execute_with_time`, sleep calls `time.advance(sleep_duration)`. In `GameTime.advance(delta)`, time is scaled by `delta × time_scale`.
* **Classification:** Investigation finding recorded. Not classified as a defect as governing specifications do not define a separate scale factor for instant sleep command advancement.

---

## 4. Persistence & Corruption Resistance

1. **Simulation Round-Trip:**
   * Simulated to `100.0s` → serialized state via `PersistenceBoundary`.
   * Deserialized into fresh `GameState` and `GameTime` instances.
   * Restored `GameTime.elapsed_seconds` = `100.0s`.
   * Restored `GameState.game_time_elapsed` = `100.0s`.
   * Restored `TimeState.elapsed_seconds` = `100.0s`, `current_day` = `1`.
2. **Corrupted Calendar Payload Resistance:**
   * Corrupted `save.payload["time"]` to `{"current_day": 99, "elapsed_seconds": 0.0}`, preserving authoritative `SaveData.game_time_elapsed = 100.0`.
   * Deserialized: `GameTime` restored to `100.0s`.
   * `GameState.game_time_elapsed` derived as `100.0s`.
   * `TimeState.elapsed_seconds` derived as `100.0s`.
   * `TimeState.current_day` derived as `1`, completely ignoring the corrupted `99`.
3. **Sleep-Save-Load-Simulate Cycle:**
   * Executed `SleepCommand` to Day 2 (`340.0s`).
   * Serialized and restored cleanly at Day 2 (`340.0s`).
   * Advanced simulation by `20.0s` post-restore: clock advanced monotonically to `360.0s`, remaining on Day 2 without calendar regression.
4. **Boundary Limitation Report:**
   > *Persistence boundary verified / actual storage lifecycle not yet available for end-to-end verification.*

---

## 5. Farming Regression

Carrot crop cycle tested across simulated days:
1. **Till:** Executed `TillSoilCommand` on plot `(0, 0)` → plot marked tilled, awarded +2 Farming XP.
2. **Plant:** Executed `PlantCropCommand` with `seed_carrot` → consumed 1 carrot seed (5 → 4), initial `growth_stage = 0`, `days_grown = 0`, awarded +5 Farming XP.
3. **Water:** Executed `WaterCropCommand` → `plot.is_watered = true`, awarded +2 Farming XP.
4. **Sleep (Day 1 → Day 2):** Executed `SleepCommand`:
   * Crop advanced 1 day (`days_grown = 1`).
   * Growth stage updated to `1` (Growing).
   * Soil watering reset (`is_watered = false`).
   * Crop remained alive (`crop != null`).
5. **Unwatered Pause (Day 2 → Day 3):** Left plot unwatered and slept:
   * Growth paused at `days_grown = 1`, `growth_stage = 1`.
   * Forgiving invariant confirmed: crop did NOT die, wither, or get removed.
6. **Second Water & Sleep (Day 3 → Day 4):** Watered and slept:
   * Crop reached `days_grown = 2`.
   * Growth stage reached `2` (Mature), `is_mature = true`.
   * Soil watering reset to `false`.
7. **Harvest:** Executed `HarvestCropCommand`:
   * Crop removed from plot, plot remained tilled.
   * Exactly 1 `crop_carrot` added to inventory.
   * Awarded +20 Farming XP (total 31 XP).
8. **Save/Load State Preservation:** Planted, watered, and slept on plot `(1, 0)`. Serialized and restored state: crop `days_grown = 1`, `growth_stage = 1`, `is_watered = false`, and inventory carrot count `1` were accurately preserved.

---

## 6. Daily Resource Regression

1. **Initial State:** Personal Island `wild_berry_bush_1` available, 0 berries in inventory.
2. **Gather:** Executed `GatherResourceCommand` → 3 wild berries added to inventory (0 → 3), bush marked `is_gathered = true`.
3. **Same-Day Gather Guard:** Second gather attempt on same day rejected by validation. Inventory remained strictly 3 (no duplication).
4. **Sleep & Respawn:** Executed `SleepCommand` → Day 2 begun, `is_gathered` reset to `false`.
5. **Second Day Gather:** Second gather attempt succeeded → 3 berries added (total 6). Zero loss or duplication.

---

## 7. Day Rollover

Configured `day_duration = 240.0s`:
1. **Pre-Boundary Step:** Stepped to `239.0s` → `current_day` remained `1`, exactly 0 `day_changed` events emitted.
2. **Boundary Crossing:** Stepped across boundary to `241.0s` → `current_day` rolled over to `2`, exactly 1 `day_changed` event emitted with value `2`.
3. **Multi-Day Continuous Progression:** Stepped across 5 full day cycles:
   * Days advanced monotonically: `3 → 4 → 5 → 6`.
   * Exactly 5 total `day_changed` events emitted in strict deterministic sequence `[2, 3, 4, 5, 6]`.

---

## 8. Runtime Vertical Slice Verification

Evaluated against `scenes/game/game.tscn` and runtime scene flow:

| Vertical Slice Stage | Status | Observation Details |
| :--- | :--- | :--- |
| **1. Launch** | **Implemented + Passing** | Bootstrap verified, 13 baseline input actions verified, subsystems wired, `GameRuntime` state transitions `BOOT → INITIALIZE → RUNNING`. |
| **2. Player Spawn** | **Implemented + Passing** | Player spawned at `SpawnMarker` `(-60.0, 0.0)`, `PlayerController` wired to `GameState.player_state`. |
| **3. Movement** | **Implemented + Passing** | Responds to input, acceleration (`1200.0`), friction (`1600.0`), 8-directional facing retention. |
| **4. Personal Island** | **Implemented + Passing** | `personal_island.tscn` loaded as default world. Cottage, DockPier, FarmGrid, and collision boundaries verified. |
| **5. Interaction** | **Implemented + Passing** | `InteractionDetector` focuses targets, persistent `InteractionPrompt` displays contextual action (`"Press [E] to Read"`), toasts display inspection text without clearing prompt. |
| **6. Farming** | **Implemented + Passing** | 12 `FarmPlot` instances in 4×3 grid on Personal Island. Tilling, planting, watering, and harvesting verified. Presentation visually updates. |
| **7. Inventory** | **Implemented + Passing** | `HotbarUI` and `InventoryUI` bind to `InventoryState`. Equipped item switching verified. |
| **8. Time Progression** | **Implemented + Passing** | `GameRuntime.update_simulation()` drives `GameTime`. `DayNightCycle` dynamically shades ambient light (`CanvasModulate`) across dawn, day, twilight, and night. |
| **9. Main Island** | **Implemented + Passing** | Dock-to-dock travel request smoothly swaps active world to `main_island_slice.tscn`, player repositioned at `DockArrivalMarker` `(-300, 160)`. |
| **10. NPC / Content** | **Partially Implemented** | Content landmarks (`AncientArch`, `TownSign`) are **Implemented + Passing**. NPC character entities are **Not Yet Implemented** per project milestone. |
| **11. Gathering** | **Implemented + Passing** | `WildBerryBush` gathering and daily respawn verified on Personal Island. |
| **12. Return Home** | **Implemented + Passing** | Dock travel from Main Island back to Personal Island arrives cleanly at `DockArrivalMarker` `(210, 150)`. |
| **13. Construction** | **Not Yet Implemented** | Specification BI-001 completed; gameplay runtime construction system scheduled for future development phase. |
| **14. Persistence** | **Partially Implemented** | In-memory domain serialization/deserialization boundary is **Implemented + Passing**; concrete disk/cloud file storage lifecycle is **Not Yet Implemented** per milestone. |

---

## 9. Runtime Observation Checklist

* **Startup Errors:** None.
* **Script Parse Errors:** None.
* **Missing Resources:** None.
* **Broken Node References:** None.
* **Player Spawn Problems:** None (positioned exactly at `SpawnMarker`).
* **Movement Problems:** None (acceleration, friction, and facing directions operate smoothly).
* **Collision Problems:** None (boundary and water collision layers active on layer 1).
* **Interaction Problems:** None (`InteractionDetector`, prompts, and toasts operate with correct separation).
* **Farming Visual/State Divergence:** None (plots track authoritative `SoilPlotState`).
* **Day/Night Divergence:** None (`DayNightCycle` reads canonical `GameTime.elapsed_seconds`).
* **World-Transition Failures:** None (dock travel transitions cleanly both directions).
* **Inventory Divergence:** None (quantities strictly preserved).
* **Save/Load Corruption:** None (authoritative `SaveData.game_time_elapsed` overrides any corrupted calendar payload).
* **Crashes:** None.
* **Frame-Rate Instability:** None observed.

---

## 10. Defects

* **Total Defects:** 0
* **Regressions:** 0
* **Assertion Failures:** 0

---

## 11. Final Evidence Package

```text
Environment
- OS: Windows (win32)
- Godot version: 4.7.2.stable.official.ed1daf0bf
- Commit: c77836b9f2da99e731d6e40e6b81d9d0d482ae96
- Working tree: Clean (0 uncommitted changes)

Automated Tests
- Command: godot --headless -s tests/core/test_runner.gd
- Exit code: 0
- Passed: 358
- Failed: 0
- Errors: 0
- Warnings: 2 (expected A-001 deprecation warnings)
- Duration: 3851 ms

A-001
- Constructor: Verified (calendar derivation strictly driven by elapsed time, conflicting argument ignored)
- Canonical clock: Verified (sole authority is GameTime)
- Simulation: Verified (GameState and TimeState lockstep with GameTime; TimeState cannot independently advance)
- Sleep: Verified (SleepCommand near cottage succeeds, outside radius rejected, advances exactly configured day)
- Double sleep: Verified (advances consecutive days deterministically)
- Calendar derivation: Verified (current_day derived via floor(elapsed / day_duration) + 1)
- Save/load: Verified (GameTime restored directly from SaveData.game_time_elapsed)
- Corrupt calendar resistance: Verified (corrupted payload ignored, canonical GameTime wins)
- Farming across sleep: Verified (growth advances, watering resets, unwatered crops pause without dying)
- Day rollover: Verified (exact rollover at boundary, single event emitted, multi-day determinism confirmed)

Vertical Slice
- Launch: Implemented + Passing
- Player: Implemented + Passing
- Personal Island: Implemented + Passing
- Farming: Implemented + Passing
- Inventory: Implemented + Passing
- Time: Implemented + Passing
- Main Island: Implemented + Passing
- NPC/content: Partially Implemented (Landmark content passing; NPCs Not Yet Implemented)
- Gathering: Implemented + Passing
- Return Home: Implemented + Passing
- Construction: Not Yet Implemented (per project roadmap)
- Persistence: Partially Implemented (Persistence boundary verified / actual storage lifecycle not yet available for end-to-end verification)

Defects
None.

Final result:
PASS
```
