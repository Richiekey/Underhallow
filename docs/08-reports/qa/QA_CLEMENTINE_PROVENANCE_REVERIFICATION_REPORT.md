# UNDERHALLOW — QA, INTEGRATION & RELEASE

# QA-003 — Clementine Provenance Correction Re-verification
*(Repository QA Report Series: QA-004)*

**Target Commit:** [`5dc21826e59d7a9ff9d8b56c7d27c3e71eb15eb2`](../../..)  
**Baseline:** `6e4bc25c6ef2632fe5db9461bae8ede9a912aa38`  
**Execution Timestamp:** 2026-09-18 19:40:00 UTC  
**Owner:** QA / Integration & Release  
**Governance:** EDP-001 (Execution & Documentation Protocol)  

---

## Environment

* **Godot:** `4.7.2.stable.official.ed1daf0bf`
* **Platform:** Windows x86_64 (`win64`)
* **Automated Test Command:** `godot --headless -s res://tests/core/test_runner.gd`
* **Tests:** `677`
* **Passed:** `677`
* **Failed:** `0`
* **Errors:** `0`
* **Exit Code:** `0`
* **Working Tree:** Clean (`git status --short` empty; 0 uncommitted modifications)

---

## Provenance Matrix

### 1. Insufficient berries (< 3 berries, no Raw Hide): PASS
* State: 2 Wild Berries, 0 Raw Hide in inventory; HuntingState empty.
* Evaluation: `ProgressionState.can_complete_clementine_objective()` returns `false`.
* Command Validation: `CompleteObjectiveCommand.validate()` returns error:
  `"Insufficient Wild Berries: have 2, need 3."`
* State Mutation: Objective remains `ACTIVE`; Farming XP remains `0`; no inventory items mutated.

### 2. Insufficient berries with Raw Hide (Raw Hide ≥ 1, Wild Berries < 3): PASS
* State: 2 Wild Berries, 1 Raw Hide in inventory; registered defeated and harvested hare in HuntingState.
* Evaluation: `ProgressionState.can_complete_clementine_objective()` returns `false`.
* Command Validation: `CompleteObjectiveCommand.validate()` returns error:
  `"Insufficient Wild Berries: have 2, need 3."`
* State Mutation: Objective remains `ACTIVE`; Farming XP remains `0`; no reward granted.

### 3. Zero registered hares: PASS *(Critical Historical Defect)*
* State: 3 Wild Berries, 1 Raw Hide in inventory; `HuntingState.get_all_creatures().size() == 0` (zero registered creatures).
* Evaluation: `ProgressionState.can_complete_clementine_objective(inv, hunt)` returns `false`.
* Null Safety: `ProgressionState.can_complete_clementine_objective(inv, null)` returns `false`.
* Command Validation: `CompleteObjectiveCommand.validate()` returns error:
  `"Raw Hide must be obtained by harvesting a defeated forest hare."`
* State Mutation: Objective remains `ACTIVE`; Farming XP unchanged (`0 XP`); reward granted flag remains `false`.
* **Resolution Confirmed:** The previous blocking defect in baseline `6e4bc25` is completely resolved. Possessing resources without registered harvested hares can no longer satisfy Clementine's objective under any circumstances.

### 4. Unharvested hare: PASS
* State: 3 Wild Berries, 1 Raw Hide in inventory; registered forest hare exists at full 10 HP (`is_harvested == false`).
* Evaluation: `ProgressionState.can_complete_clementine_objective()` returns `false`.
* Command Validation: `CompleteObjectiveCommand.validate()` returns error:
  `"Raw Hide must be obtained by harvesting a defeated forest hare."`
* State Mutation: Objective remains `ACTIVE`; Farming XP remains `0`.

### 5. Harvested non-hare: PASS
* State: 3 Wild Berries, 1 Raw Hide in inventory; non-hare creature (`fox`) defeated and harvested (`is_harvested == true`); forest hare exists but is unharvested.
* Evaluation: `ProgressionState.can_complete_clementine_objective()` returns `false`.
* Command Validation: `CompleteObjectiveCommand.validate()` returns error:
  `"Raw Hide must be obtained by harvesting a defeated forest hare."`
* State Mutation: Objective remains `ACTIVE`; Farming XP remains `0`.

### 6. Harvested forest hare: PASS
* State: 3 Wild Berries, 1 Raw Hide in inventory; registered forest hare (`definition_id == &"hare"`) defeated at 0 HP and harvested (`is_harvested == true`).
* Evaluation: `ProgressionState.can_complete_clementine_objective()` returns `true`.
* Command Validation: `CompleteObjectiveCommand.validate()` returns `success == true`.
* State Mutation: Execution transitions `clementine_objective_state` to `COMPLETED`; sets `clementine_reward_granted = true`; awards exactly `+20 Farming XP`.
* Resource Preservation: Inventory retains 3 Wild Berries and 1 Raw Hide (zero items consumed).

### 7. No Clementine return: PASS
* State: 3 Wild Berries, 1 Raw Hide in inventory; harvested forest hare confirmed in HuntingState. Player has NOT returned to Clementine.
* Automatic Completion: Objective remains `ACTIVE`; zero Farming XP awarded. Gathering resources alone does not complete the task.
* Distance Validation: Dispatching `CompleteObjectiveCommand` while player is outside interaction distance (> 60.0 px) fails validation with message:
  `"Too far away to complete objective with Clementine."`
* State Mutation: Objective remains `ACTIVE`.

### 8. Successful completion: PASS
* State: Player returns to Clementine within interaction range (distance ≤ 60.0 px).
* Interaction: Clementine prompt dynamically updates to `"Deliver Supplies to Clementine"`.
* Interaction Execution: Clementine interact hook executes `CompleteObjectiveCommand`.
* Dialogue: Clementine delivers `COMPLETE_DIALOGUE`.
* State Mutation: Objective transitions to `COMPLETED`; exactly `+20 Farming XP` granted; visual label returns to `Clementine\nGeneral Store`.

### 9. Repeated completion: PASS
* Subsequent Interaction: Interacting with Clementine post-completion delivers `POST_COMPLETE_DIALOGUE` without re-triggering completion.
* Duplicate Command Validation: Direct `CompleteObjectiveCommand` execution rejects validation with error:
  `"Clementine's objective has already been completed."`
* Duplicate Accept Validation: Direct `AcceptObjectiveCommand` execution rejects validation with error:
  `"Clementine's objective has already been completed."`
* State Mutation: Farming XP remains strictly `20`; duplicate rewards are authoritatively prevented.

---

## Narrative Lifecycle: PASS

The full player-facing narrative progression was verified through independent live scene execution:
```text
Talk to Clementine (INACTIVE -> Prompt: "Talk to Clementine" -> Dialogue: INTRO_DIALOGUE)
-> Accept objective (Transitions to ACTIVE -> Label: "Clementine\n(Needs Supplies)")
-> Collect 3 Wild Berries (Incomplete reminder: "3/3 Wild Berries | 0/1 Raw Hide")
-> Hunt/harvest forest hare (Hare defeated -> Harvested -> 1 Raw Hide in inventory)
-> Obtain Raw Hide (Prompt transitions to: "Deliver Supplies to Clementine")
-> Return to Clementine (Proximity check <= 60.0 px verified)
-> Completion dialogue (Dialogue: COMPLETE_DIALOGUE -> Label: "Clementine\nGeneral Store")
-> +20 Farming XP (State becomes COMPLETED -> Farming XP: 20)
```

---

## Persistence: PASS

Save/load round-tripping was verified across the persistence boundary (`PersistenceBoundary` and `SaveData` Schema Version 1):
* **ACTIVE State:** An active objective with partial inventory (2 Wild Berries) was saved and restored. Deserialized state confirmed `clementine_objective_state == ACTIVE`, `clementine_reward_granted == false`, and inventory intact.
* **COMPLETED State:** A legitimately completed objective was saved and restored. Deserialized state confirmed `clementine_objective_state == COMPLETED`, `clementine_reward_granted == true`, `farming_xp == 20`, and inventory intact.
* **Hunting Provenance Persistence:** Serialized `hunting` payload retained `island_hare` with `is_harvested == true`.
* **Post-Reload Exploit Guard:** Dispatching `CompleteObjectiveCommand` against reloaded state failed validation (`"Clementine's objective has already been completed."`). Farming XP remained strictly 20.

---

## Resource Preservation: PASS

Inspection of player inventory following objective completion confirmed:
* `resource_wild_berries`: Exactly 3 preserved (not consumed).
* `resource_raw_hide`: Exactly 1 preserved (not consumed).
* Unrelated inventory items (`resource_wood`: 15): Preserved without modification.
* Strictly satisfies the locked Phase 4 narrative vertical slice specification.

---

## Regression: PASS

The complete automated test runner (`godot --headless -s res://tests/core/test_runner.gd`) passed with zero failures:
* **Total Tests:** 677 / 677 passed cleanly.
* **Full Domain Coverage:** Zero regressions observed in Farming plot lifecycle, Building footprint validation and coordinate transforms, Hunting state/combat pipeline, Player movement and hotbar integration, Time/day-night simulation, or Persistence serialization.

---

## Architecture/Scope: PASS

Inspection of commit `5dc21826e59d7a9ff9d8b56c7d27c3e71eb15eb2` confirms strict architectural boundaries:
* **Files Modified:** Exactly 3 files:
  1. `src/core/commands/complete_objective_command.gd` (+12, -14)
  2. `src/gameplay/progression/progression_state.gd` (+11, -17)
  3. `tests/core/test_runner.gd` (+35, -9)
* `ProgressionState` remains authoritative for Clementine completion eligibility (`can_complete_clementine_objective`).
* `CompleteObjectiveCommand` remains the single command authority for completion validation and execution.
* Existing `HuntingState` is reused directly for hare provenance verification.
* Zero duplicate hunting or resource systems were introduced.
* Zero generic quest, provenance, or dialogue frameworks were introduced.
* `scenes/game/game.gd` was not modified.
* Save schema remains fully compatible (Schema Version 1).
* Zero scope expansion detected.

---

## Defects

**None.**

---

## Independent QA Evidence

1. **Test Runner Execution:**
   * Command: `godot --headless -s res://tests/core/test_runner.gd`
   * Outcome: Exit code `0`, `677 passed, 0 failed of 677 total tests`, duration `5.34s`.
2. **Dedicated Independent QA Verification Script:**
   * Script: `scratch/qa_clementine_provenance_verification.gd` (executed headless in Godot Engine `4.7.2.stable.official.ed1daf0bf`).
   * Outcome: Exit code `0`, `111 passed, 0 failed of 111 total checks`.
   * Specifically verified:
     * Case 3 (Zero hares): Authoritative predicate rejection and command validation rejection verified.
     * Case 4 (Unharvested hare): Rejection verified.
     * Case 5 (Harvested non-hare): Rejection verified.
     * Case 6 (Harvested forest hare): Approval verified.
     * Distance guard (> 60.0 px): Rejection verified.
     * Idempotence & Save/Load exploit guard: Verified.
3. **Repository Cleanliness:**
   * `git status --short` verified completely clean with 0 dirty or untracked changes.

---

## Implementer Evidence

* Commit message on `5dc21826e59d7a9ff9d8b56c7d27c3e71eb15eb2`:
  `fix(narrative): enforce forest hare harvest provenance in Clementine completion contract`
* Implementer test updates in `tests/core/test_runner.gd`:
  * Added test assertions `Narrative 9A` (zero hares), `9B` (unharvested hare), `9C` (harvested non-hare), and `9D` (harvested hare).
  * Reported 677 passing tests.

---

## Final Disposition

**🟢 PASS**

---

## Recommendation

Commit `5dc21826e59d7a9ff9d8b56c7d27c3e71eb15eb2` completely and surgically resolves the blocking provenance defect, preserves the authoritative architecture and domain whitelists, and satisfies all acceptance criteria for the Phase 4 Clementine Narrative Slice. It is **recommended for immediate GM/PM acceptance**.
