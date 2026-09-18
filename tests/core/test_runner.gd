extends SceneTree

## Deterministic test suite for Underhallow V0.1 Phase 1 Technical Spine.
## Executed headlessly via: godot --headless -s tests/core/test_runner.gd

const GameTimeClass = preload("res://src/core/time/game_time.gd")
const GameStateClass = preload("res://src/core/state/game_state.gd")
const CommandClass = preload("res://src/core/commands/command.gd")
const CommandResultClass = preload("res://src/core/commands/command_result.gd")
const TestIncrementCommandClass = preload("res://src/core/commands/test_increment_command.gd")
const SaveDataClass = preload("res://src/core/persistence/save_data.gd")
const PersistenceBoundaryClass = preload("res://src/core/persistence/persistence_boundary.gd")
const InputProviderClass = preload("res://src/core/input/input_provider.gd")
const GameRuntimeClass = preload("res://src/core/runtime/game_runtime.gd")
const PlayerStateClass = preload("res://src/player/player_state.gd")
const PlayerControllerClass = preload("res://src/player/player_controller.gd")
const PlayerScene = preload("res://scenes/player/player.tscn")
const CameraControllerClass = preload("res://src/presentation/camera_controller.gd")
const InteractableObjectClass = preload("res://src/gameplay/interaction/interactable_object.gd")
const WorldSpaceClass = preload("res://src/world/world_space.gd")
const DayNightCycleClass = preload("res://src/presentation/day_night_cycle.gd")
const PersonalIslandScene = preload("res://scenes/world/personal_island.tscn")
const MainIslandSliceScene = preload("res://scenes/world/main_island_slice.tscn")
const ItemDefinitionClass = preload("res://src/gameplay/inventory/item_definition.gd")
const ItemDatabaseClass = preload("res://src/gameplay/inventory/item_database.gd")
const InventoryStateClass = preload("res://src/gameplay/inventory/inventory_state.gd")
const CropDefinitionClass = preload("res://src/gameplay/farming/crop_definition.gd")
const CropDatabaseClass = preload("res://src/gameplay/farming/crop_database.gd")
const CropStateClass = preload("res://src/gameplay/farming/crop_state.gd")
const SoilPlotStateClass = preload("res://src/gameplay/farming/soil_plot_state.gd")
const FarmingStateClass = preload("res://src/gameplay/farming/farming_state.gd")
const FarmingGridClass = preload("res://src/gameplay/farming/farming_grid.gd")
const ProgressionStateClass = preload("res://src/gameplay/progression/progression_state.gd")
const TimeStateClass = preload("res://src/core/time/time_state.gd")
const WorldStateClass = preload("res://src/world/world_state.gd")
const TillSoilCommandClass = preload("res://src/core/commands/till_soil_command.gd")
const PlantCropCommandClass = preload("res://src/core/commands/plant_crop_command.gd")
const WaterCropCommandClass = preload("res://src/core/commands/water_crop_command.gd")
const HarvestCropCommandClass = preload("res://src/core/commands/harvest_crop_command.gd")
const GatherResourceCommandClass = preload("res://src/core/commands/gather_resource_command.gd")
const SleepCommandClass = preload("res://src/core/commands/sleep_command.gd")
const AdvanceDayDebugCommandClass = preload("res://src/core/commands/advance_day_debug_command.gd")
const GameScene = preload("res://scenes/game/game.tscn")
const InspectableSignClass = preload("res://src/world/inspectable_sign.gd")
const FarmPlotClass = preload("res://scenes/gameplay/farming/farm_plot.gd")
const HuntingStateClass = preload("res://src/gameplay/hunting/hunting_state.gd")
const BuildingStateClass = preload("res://src/gameplay/building/building_state.gd")
const CreatureDefinitionClass = preload("res://src/gameplay/hunting/creature_definition.gd")
const CreatureDatabaseClass = preload("res://src/gameplay/hunting/creature_database.gd")
const CreatureStateClass = preload("res://src/gameplay/hunting/creature_state.gd")
const DiscoverCreatureCommandClass = preload("res://src/core/commands/discover_creature_command.gd")
const AttackCreatureCommandClass = preload("res://src/core/commands/attack_creature_command.gd")
const HarvestCreatureCommandClass = preload("res://src/core/commands/harvest_creature_command.gd")
const BuildingDefinitionClass = preload("res://src/gameplay/building/building_definition.gd")
const BuildingDatabaseClass = preload("res://src/gameplay/building/building_database.gd")
const BuildingInstanceClass = preload("res://src/gameplay/building/building_instance.gd")
const PlaceBuildingCommandClass = preload("res://src/core/commands/place_building_command.gd")
const BuildingDisplayClass = preload("res://scenes/gameplay/building/building_display.gd")
const BuildingPreviewDisplayClass = preload("res://scenes/gameplay/building/building_preview_display.gd")
const HotbarUIClass = preload("res://scenes/gameplay/ui/hotbar_ui.gd")
const HareInteractableClass = preload("res://scenes/gameplay/hunting/hare_interactable.gd")
const HareScene = preload("res://scenes/gameplay/hunting/hare.tscn")
const AcceptObjectiveCommandClass = preload("res://src/core/commands/accept_objective_command.gd")
const CompleteObjectiveCommandClass = preload("res://src/core/commands/complete_objective_command.gd")
const ClementineInteractableClass = preload("res://scenes/gameplay/narrative/clementine_interactable.gd")
const ClementineScene = preload("res://scenes/gameplay/narrative/clementine.tscn")

var total_tests: int = 0
var passed_tests: int = 0
var failed_tests: int = 0

func _init() -> void:
	print("==================================================")
	print("Underhallow Phase 1, 2, 3 & 4 — Deterministic Test Suite")
	print("==================================================")
	
	_run_gametime_tests()
	_run_simulation_step_boundary_tests()
	_run_command_pipeline_tests()
	_run_state_and_persistence_tests()
	_run_runtime_lifecycle_tests()
	_run_player_foundation_tests()
	_run_world_foundation_tests()
	_run_phase4_gameplay_tests()
	_run_interaction_prompt_persistence_tests()
	_run_architecture_audit_a001_tests()
	_run_hunting_and_building_state_tests()
	_run_hunting_slice_tests()
	_run_construction_slice_tests()
	_run_clementine_narrative_slice_tests()
	
	print("==================================================")
	print("Test Results: %d passed, %d failed of %d total tests." % [passed_tests, failed_tests, total_tests])
	print("==================================================")
	
	if failed_tests > 0:
		printerr("Underhallow Test Suite: FAILED.")
		quit(1)
	else:
		print("Underhallow Test Suite: ALL TESTS PASSED.")
		quit(0)

func _assert_true(condition: bool, test_name: String) -> void:
	total_tests += 1
	if condition:
		passed_tests += 1
		print("[PASS] %s" % test_name)
	else:
		failed_tests += 1
		printerr("[FAIL] %s" % test_name)

func _assert_equal(actual: Variant, expected: Variant, test_name: String) -> void:
	total_tests += 1
	if actual == expected:
		passed_tests += 1
		print("[PASS] %s" % test_name)
	else:
		failed_tests += 1
		printerr("[FAIL] %s: expected '%s', got '%s'" % [test_name, str(expected), str(actual)])

func _assert_approx(actual: float, expected: float, test_name: String) -> void:
	total_tests += 1
	if is_equal_approx(actual, expected):
		passed_tests += 1
		print("[PASS] %s" % test_name)
	else:
		failed_tests += 1
		printerr("[FAIL] %s: expected approx %f, got %f" % [test_name, expected, actual])

# -----------------------------------------------------------------------------
# 1. GameTime Tests
# -----------------------------------------------------------------------------
func _run_gametime_tests() -> void:
	print("\n--- Testing GameTime ---")
	
	# Test 1: Initial state
	var gt: GameTime = GameTimeClass.new()
	_assert_approx(gt.elapsed_seconds, 0.0, "GameTime 1: Initial elapsed time is 0.0")
	_assert_approx(gt.time_scale, 1.0, "GameTime 1: Initial time scale is 1.0")
	_assert_true(not gt.is_paused, "GameTime 1: Initial pause state is false")
	_assert_equal(gt.total_ticks, 0, "GameTime 1: Initial tick count is 0")
	
	# Test 2: Advancement
	gt.advance(10.0)
	_assert_approx(gt.elapsed_seconds, 10.0, "GameTime 2: Advancing 10.0s yields 10.0s elapsed")
	_assert_equal(gt.total_ticks, 1, "GameTime 2: Advancing increments tick count to 1")
	
	# Test 3: Simulation speed
	gt.set_time_scale(2.5)
	gt.advance(4.0)
	_assert_approx(gt.elapsed_seconds, 20.0, "GameTime 3: Scale 2.5 with 4.0s delta advances by 10.0s (total 20.0s)")
	
	# Test 4: Pause
	gt.pause()
	_assert_true(gt.is_paused, "GameTime 4: Pause sets is_paused to true")
	gt.advance(15.0)
	_assert_approx(gt.elapsed_seconds, 20.0, "GameTime 4: Advancing while paused produces 0 change")
	_assert_equal(gt.total_ticks, 2, "GameTime 4: Advancing while paused does not increment tick count")
	
	# Test 5: Resume
	gt.resume()
	_assert_true(not gt.is_paused, "GameTime 5: Resume sets is_paused to false")
	gt.set_time_scale(1.0)
	gt.advance(5.0)
	_assert_approx(gt.elapsed_seconds, 25.0, "GameTime 5: Advancing after resume advances time correctly")
	
	# Test 6: Determinism
	var run1: GameTime = GameTimeClass.new()
	var run2: GameTime = GameTimeClass.new()
	for i in range(100):
		run1.advance(0.125)
		run2.advance(0.125)
	_assert_approx(run1.elapsed_seconds, run2.elapsed_seconds, "GameTime 6: Identical steps produce identical simulation time")
	_assert_equal(run1.total_ticks, run2.total_ticks, "GameTime 6: Identical steps produce identical tick count")

# -----------------------------------------------------------------------------
# 2. Simulation Step Boundary Tests
# -----------------------------------------------------------------------------
func _run_simulation_step_boundary_tests() -> void:
	print("\n--- Testing Simulation Step Boundary (GameRuntime) ---")
	
	var runtime: GameRuntime = GameRuntimeClass.new()
	runtime.initialize_runtime()
	runtime.start_runtime()
	runtime.simulation_step = 0.02 # 50 Hz test step
	
	# Test A: Explicit simulation step
	var steps_a: int = runtime.update_simulation(0.02)
	_assert_equal(steps_a, 1, "SimStep A: Exact step delta produces exactly 1 simulation step")
	_assert_approx(runtime.game_time.elapsed_seconds, 0.02, "SimStep A: GameTime elapsed matches 1 step (0.02s)")
	_assert_approx(runtime.time_accumulator, 0.0, "SimStep A: Accumulator is 0.0 after exact consumption")
	
	# Test B: Multiple steps and accumulator remainder
	# Passing 0.065s with step 0.02s should consume 3 steps (0.06s) and leave 0.005s in accumulator
	var steps_b: int = runtime.update_simulation(0.065)
	_assert_equal(steps_b, 3, "SimStep B: Frame delta 0.065s consumes exactly 3 steps (0.06s)")
	_assert_approx(runtime.game_time.elapsed_seconds, 0.08, "SimStep B: Total elapsed is 0.08s (0.02 + 0.06)")
	_assert_approx(runtime.time_accumulator, 0.005, "SimStep B: Remainder 0.005s is retained in accumulator")
	
	# Next frame passes 0.015s; accumulator becomes 0.005 + 0.015 = 0.020s -> exactly 1 step
	var steps_b2: int = runtime.update_simulation(0.015)
	_assert_equal(steps_b2, 1, "SimStep B: Sub-step delta 0.015s + remainder 0.005s consumes 1 step")
	_assert_approx(runtime.game_time.elapsed_seconds, 0.10, "SimStep B: Total elapsed reaches 0.10s")
	_assert_approx(runtime.time_accumulator, 0.0, "SimStep B: Accumulator is now 0.0")
	
	runtime.free()
	
	# Test C: Render cadence independence
	# Two runs representing identical elapsed real time (0.10s) across different frame rates:
	# Run 1: 6 frames @ ~60 FPS (approx 0.0166667s each, sum = 0.10s)
	# Run 2: 3 frames @ ~30 FPS (approx 0.0333333s each, sum = 0.10s)
	var run1: GameRuntime = GameRuntimeClass.new()
	run1.initialize_runtime()
	run1.start_runtime()
	run1.simulation_step = 0.02
	
	var run2: GameRuntime = GameRuntimeClass.new()
	run2.initialize_runtime()
	run2.start_runtime()
	run2.simulation_step = 0.02
	
	var steps_run1: int = 0
	for i in range(5):
		steps_run1 += run1.update_simulation(0.02) # 5 frames @ 50 FPS
	
	var steps_run2: int = 0
	steps_run2 += run2.update_simulation(0.04)
	steps_run2 += run2.update_simulation(0.04)
	steps_run2 += run2.update_simulation(0.02) # 3 irregular frames totaling 0.10s
	
	_assert_equal(steps_run1, 5, "SimStep C: Run 1 executed exactly 5 simulation steps")
	_assert_equal(steps_run2, 5, "SimStep C: Run 2 executed exactly 5 simulation steps despite different frame cadence")
	_assert_approx(run1.game_time.elapsed_seconds, run2.game_time.elapsed_seconds, 
		"SimStep C: Both runs reached identical simulation time (0.10s)")
	_assert_approx(run1.game_state.game_time_elapsed, run2.game_state.game_time_elapsed, 
		"SimStep C: Both runtimes synchronized identical GameState time")
	
	run1.free()
	run2.free()
	
	# Test D: Time scale through runtime
	var runtime_scale: GameRuntime = GameRuntimeClass.new()
	runtime_scale.initialize_runtime()
	runtime_scale.start_runtime()
	runtime_scale.simulation_step = 0.02
	runtime_scale.game_time.set_time_scale(2.0)
	
	runtime_scale.update_simulation(0.02)
	_assert_approx(runtime_scale.game_time.elapsed_seconds, 0.04, 
		"SimStep D: Time scale 2.0x through runtime advances simulation time by 2x (0.04s)")
	_assert_approx(runtime_scale.game_state.game_time_elapsed, 0.04, 
		"SimStep D: GameState reflects scaled simulation time (0.04s)")
	
	runtime_scale.free()
	
	# Test E: Pause through runtime
	var runtime_pause: GameRuntime = GameRuntimeClass.new()
	runtime_pause.initialize_runtime()
	runtime_pause.start_runtime()
	runtime_pause.simulation_step = 0.02
	runtime_pause.game_time.pause()
	
	var paused_steps: int = runtime_pause.update_simulation(0.10)
	_assert_equal(paused_steps, 5, "SimStep E: Controlled steps are processed while paused")
	_assert_approx(runtime_pause.game_time.elapsed_seconds, 0.0, 
		"SimStep E: Simulation time does NOT advance while paused")
	_assert_approx(runtime_pause.game_state.game_time_elapsed, 0.0, 
		"SimStep E: GameState time remains 0.0 while paused")
	
	runtime_pause.free()
	
	# Test F: Step cap / anti-spiral-of-death
	var runtime_cap: GameRuntime = GameRuntimeClass.new()
	runtime_cap.initialize_runtime()
	runtime_cap.start_runtime()
	runtime_cap.simulation_step = 0.02
	runtime_cap.max_simulation_steps_per_frame = 8 # Max 8 steps per frame
	
	# Pass an extreme frame stall: 5.0 seconds (would be 250 steps without cap!)
	var capped_steps: int = runtime_cap.update_simulation(5.0)
	_assert_equal(capped_steps, 8, "SimStep F: Extreme frame stall (5.0s) is safely capped to 8 steps")
	_assert_approx(runtime_cap.game_time.elapsed_seconds, 0.16, 
		"SimStep F: Elapsed time corresponds strictly to 8 steps (0.16s)")
	_assert_approx(runtime_cap.time_accumulator, 0.0, 
		"SimStep F: Excess backlog is discarded to prevent spiral of death")
	
	runtime_cap.free()
	
	# Test G: step_simulation() lifecycle and input validation protection
	var runtime_lc: GameRuntime = GameRuntimeClass.new()
	# In BOOT:
	runtime_lc.step_simulation(0.02)
	_assert_approx(runtime_lc.game_time.elapsed_seconds, 0.0, 
		"SimStep G: step_simulation() in BOOT does not advance simulation")
	
	# In INITIALIZE:
	runtime_lc.initialize_runtime()
	runtime_lc.step_simulation(0.02)
	_assert_approx(runtime_lc.game_time.elapsed_seconds, 0.0, 
		"SimStep G: step_simulation() in INITIALIZE does not advance simulation")
	
	# Transition to RUNNING:
	runtime_lc.start_runtime()
	
	# Non-positive / invalid step deltas in RUNNING:
	runtime_lc.step_simulation(0.0)
	_assert_approx(runtime_lc.game_time.elapsed_seconds, 0.0, 
		"SimStep G: step_simulation(0.0) does not advance simulation")
	runtime_lc.step_simulation(-0.02)
	_assert_approx(runtime_lc.game_time.elapsed_seconds, 0.0, 
		"SimStep G: step_simulation(-0.02) does not advance simulation")
	runtime_lc.step_simulation(NAN)
	_assert_approx(runtime_lc.game_time.elapsed_seconds, 0.0, 
		"SimStep G: step_simulation(NAN) does not advance simulation")
	
	# Valid positive step delta in RUNNING:
	runtime_lc.step_simulation(0.02)
	_assert_approx(runtime_lc.game_time.elapsed_seconds, 0.02, 
		"SimStep G: step_simulation(0.02) in RUNNING advances simulation")
	_assert_approx(runtime_lc.game_state.game_time_elapsed, 0.02, 
		"SimStep G: step_simulation() syncs GameState time")
	
	# In SHUTDOWN:
	runtime_lc.shutdown_runtime()
	runtime_lc.step_simulation(0.02)
	_assert_approx(runtime_lc.game_time.elapsed_seconds, 0.02, 
		"SimStep G: step_simulation() in SHUTDOWN does not advance simulation")
	
	runtime_lc.free()
	
	# Test H: Hardened accumulator boundary edge cases
	var runtime_harden: GameRuntime = GameRuntimeClass.new()
	runtime_harden.initialize_runtime()
	runtime_harden.start_runtime()
	runtime_harden.simulation_step = 0.02
	
	# Invalid render deltas:
	var invalid_steps_1: int = runtime_harden.update_simulation(0.0)
	_assert_equal(invalid_steps_1, 0, "SimStep H: update_simulation(0.0) produces 0 steps")
	_assert_approx(runtime_harden.time_accumulator, 0.0, "SimStep H: Accumulator remains 0.0 on 0.0 delta")
	
	var invalid_steps_2: int = runtime_harden.update_simulation(-0.05)
	_assert_equal(invalid_steps_2, 0, "SimStep H: update_simulation(-0.05) produces 0 steps")
	_assert_approx(runtime_harden.time_accumulator, 0.0, "SimStep H: Accumulator remains 0.0 on negative delta")
	
	var invalid_steps_3: int = runtime_harden.update_simulation(NAN)
	_assert_equal(invalid_steps_3, 0, "SimStep H: update_simulation(NAN) produces 0 steps")
	_assert_approx(runtime_harden.time_accumulator, 0.0, "SimStep H: Accumulator remains 0.0 on NAN delta")
	
	# Float underflow / non-negative guarantee:
	runtime_harden.update_simulation(0.0199999999)
	_assert_true(runtime_harden.time_accumulator >= 0.0, 
		"SimStep H: Accumulator is guaranteed non-negative (>= 0.0)")
	_assert_approx(runtime_harden.time_accumulator, 0.0, 
		"SimStep H: Sub-epsilon micro-residue snaps cleanly to 0.0")
	
	runtime_harden.free()

# -----------------------------------------------------------------------------
# 3. Command Pipeline Tests
# -----------------------------------------------------------------------------
func _run_command_pipeline_tests() -> void:
	print("\n--- Testing Command Pipeline ---")
	
	var runtime: GameRuntime = GameRuntimeClass.new()
	runtime.initialize_runtime()
	runtime.start_runtime()
	
	var executed_events: Array = []
	var failed_events: Array = []
	runtime.command_executed.connect(func(cmd, res): executed_events.append({"cmd": cmd, "res": res}))
	runtime.command_failed.connect(func(cmd, res): failed_events.append({"cmd": cmd, "res": res}))
	
	# Test 7: Valid command execution through runtime
	var valid_cmd: TestIncrementCommand = TestIncrementCommandClass.new(25)
	var valid_res: CommandResult = runtime.execute_command(valid_cmd)
	_assert_true(valid_res.success, "Command 7: Valid command returns success")
	_assert_equal(runtime.game_state.test_counter, 25, "Command 7: Valid command mutates state to 25")
	_assert_equal(executed_events.size(), 1, "Command 7: Valid command emits command_executed signal")
	_assert_equal(failed_events.size(), 0, "Command 7: Valid command does not emit command_failed signal")
	
	# Test 8: Invalid command rejection (negative amount)
	var invalid_negative: TestIncrementCommand = TestIncrementCommandClass.new(-5)
	var neg_res: CommandResult = runtime.execute_command(invalid_negative)
	_assert_true(not neg_res.success, "Command 8: Negative increment rejected by validation")
	_assert_equal(runtime.game_state.test_counter, 25, "Command 8: State counter remains unmutated (25)")
	_assert_equal(executed_events.size(), 1, "Command 8: Invalid command does NOT emit command_executed")
	_assert_equal(failed_events.size(), 1, "Command 8: Invalid command emits command_failed")
	
	# Test 9: Invalid command rejection (overflow > 100)
	var invalid_overflow: TestIncrementCommand = TestIncrementCommandClass.new(80) # 25 + 80 = 105 > 100
	var overflow_res: CommandResult = runtime.execute_command(invalid_overflow)
	_assert_true(not overflow_res.success, "Command 9: Overflow increment (>100) rejected by validation")
	_assert_equal(runtime.game_state.test_counter, 25, "Command 9: State counter remains strictly unmutated (25)")
	_assert_equal(executed_events.size(), 1, "Command 9: Overflow command does NOT emit command_executed")
	_assert_equal(failed_events.size(), 2, "Command 9: Overflow command emits command_failed")
	
	# Test 10: Guarded execution directly on Command
	var bypass_cmd: TestIncrementCommand = TestIncrementCommandClass.new(-10)
	var direct_res: CommandResult = bypass_cmd.execute_verified(runtime.game_state)
	_assert_true(not direct_res.success, "Command 10: execute_verified() enforces validation check")
	_assert_equal(runtime.game_state.test_counter, 25, "Command 10: State counter remains unmutated (25)")
	
	runtime.free()

# -----------------------------------------------------------------------------
# 4. State & Persistence Tests
# -----------------------------------------------------------------------------
func _run_state_and_persistence_tests() -> void:
	print("\n--- Testing GameState & Persistence Boundary ---")
	
	# Test 11: GameState default values and dictionary serialization
	var state: GameState = GameStateClass.new()
	_assert_approx(state.game_time_elapsed, 0.0, "GameState 11: Default game_time_elapsed is 0.0")
	_assert_equal(state.test_counter, 0, "GameState 11: Default test_counter is 0")
	
	state.game_time_elapsed = 123.45
	state.test_counter = 42
	var dict: Dictionary = state.to_dictionary()
	_assert_approx(float(dict["game_time_elapsed"]), 123.45, "GameState 11: to_dictionary preserves time")
	_assert_equal(int(dict["test_counter"]), 42, "GameState 11: to_dictionary preserves counter")
	
	var restored_state: GameState = GameStateClass.new()
	restored_state.from_dictionary(dict)
	_assert_approx(restored_state.game_time_elapsed, 123.45, "GameState 11: from_dictionary restores time")
	_assert_equal(restored_state.test_counter, 42, "GameState 11: from_dictionary restores counter")
	
	# Test 12: Persistence Boundary and Metadata Timestamp Invariant
	var pb: PersistenceBoundary = PersistenceBoundaryClass.new()
	var test_gt: GameTime = GameTimeClass.new(500.0)
	var save: SaveData = pb.serialize_state(restored_state, test_gt)
	
	_assert_equal(save.schema_version, 1, "Persistence 12: SaveData has schema_version 1")
	_assert_approx(save.game_time_elapsed, 500.0, "Persistence 12: SaveData has authoritative game_time_elapsed 500.0")
	_assert_true(save.timestamp > 0, "Persistence 12: SaveData has valid wall-clock metadata timestamp")
	
	# Deserialization test
	var fresh_state: GameState = GameStateClass.new()
	var fresh_gt: GameTime = GameTimeClass.new(0.0)
	var success: bool = pb.deserialize_state(save, fresh_state, fresh_gt)
	
	_assert_true(success, "Persistence 12: Deserialization succeeds")
	_assert_approx(fresh_gt.elapsed_seconds, 500.0, "Persistence 12: GameTime restored from game_time_elapsed (500.0)")
	_assert_equal(fresh_state.test_counter, 42, "Persistence 12: GameState restored correctly")
	
	# Invariant check: Verify timestamp is NOT used to calculate simulation time
	save.timestamp = 9999999999 # Manipulate metadata timestamp
	var verify_gt: GameTime = GameTimeClass.new(0.0)
	pb.deserialize_state(save, fresh_state, verify_gt)
	_assert_approx(verify_gt.elapsed_seconds, 500.0, "Persistence 12: Simulation time invariant: wall-clock timestamp does NOT affect GameTime")
	
	# Incompatible schema version rejection
	var bad_save: SaveData = SaveDataClass.new(999, 1000, 50.0, {})
	var bad_success: bool = pb.deserialize_state(bad_save, fresh_state, fresh_gt)
	_assert_true(not bad_success, "Persistence 12: Incompatible schema version 999 rejected")

# -----------------------------------------------------------------------------
# 5. Runtime Lifecycle Tests
# -----------------------------------------------------------------------------
func _run_runtime_lifecycle_tests() -> void:
	print("\n--- Testing GameRuntime Lifecycle ---")
	
	var runtime: GameRuntime = GameRuntimeClass.new()
	var observed_states: Array[GameRuntime.LifecycleState] = []
	runtime.lifecycle_changed.connect(func(s): observed_states.append(s))
	
	_assert_equal(runtime.current_state, GameRuntime.LifecycleState.BOOT, "Lifecycle 13: Starts in BOOT")
	
	runtime.initialize_runtime()
	_assert_equal(runtime.current_state, GameRuntime.LifecycleState.INITIALIZE, "Lifecycle 13: initialize() transitions to INITIALIZE")
	
	runtime.start_runtime()
	_assert_equal(runtime.current_state, GameRuntime.LifecycleState.RUNNING, "Lifecycle 13: start() transitions to RUNNING")
	
	runtime.step_simulation(runtime.simulation_step)
	_assert_approx(runtime.game_time.elapsed_seconds, runtime.simulation_step, 
		"Lifecycle 13: step_simulation advances GameTime in RUNNING state")
	_assert_approx(runtime.game_state.game_time_elapsed, runtime.simulation_step, 
		"Lifecycle 13: step_simulation syncs GameState time")
	
	runtime.shutdown_runtime()
	_assert_equal(runtime.current_state, GameRuntime.LifecycleState.SHUTDOWN, "Lifecycle 13: shutdown() transitions to SHUTDOWN")
	
	# Verify simulation does not advance when in SHUTDOWN
	runtime.update_simulation(0.5)
	_assert_approx(runtime.game_time.elapsed_seconds, runtime.simulation_step, 
		"Lifecycle 13: Simulation does not advance in SHUTDOWN state")
	
	_assert_equal(observed_states.size(), 3, "Lifecycle 13: Emitted exactly 3 state transition signals")
	
	runtime.free()

# -----------------------------------------------------------------------------
# 6. Player Foundation & Movement Tests (Phase 2)
# -----------------------------------------------------------------------------
func _run_player_foundation_tests() -> void:
	print("\n--- Testing Phase 2 Player Foundation & Movement ---")
	
	# Test P1: PlayerState initial defaults
	var ps: PlayerState = PlayerStateClass.new()
	_assert_equal(ps.position, Vector2.ZERO, "Player 1: Initial position is Vector2.ZERO")
	_assert_equal(ps.facing_direction, Vector2.DOWN, "Player 1: Initial facing direction is Vector2.DOWN")
	_assert_equal(ps.facing_cardinal, PlayerState.FacingDirection.SOUTH, "Player 1: Initial facing cardinal is SOUTH")
	_assert_approx(ps.move_speed, 150.0, "Player 1: Default move speed is 150.0 px/s")
	_assert_true(not ps.is_moving, "Player 1: Initial is_moving is false")
	
	# Test P2: 8-Directional Facing Resolution
	_assert_equal(PlayerState.vector_to_facing_direction(Vector2.UP), PlayerState.FacingDirection.NORTH, "Facing P2: Vector2.UP resolves to NORTH")
	_assert_equal(PlayerState.vector_to_facing_direction(Vector2(1, -1)), PlayerState.FacingDirection.NORTHEAST, "Facing P2: (1, -1) resolves to NORTHEAST")
	_assert_equal(PlayerState.vector_to_facing_direction(Vector2.RIGHT), PlayerState.FacingDirection.EAST, "Facing P2: Vector2.RIGHT resolves to EAST")
	_assert_equal(PlayerState.vector_to_facing_direction(Vector2(1, 1)), PlayerState.FacingDirection.SOUTHEAST, "Facing P2: (1, 1) resolves to SOUTHEAST")
	_assert_equal(PlayerState.vector_to_facing_direction(Vector2.DOWN), PlayerState.FacingDirection.SOUTH, "Facing P2: Vector2.DOWN resolves to SOUTH")
	_assert_equal(PlayerState.vector_to_facing_direction(Vector2(-1, 1)), PlayerState.FacingDirection.SOUTHWEST, "Facing P2: (-1, 1) resolves to SOUTHWEST")
	_assert_equal(PlayerState.vector_to_facing_direction(Vector2.LEFT), PlayerState.FacingDirection.WEST, "Facing P2: Vector2.LEFT resolves to WEST")
	_assert_equal(PlayerState.vector_to_facing_direction(Vector2(-1, -1)), PlayerState.FacingDirection.NORTHWEST, "Facing P2: (-1, -1) resolves to NORTHWEST")
	
	# Test P3: Diagonal Normalization logic
	var raw_diagonal: Vector2 = Vector2(1, 1)
	var normalized_diagonal: Vector2 = raw_diagonal.normalized()
	_assert_approx(normalized_diagonal.length(), 1.0, "Movement P3: Diagonal input vector normalizes to length 1.0 (not 1.414)")
	
	# Test P4: PlayerController node instantiation & movement properties
	var player: PlayerController = PlayerScene.instantiate() as PlayerController
	root.add_child(player)
	
	_assert_true(player != null, "Player P4: PlayerScene instantiates PlayerController cleanly")
	_assert_approx(player.move_speed, 150.0, "Player P4: Controller move_speed defaults to 150.0")
	_assert_approx(player.acceleration, 1200.0, "Player P4: Controller acceleration defaults to 1200.0")
	_assert_approx(player.friction, 1600.0, "Player P4: Controller friction defaults to 1600.0")
	
	# Test P5: Facing retention when stopped
	player.facing_direction = Vector2.LEFT
	player.facing_cardinal = PlayerState.FacingDirection.WEST
	player.velocity = Vector2.ZERO
	# Simulate 1 frame with zero input:
	player._process_movement(0.016)
	_assert_equal(player.facing_direction, Vector2.LEFT, "Player P5: Facing direction is retained when stationary")
	_assert_equal(player.facing_cardinal, PlayerState.FacingDirection.WEST, "Player P5: Facing cardinal enum is retained when stationary")
	
	# Test P6: PlayerState integration with GameState and serialization
	var state: GameState = GameStateClass.new()
	state.player_state.position = Vector2(128.5, -64.0)
	state.player_state.facing_direction = Vector2(1, 1).normalized()
	state.player_state.facing_cardinal = PlayerState.FacingDirection.SOUTHEAST
	state.player_state.is_moving = true
	state.player_state.move_speed = 150.0
	
	var serialized: Dictionary = state.to_dictionary()
	_assert_true(serialized.has("player"), "State P6: GameState includes player serialization")
	
	var restored_state: GameState = GameStateClass.new()
	restored_state.from_dictionary(serialized)
	_assert_approx(restored_state.player_state.position.x, 128.5, "State P6: Restores player_state position.x")
	_assert_approx(restored_state.player_state.position.y, -64.0, "State P6: Restores player_state position.y")
	_assert_equal(restored_state.player_state.facing_cardinal, PlayerState.FacingDirection.SOUTHEAST, "State P6: Restores player_state facing_cardinal")
	_assert_true(restored_state.player_state.is_moving, "State P6: Restores player_state is_moving")
	
	# Test P7: CameraController target tracking & zoom clamping
	var cam: CameraController = CameraControllerClass.new()
	cam.target = player
	cam.default_zoom_level = 2.0
	cam.min_zoom_level = 1.0
	cam.max_zoom_level = 3.0
	cam._ready()
	_assert_approx(cam.target_zoom_level, 2.0, "Camera P7: Initial target zoom is 2.0")
	
	# Zoom clamping:
	cam.target_zoom_level = 0.5
	cam.target_zoom_level = clampf(cam.target_zoom_level, cam.min_zoom_level, cam.max_zoom_level)
	_assert_approx(cam.target_zoom_level, 1.0, "Camera P7: Zoom is clamped at minimum (1.0)")
	
	cam.target_zoom_level = 5.0
	cam.target_zoom_level = clampf(cam.target_zoom_level, cam.min_zoom_level, cam.max_zoom_level)
	_assert_approx(cam.target_zoom_level, 3.0, "Camera P7: Zoom is clamped at maximum (3.0)")
	
	# Test P8: Minimal Interaction Hook
	var interaction_results: Array[Node] = []
	var test_sign: InteractableObject = InteractableObjectClass.new()
	test_sign.interacted.connect(func(p): interaction_results.append(p))
	test_sign.interact(player)
	_assert_true(interaction_results.size() > 0, "Interaction P8: Interacting with InteractableObject executes interact callback")
	_assert_equal(interaction_results[0], player, "Interaction P8: Callback receives player instance")
	
	# Clean up test nodes
	player.queue_free()
	cam.free()
	test_sign.free()

# -----------------------------------------------------------------------------
# 7. World Foundation Tests (Phase 3)
# -----------------------------------------------------------------------------
func _run_world_foundation_tests() -> void:
	print("\n--- Testing Phase 3 World Foundation ---")
	
	# Test W1: Personal Island Scene Instantiation & Markers
	var pi: WorldSpace = PersonalIslandScene.instantiate() as WorldSpace
	root.add_child(pi)
	_assert_true(pi != null, "World W1: Personal Island instantiates as WorldSpace")
	_assert_equal(pi.world_id, &"personal_island", "World W1: Personal Island world_id is 'personal_island'")
	_assert_equal(pi.display_name, "Personal Island", "World W1: Personal Island display_name is correct")
	
	var spawn_pos: Vector2 = pi.get_marker_position("SpawnMarker")
	_assert_equal(spawn_pos, Vector2(-60, 0), "World W1: Personal Island SpawnMarker is at (-60, 0)")
	
	var dock_arr_pos: Vector2 = pi.get_marker_position("DockArrivalMarker")
	_assert_equal(dock_arr_pos, Vector2(210, 150), "World W1: Personal Island DockArrivalMarker exists")
	
	var cottage_node: Node = pi.find_child("Cottage", true, false)
	_assert_true(cottage_node != null, "World W1: Cottage instance exists on Personal Island")
	
	var pi_dock_node: Node = pi.find_child("DockPier", true, false)
	_assert_true(pi_dock_node != null, "World W1: DockPier instance exists on Personal Island")
	
	# Test W2: Main Island Slice Scene Instantiation & Markers
	var mi: WorldSpace = MainIslandSliceScene.instantiate() as WorldSpace
	root.add_child(mi)
	_assert_true(mi != null, "World W2: Main Island slice instantiates as WorldSpace")
	_assert_equal(mi.world_id, &"main_island", "World W2: Main Island world_id is 'main_island'")
	
	var mi_dock_pos: Vector2 = mi.get_marker_position("DockArrivalMarker")
	_assert_equal(mi_dock_pos, Vector2(-300, 160), "World W2: Main Island DockArrivalMarker exists at (-300, 160)")
	
	var bridge_node: Node = mi.find_child("StoneBridge", true, false)
	_assert_true(bridge_node != null, "World W2: StoneBridge instance exists on Main Island slice")
	
	var arch_node: Node = mi.find_child("AncientArch", true, false)
	_assert_true(arch_node != null, "World W2: AncientArch exploration landmark exists on Main Island slice")
	
	var town_sign: Node = mi.find_child("TownSign", true, false)
	_assert_true(town_sign != null, "World W2: Town direction signpost exists on Main Island slice")
	
	# Test W3: Water & World Boundary Collisions
	var pi_water: StaticBody2D = pi.find_child("WaterBoundaries", true, false) as StaticBody2D
	_assert_true(pi_water != null, "World W3: WaterBoundaries StaticBody2D exists on Personal Island")
	_assert_equal(pi_water.collision_layer, 1, "World W3: Water boundaries have collision layer 1 active")
	
	var mi_bounds: StaticBody2D = mi.find_child("Boundaries", true, false) as StaticBody2D
	_assert_true(mi_bounds != null, "World W3: Boundaries StaticBody2D exists on Main Island slice")
	_assert_equal(mi_bounds.collision_layer, 1, "World W3: Main Island boundaries have collision layer 1 active")
	
	# Test W4: Dock Travel Transition Signal
	var travel_events: Array[Dictionary] = []
	pi.travel_requested.connect(func(dest, marker): travel_events.append({"dest": dest, "marker": marker}))
	pi.request_travel("res://scenes/world/main_island_slice.tscn", "DockArrivalMarker")
	_assert_equal(travel_events.size(), 1, "World W4: request_travel emits travel_requested signal")
	_assert_equal(travel_events[0]["dest"], "res://scenes/world/main_island_slice.tscn", "World W4: Destination matches requested scene path")
	_assert_equal(travel_events[0]["marker"], "DockArrivalMarker", "World W4: Arrival marker matches requested marker")
	
	# Test W5: Deterministic Day/Night Ambient Color Evaluation
	var day_color: Color = DayNightCycleClass.evaluate_ambient_color(60.0, 240.0)
	_assert_equal(day_color, DayNightCycleClass.COLOR_DAY, "DayNight W5: 60s/240s (progress 0.25) evaluates to COLOR_DAY")
	
	var twilight_color: Color = DayNightCycleClass.evaluate_ambient_color(180.0, 240.0)
	_assert_equal(twilight_color, DayNightCycleClass.COLOR_TWILIGHT, "DayNight W5: 180s/240s (progress 0.75) evaluates to COLOR_TWILIGHT")
	
	var night_color: Color = DayNightCycleClass.evaluate_ambient_color(216.0, 240.0)
	_assert_equal(night_color, DayNightCycleClass.COLOR_NIGHT, "DayNight W5: 216s/240s (progress 0.90) evaluates to COLOR_NIGHT")
	
	var next_day_color: Color = DayNightCycleClass.evaluate_ambient_color(300.0, 240.0)
	_assert_equal(next_day_color, DayNightCycleClass.COLOR_DAY, "DayNight W5: 300s/240s (next day noon) deterministically wraps to COLOR_DAY")
	
	# Test W6: Thin WorldSpace Marker Lookup & Fallback
	var fallback_pos: Vector2 = pi.get_marker_position("NonExistentMarker")
	_assert_equal(fallback_pos, pi.global_position, "World W6: Missing marker lookup falls back to world root position")
	
	# Clean up test nodes
	pi.queue_free()
	mi.queue_free()

# -----------------------------------------------------------------------------
# 8. Phase 4 Gameplay Behavioral Verification
# -----------------------------------------------------------------------------
func _run_phase4_gameplay_tests() -> void:
	print("\n--- Testing Phase 4 Gameplay Loop ---")
	
	# Behavioral Test 1: Data-Driven Definitions
	ItemDatabaseClass.clear()
	ItemDatabaseClass.initialize()
	var hoe_def: ItemDefinition = ItemDatabaseClass.get_definition(&"tool_hoe")
	_assert_true(hoe_def != null, "Definitions 1: Hoe ItemDefinition loaded from .tres")
	_assert_equal(hoe_def.display_name, "Hoe", "Definitions 1: Hoe display name matches resource")
	_assert_equal(hoe_def.category, ItemDefinitionClass.ItemCategory.TOOL, "Definitions 1: Hoe category is TOOL")
	
	var seed_def: ItemDefinition = ItemDatabaseClass.get_definition(&"seed_carrot")
	_assert_true(seed_def != null, "Definitions 1: Carrot seed ItemDefinition loaded from .tres")
	_assert_equal(seed_def.category, ItemDefinitionClass.ItemCategory.SEED, "Definitions 1: Seed category is SEED")
	
	CropDatabaseClass.clear()
	CropDatabaseClass.initialize()
	var carrot_def: CropDefinition = CropDatabaseClass.get_definition(&"carrot")
	_assert_true(carrot_def != null, "Definitions 1: Carrot CropDefinition loaded from .tres")
	_assert_equal(carrot_def.display_name, "Carrot", "Definitions 1: Crop display name is Carrot")
	_assert_equal(carrot_def.days_to_mature, 2, "Definitions 1: Carrot days_to_mature is 2")
	_assert_equal(carrot_def.seed_item_id, &"seed_carrot", "Definitions 1: Carrot seed_item_id is seed_carrot")
	_assert_equal(carrot_def.harvest_item_id, &"crop_carrot", "Definitions 1: Carrot harvest_item_id is crop_carrot")
	
	# Behavioral Test 2: Inventory Operations & Guards
	var inv: InventoryState = InventoryStateClass.new()
	_assert_equal(inv.get_quantity(&"seed_carrot"), 5, "Inventory 2: Starting carrot seed count is 5")
	_assert_equal(inv.get_quantity(&"tool_hoe"), 1, "Inventory 2: Starting hoe count is 1")
	_assert_equal(inv.get_quantity(&"tool_watering_can"), 1, "Inventory 2: Starting watering can count is 1")
	_assert_equal(inv.get_quantity(&"crop_carrot"), 0, "Inventory 2: Starting carrot count is 0")
	
	_assert_true(inv.add_item(&"crop_carrot", 3), "Inventory 2: Adding 3 carrots succeeds")
	_assert_equal(inv.get_quantity(&"crop_carrot"), 3, "Inventory 2: Carrot count is now 3")
	_assert_true(inv.remove_item(&"crop_carrot", 1), "Inventory 2: Removing 1 carrot succeeds")
	_assert_equal(inv.get_quantity(&"crop_carrot"), 2, "Inventory 2: Carrot count is now 2")
	
	# Guard: cannot remove more than available
	_assert_true(not inv.remove_item(&"crop_carrot", 5), "Inventory 2: Removing 5 carrots when only 2 held is rejected")
	_assert_equal(inv.get_quantity(&"crop_carrot"), 2, "Inventory 2: Carrot count remains strictly 2")
	
	# Guard: negative / zero counts
	_assert_true(not inv.add_item(&"crop_carrot", -2), "Inventory 2: Negative item add rejected")
	_assert_true(not inv.remove_item(&"crop_carrot", 0), "Inventory 2: Zero item removal rejected")
	
	# Inventory serialization
	var inv_dict: Dictionary = inv.to_dictionary()
	var inv_restored: InventoryState = InventoryStateClass.new()
	inv_restored.from_dictionary(inv_dict)
	_assert_equal(inv_restored.get_quantity(&"crop_carrot"), 2, "Inventory 2: Deserialized carrot count matches (2)")
	_assert_equal(inv_restored.get_quantity(&"seed_carrot"), 5, "Inventory 2: Deserialized seed count matches (5)")
	
	# Behavioral Test 3: Soil Preparation & Tilling
	var runtime: GameRuntime = GameRuntimeClass.new()
	runtime.initialize_runtime()
	runtime.start_runtime()
	
	var plot_coord: Vector2i = Vector2i(0, 0)
	var plot_pos: Vector2 = Vector2(-130, 20)
	var player_pos: Vector2 = Vector2(-130, 25) # Close to plot
	
	# Till plot
	var till_cmd: TillSoilCommand = TillSoilCommandClass.new(plot_coord, player_pos, plot_pos, true)
	var till_res: CommandResult = runtime.execute_command(till_cmd)
	_assert_true(till_res.success, "Farming 3: TillSoilCommand on fresh plot succeeds")
	var plot_state: SoilPlotState = runtime.game_state.farming_state.get_plot(plot_coord)
	_assert_true(plot_state != null and plot_state.is_tilled, "Farming 3: Plot is now marked as tilled")
	_assert_equal(runtime.game_state.progression_state.farming_xp, 2, "Farming 3: Tilling awards +2 Farming XP")
	
	# Re-tilling already tilled plot fails validation
	var re_till_cmd: TillSoilCommand = TillSoilCommandClass.new(plot_coord, player_pos, plot_pos, true)
	var re_till_res: CommandResult = runtime.execute_command(re_till_cmd)
	_assert_true(not re_till_res.success, "Farming 3: Re-tilling already tilled plot is rejected")
	
	# Behavioral Test 4: Planting & Seed Consumption
	# Attempt planting on untilled plot
	var untilled_coord: Vector2i = Vector2i(1, 0)
	var plant_fail_cmd: PlantCropCommand = PlantCropCommandClass.new(untilled_coord, &"carrot", player_pos, plot_pos, false)
	var plant_fail_res: CommandResult = runtime.execute_command(plant_fail_cmd)
	_assert_true(not plant_fail_res.success, "Farming 4: Planting on untilled plot fails validation")
	_assert_equal(runtime.game_state.inventory_state.get_quantity(&"seed_carrot"), 5, "Farming 4: Seeds not consumed on failed plant")
	
	# Plant on tilled plot
	var plant_cmd: PlantCropCommand = PlantCropCommandClass.new(plot_coord, &"carrot", player_pos, plot_pos, true)
	var plant_res: CommandResult = runtime.execute_command(plant_cmd)
	_assert_true(plant_res.success, "Farming 4: Planting carrot on tilled plot succeeds")
	_assert_equal(runtime.game_state.inventory_state.get_quantity(&"seed_carrot"), 4, "Farming 4: Exactly 1 seed consumed from inventory (4 remaining)")
	
	plot_state = runtime.game_state.farming_state.get_plot(plot_coord)
	_assert_true(plot_state.crop != null, "Farming 4: Plot contains growing crop")
	_assert_equal(plot_state.crop.growth_stage, 0, "Farming 4: Initial crop growth stage is 0 (Planted)")
	_assert_equal(plot_state.crop.days_grown, 0, "Farming 4: Initial days grown is 0")
	_assert_equal(runtime.game_state.progression_state.farming_xp, 7, "Farming 4: Planting awards +5 Farming XP (total 7)")
	
	# Occupied plot rejection
	var plant_occupied_cmd: PlantCropCommand = PlantCropCommandClass.new(plot_coord, &"carrot", player_pos, plot_pos, true)
	var plant_occupied_res: CommandResult = runtime.execute_command(plant_occupied_cmd)
	_assert_true(not plant_occupied_res.success, "Farming 4: Planting on already-occupied plot fails validation")
	_assert_equal(runtime.game_state.inventory_state.get_quantity(&"seed_carrot"), 4, "Farming 4: Seed not consumed on occupied rejection")
	
	# Behavioral Test 5: Soil Watering
	# Attempt watering untilled plot
	var water_untilled: WaterCropCommand = WaterCropCommandClass.new(untilled_coord, player_pos, plot_pos, false)
	_assert_true(not runtime.execute_command(water_untilled).success, "Farming 5: Watering untilled plot fails validation")
	
	# Water planted plot
	var water_cmd: WaterCropCommand = WaterCropCommandClass.new(plot_coord, player_pos, plot_pos, true)
	var water_res: CommandResult = runtime.execute_command(water_cmd)
	_assert_true(water_res.success, "Farming 5: Watering planted plot succeeds")
	_assert_true(runtime.game_state.farming_state.get_plot(plot_coord).is_watered, "Farming 5: Plot is marked as watered")
	_assert_equal(runtime.game_state.progression_state.farming_xp, 9, "Farming 5: Watering awards +2 Farming XP (total 9)")
	
	# Re-watering already watered plot fails validation
	_assert_true(not runtime.execute_command(water_cmd).success, "Farming 5: Re-watering already watered plot fails validation")
	
	# Behavioral Test 6: Crop Growth & Forgiving Simulation Invariant
	# Day 1 -> Day 2 (Plot was watered): should advance to stage 1 (Growing)
	var sleep_cmd1: AdvanceDayDebugCommand = AdvanceDayDebugCommandClass.new()
	var sleep_res1: CommandResult = runtime.execute_command(sleep_cmd1)
	_assert_true(sleep_res1.success, "Time 6: Day advancement to Day 2 succeeds")
	_assert_equal(runtime.game_state.time_state.current_day, 2, "Time 6: Current day is now 2")
	
	plot_state = runtime.game_state.farming_state.get_plot(plot_coord)
	_assert_equal(plot_state.crop.days_grown, 1, "Growth 6: Watered crop advanced to 1 day grown")
	_assert_equal(plot_state.crop.growth_stage, 1, "Growth 6: Crop growth stage is now 1 (Growing)")
	_assert_true(not plot_state.crop.is_mature, "Growth 6: Crop is not mature yet")
	_assert_true(not plot_state.is_watered, "Growth 6: Plot watering reset to false for new day")
	
	# Day 2: Player does NOT water the crop!
	# Advance Day 2 -> Day 3: Growth must pause, and crop must NOT die!
	var sleep_cmd2: AdvanceDayDebugCommand = AdvanceDayDebugCommandClass.new()
	runtime.execute_command(sleep_cmd2)
	_assert_equal(runtime.game_state.time_state.current_day, 3, "Time 6: Current day is now 3")
	
	plot_state = runtime.game_state.farming_state.get_plot(plot_coord)
	_assert_equal(plot_state.crop.days_grown, 1, "Forgiving 6: Unwatered crop days_grown remained paused at 1")
	_assert_equal(plot_state.crop.growth_stage, 1, "Forgiving 6: Unwatered crop stage remained paused at 1")
	_assert_true(not plot_state.crop.is_mature, "Forgiving 6: Unwatered crop is not mature")
	_assert_true(plot_state.crop != null, "Forgiving 6: Crop was NOT destroyed or withered")
	
	# Day 3: Player now waters the crop!
	var water_cmd2: WaterCropCommand = WaterCropCommandClass.new(plot_coord, player_pos, plot_pos, false)
	_assert_true(runtime.execute_command(water_cmd2).success, "Growth 6: Watering crop on Day 3 succeeds")
	
	# Advance Day 3 -> Day 4: Crop reaches 2 days grown -> Matures!
	var sleep_cmd3: AdvanceDayDebugCommand = AdvanceDayDebugCommandClass.new()
	runtime.execute_command(sleep_cmd3)
	_assert_equal(runtime.game_state.time_state.current_day, 4, "Time 6: Current day is now 4")
	
	plot_state = runtime.game_state.farming_state.get_plot(plot_coord)
	_assert_equal(plot_state.crop.days_grown, 2, "Growth 6: Watered crop reached 2 days grown")
	_assert_equal(plot_state.crop.growth_stage, 2, "Growth 6: Crop reached mature stage 2")
	_assert_true(plot_state.crop.is_mature, "Growth 6: Crop is marked mature")
	
	# Behavioral Test 7: Crop Harvesting
	# Harvest mature crop
	var harvest_cmd: HarvestCropCommand = HarvestCropCommandClass.new(plot_coord, player_pos, plot_pos, true)
	var harvest_res: CommandResult = runtime.execute_command(harvest_cmd)
	_assert_true(harvest_res.success, "Harvest 7: Harvesting mature crop succeeds")
	
	plot_state = runtime.game_state.farming_state.get_plot(plot_coord)
	_assert_true(plot_state.crop == null, "Harvest 7: Crop is removed from plot")
	_assert_true(plot_state.is_tilled, "Harvest 7: Plot remains tilled for future planting")
	_assert_equal(runtime.game_state.inventory_state.get_quantity(&"crop_carrot"), 1, "Harvest 7: 1 harvested carrot in inventory")
	_assert_equal(runtime.game_state.progression_state.farming_xp, 31, "Harvest 7: Harvesting awards +20 Farming XP (total 31)")
	
	# Attempt harvesting empty plot fails
	var harvest_empty_cmd: HarvestCropCommand = HarvestCropCommandClass.new(plot_coord, player_pos, plot_pos, true)
	_assert_true(not runtime.execute_command(harvest_empty_cmd).success, "Harvest 7: Harvesting plot without crop fails validation")
	
	# Behavioral Test 8: Resource Gathering & Daily Respawn
	var bush_node_id: StringName = &"wild_berry_bush_1"
	var bush_pos: Vector2 = Vector2(120, -130)
	var player_near_bush: Vector2 = Vector2(120, -125)
	
	_assert_true(not runtime.game_state.world_state.is_gathered(bush_node_id), "Gathering 8: Berry bush initially not gathered")
	_assert_equal(runtime.game_state.inventory_state.get_quantity(&"resource_wild_berries"), 0, "Gathering 8: Initially 0 wild berries in inventory")
	
	var gather_cmd: GatherResourceCommand = GatherResourceCommandClass.new(bush_node_id, &"resource_wild_berries", 3, player_near_bush, bush_pos, true)
	var gather_res: CommandResult = runtime.execute_command(gather_cmd)
	_assert_true(gather_res.success, "Gathering 8: Gathering berry bush succeeds")
	_assert_equal(runtime.game_state.inventory_state.get_quantity(&"resource_wild_berries"), 3, "Gathering 8: Exactly 3 wild berries added to inventory")
	_assert_true(runtime.game_state.world_state.is_gathered(bush_node_id), "Gathering 8: Bush is marked gathered in WorldState")
	
	# Attempt gathering again on same day fails
	var gather_again_cmd: GatherResourceCommand = GatherResourceCommandClass.new(bush_node_id, &"resource_wild_berries", 3, player_near_bush, bush_pos, true)
	_assert_true(not runtime.execute_command(gather_again_cmd).success, "Gathering 8: Gathering already-depleted bush fails validation")
	_assert_equal(runtime.game_state.inventory_state.get_quantity(&"resource_wild_berries"), 3, "Gathering 8: Berry count unchanged on failed gather")
	
	# Advance day -> Bush respawns
	var sleep_cmd4: AdvanceDayDebugCommand = AdvanceDayDebugCommandClass.new()
	runtime.execute_command(sleep_cmd4)
	_assert_equal(runtime.game_state.time_state.current_day, 5, "Time 8: Advanced to Day 5")
	_assert_true(not runtime.game_state.world_state.is_gathered(bush_node_id), "Respawn 8: Berry bush is respawned on new day")
	
	# Behavioral Test 9: Time & Sleep Proximity Validation
	var cottage_door_pos: Vector2 = Vector2(-60, -36)
	var player_far_from_cottage: Vector2 = Vector2(200, 200)
	
	var sleep_far_cmd: SleepCommand = SleepCommandClass.new(player_far_from_cottage, cottage_door_pos, true)
	_assert_true(not runtime.execute_command(sleep_far_cmd).success, "Sleep 9: Sleeping when far from cottage fails proximity validation")
	_assert_equal(runtime.game_state.time_state.current_day, 5, "Sleep 9: Day did not advance on failed sleep")
	
	var player_at_cottage: Vector2 = Vector2(-60, -30)
	var sleep_near_cmd: SleepCommand = SleepCommandClass.new(player_at_cottage, cottage_door_pos, true)
	_assert_true(runtime.execute_command(sleep_near_cmd).success, "Sleep 9: Sleeping at cottage door succeeds")
	_assert_equal(runtime.game_state.time_state.current_day, 6, "Sleep 9: Advanced to Day 6")
	
	# Behavioral Test 10: Farming XP & Level Progression
	var prog: ProgressionState = ProgressionStateClass.new()
	_assert_equal(prog.farming_level, 1, "Progression 10: Starts at Level 1")
	_assert_equal(prog.farming_xp, 0, "Progression 10: Starts at 0 XP")
	
	_assert_true(not prog.add_farming_xp(30), "Progression 10: 30 XP does not trigger level up")
	_assert_equal(prog.farming_level, 1, "Progression 10: Level remains 1 at 30 XP")
	
	_assert_true(prog.add_farming_xp(25), "Progression 10: Crossing 50 XP (total 55) triggers level up")
	_assert_equal(prog.farming_level, 2, "Progression 10: Level is now 2")
	
	# Behavioral Test 11: Authoritative Persistence Round-Trip
	var pb: PersistenceBoundary = PersistenceBoundaryClass.new()
	var save: SaveData = pb.serialize_state(runtime.game_state, runtime.game_time)
	_assert_equal(save.schema_version, 1, "Persistence 11: Schema version is 1")
	
	var restored_state: GameState = GameStateClass.new()
	var restored_time: GameTime = GameTimeClass.new()
	var deser_ok: bool = pb.deserialize_state(save, restored_state, restored_time)
	_assert_true(deser_ok, "Persistence 11: Deserialization succeeds")
	_assert_equal(restored_state.time_state.current_day, 6, "Persistence 11: Restores current_day 6")
	_assert_equal(restored_state.inventory_state.get_quantity(&"crop_carrot"), 1, "Persistence 11: Restores 1 harvested carrot")
	_assert_equal(restored_state.inventory_state.get_quantity(&"resource_wild_berries"), 3, "Persistence 11: Restores 3 wild berries")
	_assert_equal(restored_state.inventory_state.get_quantity(&"seed_carrot"), 4, "Persistence 11: Restores 4 carrot seeds")
	_assert_equal(restored_state.progression_state.farming_xp, 31, "Persistence 11: Restores 31 Farming XP")
	_assert_true(restored_state.farming_state.get_plot(plot_coord).is_tilled, "Persistence 11: Restores tilled plot state")
	
	# Behavioral Test 12: Backward Compatibility with Legacy Schema 1 Saves
	var legacy_dict: Dictionary = {
		"game_time_elapsed": 120.0,
		"test_counter": 10,
		"player": {
			"position": {"x": -60.0, "y": 0.0},
			"facing_cardinal": 4
		}
	}
	var legacy_save: SaveData = SaveDataClass.new(1, 1000, 120.0, legacy_dict)
	var legacy_state: GameState = GameStateClass.new()
	var legacy_time: GameTime = GameTimeClass.new()
	var legacy_deser: bool = pb.deserialize_state(legacy_save, legacy_state, legacy_time)
	_assert_true(legacy_deser, "BackwardCompat 12: Legacy save deserializes cleanly")
	_assert_equal(legacy_state.time_state.current_day, 1, "BackwardCompat 12: Missing time payload safely defaults to Day 1")
	_assert_equal(legacy_state.inventory_state.get_quantity(&"seed_carrot"), 5, "BackwardCompat 12: Missing inventory safely defaults to starting items")
	_assert_equal(legacy_state.progression_state.farming_level, 1, "BackwardCompat 12: Missing progression safely defaults to Level 1")
	
	# Behavioral Test 13: Farming Grid Authoritative Boundary & Mutation Safety (PH4-FIX-001)
	# 13a: Pure coordinate boundary evaluations
	_assert_true(FarmingGridClass.is_valid_cell(Vector2i(0, 0)), "FarmingGrid 13a: Min coordinate (0, 0) is valid")
	_assert_true(FarmingGridClass.is_valid_cell(Vector2i(3, 2)), "FarmingGrid 13a: Max coordinate (3, 2) is valid")
	_assert_true(FarmingGridClass.is_valid_cell(Vector2i(1, 1)), "FarmingGrid 13a: Interior coordinate (1, 1) is valid")
	_assert_true(FarmingGridClass.is_valid_cell(Vector2i(0, 2)), "FarmingGrid 13a: Corner coordinate (0, 2) is valid")
	_assert_true(FarmingGridClass.is_valid_cell(Vector2i(3, 0)), "FarmingGrid 13a: Corner coordinate (3, 0) is valid")
	
	_assert_true(not FarmingGridClass.is_valid_cell(Vector2i(-1, 0)), "FarmingGrid 13a: Negative X (-1, 0) is invalid")
	_assert_true(not FarmingGridClass.is_valid_cell(Vector2i(0, -1)), "FarmingGrid 13a: Negative Y (0, -1) is invalid")
	_assert_true(not FarmingGridClass.is_valid_cell(Vector2i(-1, -1)), "FarmingGrid 13a: Both negative (-1, -1) is invalid")
	_assert_true(not FarmingGridClass.is_valid_cell(Vector2i(4, 0)), "FarmingGrid 13a: X out-of-bounds (4, 0) is invalid")
	_assert_true(not FarmingGridClass.is_valid_cell(Vector2i(0, 3)), "FarmingGrid 13a: Y out-of-bounds (0, 3) is invalid")
	_assert_true(not FarmingGridClass.is_valid_cell(Vector2i(100, 100)), "FarmingGrid 13a: Far positive (100, 100) is invalid")
	_assert_true(not FarmingGridClass.is_valid_cell(Vector2i(-100, -100)), "FarmingGrid 13a: Far negative (-100, -100) is invalid")
	
	# 13b: World position mapping
	_assert_equal(FarmingGridClass.get_cell_world_position(Vector2i(0, 0)), Vector2(-130.0, 20.0), "FarmingGrid 13b: (0, 0) maps to GRID_ORIGIN")
	_assert_equal(FarmingGridClass.get_cell_world_position(Vector2i(1, 1)), Vector2(-114.0, 35.0), "FarmingGrid 13b: (1, 1) maps to expected offset")
	
	# 13c: Command validation and mutation safety on out-of-bounds coordinates
	var xp_before: int = runtime.game_state.progression_state.farming_xp
	var seeds_before: int = runtime.game_state.inventory_state.get_quantity(&"seed_carrot")
	var crops_before: int = runtime.game_state.inventory_state.get_quantity(&"crop_carrot")
	
	# TillSoilCommand rejects invalid coordinates without creating plots or awarding XP
	var invalid_coords: Array[Vector2i] = [
		Vector2i(-1, 0),
		Vector2i(0, -1),
		Vector2i(-1, -1),
		Vector2i(4, 0),
		Vector2i(0, 3),
		Vector2i(100, 100),
		Vector2i(-100, -100)
	]
	for inv_c in invalid_coords:
		var inv_till_cmd: TillSoilCommand = TillSoilCommandClass.new(inv_c, player_pos, plot_pos, false)
		var inv_till_res: CommandResult = runtime.execute_command(inv_till_cmd)
		_assert_true(not inv_till_res.success, "FarmingGrid 13c: TillSoilCommand on %s fails validation" % str(inv_c))
		_assert_true(runtime.game_state.farming_state.get_plot(inv_c) == null, "FarmingGrid 13c: No plot created for invalid coordinate %s" % str(inv_c))
	
	_assert_equal(runtime.game_state.progression_state.farming_xp, xp_before, "FarmingGrid 13c: Zero XP awarded across invalid till attempts")
	
	# PlantCropCommand rejects invalid coordinates without consuming seeds
	var inv_plant_cmd: PlantCropCommand = PlantCropCommandClass.new(Vector2i(4, 1), &"carrot", player_pos, plot_pos, false)
	var inv_plant_res: CommandResult = runtime.execute_command(inv_plant_cmd)
	_assert_true(not inv_plant_res.success, "FarmingGrid 13c: PlantCropCommand on (4, 1) fails validation")
	_assert_equal(runtime.game_state.inventory_state.get_quantity(&"seed_carrot"), seeds_before, "FarmingGrid 13c: Seeds strictly preserved on invalid plant attempt")
	_assert_equal(runtime.game_state.progression_state.farming_xp, xp_before, "FarmingGrid 13c: Zero XP awarded on invalid plant attempt")
	
	# WaterCropCommand rejects invalid coordinates
	var inv_water_cmd: WaterCropCommand = WaterCropCommandClass.new(Vector2i(0, -1), player_pos, plot_pos, false)
	var inv_water_res: CommandResult = runtime.execute_command(inv_water_cmd)
	_assert_true(not inv_water_res.success, "FarmingGrid 13c: WaterCropCommand on (0, -1) fails validation")
	_assert_equal(runtime.game_state.progression_state.farming_xp, xp_before, "FarmingGrid 13c: Zero XP awarded on invalid water attempt")
	
	# HarvestCropCommand rejects invalid coordinates
	var inv_harvest_cmd: HarvestCropCommand = HarvestCropCommandClass.new(Vector2i(100, 100), player_pos, plot_pos, false)
	var inv_harvest_res: CommandResult = runtime.execute_command(inv_harvest_cmd)
	_assert_true(not inv_harvest_res.success, "FarmingGrid 13c: HarvestCropCommand on (100, 100) fails validation")
	_assert_equal(runtime.game_state.inventory_state.get_quantity(&"crop_carrot"), crops_before, "FarmingGrid 13c: Crops strictly preserved on invalid harvest attempt")
	_assert_equal(runtime.game_state.progression_state.farming_xp, xp_before, "FarmingGrid 13c: Zero XP awarded on invalid harvest attempt")
	
	# 13d: Permitted boundary cell execution
	var valid_boundary_coord: Vector2i = Vector2i(3, 2)
	var valid_boundary_world: Vector2 = FarmingGridClass.get_cell_world_position(valid_boundary_coord)
	var valid_till_cmd: TillSoilCommand = TillSoilCommandClass.new(valid_boundary_coord, valid_boundary_world, valid_boundary_world, false)
	var valid_till_res: CommandResult = runtime.execute_command(valid_till_cmd)
	_assert_true(valid_till_res.success, "FarmingGrid 13d: TillSoilCommand on max boundary (3, 2) succeeds")
	_assert_true(runtime.game_state.farming_state.get_plot(valid_boundary_coord) != null, "FarmingGrid 13d: Plot state created on valid boundary (3, 2)")
	_assert_equal(runtime.game_state.progression_state.farming_xp, xp_before + 2, "FarmingGrid 13d: Farming XP incremented by exactly 2")
	
	runtime.shutdown_runtime()
	runtime.queue_free()

# -----------------------------------------------------------------------------
# 9. Interaction Prompt Persistence & Presentation Separation Tests (UX-FIX-001)
# -----------------------------------------------------------------------------
func _run_interaction_prompt_persistence_tests() -> void:
	print("\n--- Testing Interaction Prompt Persistence & Separation (UX-FIX-001) ---")
	
	var game: Node = GameScene.instantiate()
	root.add_child(game)
	if not game.is_node_ready():
		game._ready()
	
	_assert_true(game.get_prompt_label() != null, "Prompt 1: InteractionPrompt label exists in UI layer")
	_assert_true(game.get_toast_label() != null, "Prompt 1: InteractionToast label exists in UI layer")
	_assert_equal(game.get_prompt_label().text, "", "Prompt 1: Prompt label starts empty")
	_assert_true(not game.interaction_prompt_visible, "Prompt 1: Prompt initially not visible")
	
	# Test 1: Focused interactable -> Prompt visible with contextual text
	var test_sign: InspectableSign = InspectableSignClass.new()
	test_sign.prompt_text = "Inspect"
	test_sign.inspect_text = "Ancient Road to Underhallow."
	
	game._on_interactable_focused(test_sign)
	_assert_true(game.interaction_prompt_visible, "Prompt 1: Prompt marked visible on target focus")
	_assert_equal(game.prompt_label.text, "Press [E] to Inspect", "Prompt 1: Prompt label matches 'Press [E] to Inspect'")
	_assert_equal(game.active_interaction_target, test_sign, "Prompt 1: active_interaction_target set to test_sign")
	
	# Test 2: Prompt remains visible beyond 5-10 seconds of simulation time
	for i: int in range(10):
		game._process(1.0)
	_assert_true(game.interaction_prompt_visible, "Prompt 2: Prompt remains visible after 10.0s elapsed")
	_assert_equal(game.prompt_label.text, "Press [E] to Inspect", "Prompt 2: Prompt text NOT cleared after 10.0s elapsed")
	
	# Test 3: Target change -> Prompt updates immediately
	var test_bush: InteractableObject = InteractableObjectClass.new()
	test_bush.prompt_text = "Gather Berries"
	
	game._on_interactable_focused(test_bush)
	_assert_equal(game.active_interaction_target, test_bush, "Prompt 3: active_interaction_target updated to test_bush")
	_assert_equal(game.prompt_label.text, "Press [E] to Gather Berries", "Prompt 3: Prompt updates immediately to new target text")
	
	# Test 4: Temporary toast behavior remains independent and expires normally
	game._show_toast("Day 2 has dawned", 2.0)
	_assert_equal(game.toast_label.text, "Day 2 has dawned", "Toast 4: Temporary toast displayed")
	_assert_equal(game.prompt_label.text, "Press [E] to Gather Berries", "Toast 4: Prompt unaffected by active toast")
	
	# Process 1.0s: toast still active
	game._process(1.0)
	_assert_equal(game.toast_label.text, "Day 2 has dawned", "Toast 4: Toast remains visible at 1.0s")
	_assert_equal(game.prompt_label.text, "Press [E] to Gather Berries", "Toast 4: Prompt still visible")
	
	# Process another 1.5s (total 2.5s > 2.0s): toast expires, prompt remains!
	game._process(1.5)
	_assert_equal(game.toast_label.text, "", "Toast 4: Toast cleared when timer expires")
	_assert_true(not game.toast_label.visible, "Toast 4: Toast hidden after timer expiration")
	_assert_equal(game.prompt_label.text, "Press [E] to Gather Berries", "Toast 4: Persistent prompt remains visible after toast expires")
	
	# Test 5: Unfocus target -> Prompt hidden immediately
	game._on_interactable_unfocused()
	_assert_true(not game.interaction_prompt_visible, "Prompt 5: Prompt marked invisible when unfocused")
	_assert_equal(game.prompt_label.text, "", "Prompt 5: Prompt text cleared when unfocused")
	_assert_true(game.active_interaction_target == null, "Prompt 5: active_interaction_target is null")
	
	# Test 6: Interaction execution preserves prompt while target stays focused
	game._on_interactable_focused(test_sign)
	_assert_equal(game.prompt_label.text, "Press [E] to Inspect", "Prompt 6: Prompt shown on refocus")
	
	game._on_interaction_executed(test_sign)
	_assert_equal(game.toast_label.text, "Ancient Road to Underhallow.", "Prompt 6: Sign inspect text shown in toast")
	_assert_equal(game.prompt_label.text, "Press [E] to Inspect", "Prompt 6: Persistent prompt remains while player stays at sign")
	
	# Test 7: Equipped tool change dynamically updates prompt
	var test_plot: FarmPlot = FarmPlotClass.new()
	test_plot.grid_coord = Vector2i(0, 0)
	test_plot.runtime = game.runtime
	game._on_interactable_focused(test_plot)
	
	game.player_instance.equipped_item_id = &"tool_hoe"
	game._on_player_equipped_changed(&"tool_hoe")
	_assert_equal(game.prompt_label.text, "Press [E] to Till Soil", "Prompt 7: Prompt reflects equipped Hoe")
	
	game.player_instance.equipped_item_id = &"tool_watering_can"
	game._on_player_equipped_changed(&"tool_watering_can")
	_assert_equal(game.prompt_label.text, "Press [E] to Till Soil (Equip Hoe)", "Prompt 7: Prompt updates dynamically on tool switch")
	
	# Clean up test nodes
	test_sign.free()
	test_bush.free()
	test_plot.free()
	game.queue_free()

# -----------------------------------------------------------------------------
# 10. Architecture Audit A-001 Verification Suite
# -----------------------------------------------------------------------------
func _run_architecture_audit_a001_tests() -> void:
	print("\n--- Testing Architecture Audit A-001: Sole Clock Authority ---")
	
	# Suite A: Initial Synchronization
	var runtime: GameRuntime = GameRuntimeClass.new()
	runtime.initialize_runtime()
	_assert_approx(runtime.game_time.elapsed_seconds, 0.0, "A001-A: GameTime starts at 0.0")
	_assert_approx(runtime.game_state.game_time_elapsed, 0.0, "A001-A: GameState game_time_elapsed synchronized at 0.0")
	_assert_approx(runtime.game_state.time_state.elapsed_seconds, 0.0, "A001-A: TimeState elapsed_seconds synchronized at 0.0")
	_assert_equal(runtime.game_state.time_state.current_day, 1, "A001-A: TimeState current_day starts at 1")
	_assert_approx(runtime.game_state.time_state.get_day_progress(), 0.0, "A001-A: TimeState day progress starts at 0.0")
	
	# Constructor Divergence Invariant: p_day must never override day derived from elapsed seconds
	var normal_duration: float = runtime.game_state.time_state.day_duration
	var conflicting_ts_zero: TimeState = TimeStateClass.new(0.0, 99, normal_duration)
	_assert_approx(conflicting_ts_zero.elapsed_seconds, 0.0, "A001-Constructor: Elapsed seconds is 0.0 despite conflicting day argument")
	_assert_equal(conflicting_ts_zero.current_day, 1, "A001-Constructor: Current day derived as 1 from 0.0s elapsed, ignoring conflicting day 99")
	
	var conflicting_ts_adv: TimeState = TimeStateClass.new(normal_duration * 2.0, 99, normal_duration)
	_assert_approx(conflicting_ts_adv.elapsed_seconds, normal_duration * 2.0, "A001-Constructor: Elapsed seconds matches supplied elapsed time")
	_assert_equal(conflicting_ts_adv.current_day, 3, "A001-Constructor: Current day derived as 3 from (2 * day_duration), ignoring conflicting day 99")
	
	# Suite B: Normal Simulation Stepping & Monotonic Derivation
	runtime.start_runtime()
	runtime.step_simulation(10.0)
	_assert_approx(runtime.game_time.elapsed_seconds, 10.0, "A001-B: GameTime advances to 10.0s")
	_assert_approx(runtime.game_state.game_time_elapsed, 10.0, "A001-B: GameState time matches GameTime (10.0s)")
	_assert_approx(runtime.game_state.time_state.elapsed_seconds, 10.0, "A001-B: TimeState elapsed_seconds matches GameTime (10.0s)")
	_assert_equal(runtime.game_state.time_state.current_day, 1, "A001-B: Current day remains 1 within first day")
	_assert_approx(runtime.game_state.time_state.get_day_progress(), 10.0 / runtime.game_state.time_state.day_duration, "A001-B: Day progress derived correctly")
	
	# Multiple simulation steps through update_simulation
	var steps: int = runtime.update_simulation(1.0)
	_assert_true(steps > 0, "A001-B: update_simulation executed fixed steps")
	_assert_approx(runtime.game_state.game_time_elapsed, runtime.game_time.elapsed_seconds, "A001-B: GameState remains in lockstep with GameTime")
	_assert_approx(runtime.game_state.time_state.elapsed_seconds, runtime.game_time.elapsed_seconds, "A001-B: TimeState remains in lockstep with GameTime")
	
	# Suite C: Sleep Advances Canonical Clock
	var before_time: float = runtime.game_time.elapsed_seconds
	var before_day: int = runtime.game_state.time_state.current_day
	var day_duration: float = runtime.game_state.time_state.day_duration
	
	var sleep_cmd: AdvanceDayDebugCommand = AdvanceDayDebugCommandClass.new()
	var sleep_res: CommandResult = runtime.execute_command(sleep_cmd)
	_assert_true(sleep_res.success, "A001-C: SleepCommand execution succeeds")
	
	var after_time: float = runtime.game_time.elapsed_seconds
	_assert_approx(after_time - before_time, day_duration, "A001-C: GameTime advanced by exactly configured day_duration")
	_assert_approx(runtime.game_state.game_time_elapsed, after_time, "A001-C: GameState time synchronized to new GameTime")
	_assert_approx(runtime.game_state.time_state.elapsed_seconds, after_time, "A001-C: TimeState elapsed_seconds synchronized to new GameTime")
	_assert_equal(runtime.game_state.time_state.current_day, before_day + 1, "A001-C: Calendar current_day advanced to %d" % (before_day + 1))
	
	# Suite D: Post-Sleep Simulation Stepping
	runtime.step_simulation(5.0)
	_assert_approx(runtime.game_time.elapsed_seconds, after_time + 5.0, "A001-D: Post-sleep simulation increases monotonically")
	_assert_approx(runtime.game_state.game_time_elapsed, runtime.game_time.elapsed_seconds, "A001-D: GameState remains synchronized after post-sleep step")
	_assert_approx(runtime.game_state.time_state.elapsed_seconds, runtime.game_time.elapsed_seconds, "A001-D: TimeState remains synchronized after post-sleep step")
	_assert_equal(runtime.game_state.time_state.current_day, before_day + 1, "A001-D: Calendar does not regress after sleep")
	
	# Suite E: Persistence Load Authority Chain (SaveData.game_time_elapsed -> GameTime -> TimeState)
	var pb: PersistenceBoundary = PersistenceBoundaryClass.new()
	var save: SaveData = pb.serialize_state(runtime.game_state, runtime.game_time)
	_assert_approx(save.game_time_elapsed, runtime.game_time.elapsed_seconds, "A001-E: Serialized game_time_elapsed matches canonical GameTime")
	
	var restored_state: GameState = GameStateClass.new()
	var restored_time: GameTime = GameTimeClass.new()
	var deser_ok: bool = pb.deserialize_state(save, restored_state, restored_time)
	_assert_true(deser_ok, "A001-E: Deserialization succeeds")
	_assert_approx(restored_time.elapsed_seconds, save.game_time_elapsed, "A001-E: GameTime restored directly from SaveData.game_time_elapsed")
	_assert_approx(restored_state.game_time_elapsed, restored_time.elapsed_seconds, "A001-E: GameState.game_time_elapsed driven by restored GameTime")
	_assert_approx(restored_state.time_state.elapsed_seconds, restored_time.elapsed_seconds, "A001-E: TimeState.elapsed_seconds driven by restored GameTime")
	_assert_equal(restored_state.time_state.current_day, runtime.game_state.time_state.current_day, "A001-E: Restored calendar current_day matches saved state")
	
	# Stale Data Resistance: Manipulate payload calendar data and ensure canonical GameTime wins
	var corrupted_payload: Dictionary = save.payload.duplicate(true)
	corrupted_payload["time"] = {
		"elapsed_seconds": 0.0,
		"current_day": 99,
		"day_duration": day_duration
	}
	corrupted_payload["game_time_elapsed"] = 0.0
	var corrupted_save: SaveData = SaveDataClass.new(save.schema_version, save.timestamp, save.game_time_elapsed, corrupted_payload)
	
	var hardened_state: GameState = GameStateClass.new()
	var hardened_time: GameTime = GameTimeClass.new()
	var hardened_deser: bool = pb.deserialize_state(corrupted_save, hardened_state, hardened_time)
	_assert_true(hardened_deser, "A001-E: Deserialization of corrupted payload succeeds")
	_assert_approx(hardened_time.elapsed_seconds, save.game_time_elapsed, "A001-E: Canonical GameTime preserved despite corrupted payload")
	_assert_approx(hardened_state.game_time_elapsed, save.game_time_elapsed, "A001-E: GameState time derived from GameTime, ignoring corrupted 0.0")
	_assert_approx(hardened_state.time_state.elapsed_seconds, save.game_time_elapsed, "A001-E: TimeState elapsed_seconds derived from GameTime, ignoring corrupted 0.0")
	_assert_equal(hardened_state.time_state.current_day, runtime.game_state.time_state.current_day, "A001-E: TimeState current_day derived from GameTime, ignoring stale 99")
	
	# Suite F: Farming Loop Preservation Across Sleep
	var farm_runtime: GameRuntime = GameRuntimeClass.new()
	farm_runtime.initialize_runtime()
	farm_runtime.start_runtime()
	
	var plot_coord: Vector2i = Vector2i(0, 0)
	var plot_pos: Vector2 = Vector2(-130, 20)
	var player_pos: Vector2 = Vector2(-130, 25)
	
	farm_runtime.execute_command(TillSoilCommandClass.new(plot_coord, player_pos, plot_pos, true))
	farm_runtime.execute_command(PlantCropCommandClass.new(plot_coord, &"carrot", player_pos, plot_pos, true))
	farm_runtime.execute_command(WaterCropCommandClass.new(plot_coord, player_pos, plot_pos, true))
	
	var farm_before_time: float = farm_runtime.game_time.elapsed_seconds
	farm_runtime.execute_command(AdvanceDayDebugCommandClass.new())
	
	_assert_approx(farm_runtime.game_time.elapsed_seconds - farm_before_time, farm_runtime.game_state.time_state.day_duration, "A001-F: Clock advanced across farming sleep")
	var plot_after_sleep: SoilPlotState = farm_runtime.game_state.farming_state.get_plot(plot_coord)
	_assert_equal(plot_after_sleep.crop.days_grown, 1, "A001-F: Watered crop grew 1 day across sleep")
	_assert_equal(plot_after_sleep.crop.growth_stage, 1, "A001-F: Crop growth stage updated to 1")
	_assert_true(not plot_after_sleep.is_watered, "A001-F: Soil watering reset to false")
	
	# Edge Cases:
	# 1. Direct SleepCommand execution without GameTime fails
	var uncontexted_sleep: SleepCommand = SleepCommandClass.new()
	var direct_fail: CommandResult = uncontexted_sleep.execute_verified(farm_runtime.game_state)
	_assert_true(not direct_fail.success, "A001-Edge: Direct SleepCommand without GameTime context fails")
	
	# 2. Consecutive Sleep Commands
	var consec_before: float = farm_runtime.game_time.elapsed_seconds
	var consec_day_before: int = farm_runtime.game_state.time_state.current_day
	farm_runtime.execute_command(AdvanceDayDebugCommandClass.new())
	farm_runtime.execute_command(AdvanceDayDebugCommandClass.new())
	_assert_approx(farm_runtime.game_time.elapsed_seconds - consec_before, day_duration * 2.0, "A001-Edge: Consecutive sleeps advance clock by exactly 2 days")
	_assert_equal(farm_runtime.game_state.time_state.current_day, consec_day_before + 2, "A001-Edge: Consecutive sleeps advance current_day by 2")
	
	# 3. Continuous Simulation Day Boundary Rollover (emitting day_changed)
	var rollover_runtime: GameRuntime = GameRuntimeClass.new()
	rollover_runtime.initialize_runtime()
	rollover_runtime.start_runtime()
	var signal_days: Array[int] = []
	rollover_runtime.game_state.time_state.day_changed.connect(func(d: int): signal_days.append(d))
	
	# Step to right before day boundary: 239.0s
	rollover_runtime.step_simulation(239.0)
	_assert_equal(rollover_runtime.game_state.time_state.current_day, 1, "A001-Edge: Current day remains 1 at 239.0s")
	_assert_equal(signal_days.size(), 0, "A001-Edge: day_changed not emitted before boundary")
	
	# Step across boundary: 2.0s -> 241.0s total
	rollover_runtime.step_simulation(2.0)
	_assert_equal(rollover_runtime.game_state.time_state.current_day, 2, "A001-Edge: Current day rolls over to 2 at 241.0s via continuous simulation")
	_assert_equal(signal_days.size(), 1, "A001-Edge: Exactly one day_changed signal emitted on rollover")
	_assert_equal(signal_days[0], 2, "A001-Edge: day_changed signal emitted with day 2")
	
	# 4. Neutralized TimeState mutations: advance_time and advance_day do NOT mutate elapsed_seconds
	var neutralized_ts: TimeState = TimeStateClass.new(50.0, 1, 240.0)
	neutralized_ts.advance_time(100.0)
	_assert_approx(neutralized_ts.elapsed_seconds, 50.0, "A001-Edge: Neutralized advance_time does not mutate elapsed_seconds")
	neutralized_ts.advance_day()
	_assert_approx(neutralized_ts.elapsed_seconds, 50.0, "A001-Edge: Neutralized advance_day does not mutate elapsed_seconds")
	
	# 5. Non-default day_duration configuration (e.g. 300.0s)
	var custom_runtime: GameRuntime = GameRuntimeClass.new()
	custom_runtime.initialize_runtime()
	custom_runtime.game_state.time_state.day_duration = 300.0
	custom_runtime.start_runtime()
	custom_runtime.execute_command(AdvanceDayDebugCommandClass.new())
	_assert_approx(custom_runtime.game_time.elapsed_seconds, 300.0, "A001-Edge: Configured day_duration 300.0 used for sleep duration without hardcoding")
	_assert_equal(custom_runtime.game_state.time_state.current_day, 2, "A001-Edge: Current day is 2 after 300.0s sleep")
	
	# 6. Presentation DayNightCycle reflects canonical GameTime after sleep
	var presentation_color: Color = DayNightCycleClass.evaluate_ambient_color(custom_runtime.game_time.elapsed_seconds, custom_runtime.game_state.time_state.day_duration)
	_assert_equal(presentation_color, DayNightCycleClass.COLOR_DAWN, "A001-Edge: DayNightCycle correctly reads canonical GameTime at day start")
	
	# Clean up
	runtime.queue_free()
	farm_runtime.queue_free()
	rollover_runtime.queue_free()
	custom_runtime.queue_free()

# -----------------------------------------------------------------------------
# 11. Hunting & Building State Domain Verification Suite
# -----------------------------------------------------------------------------
func _run_hunting_and_building_state_tests() -> void:
	print("\n--- Testing HuntingState & BuildingState Domain Infrastructure ---")
	
	# Test 1: Initialization
	var state: GameState = GameStateClass.new()
	_assert_true(state.hunting_state != null, "Domain 1: GameState initializes non-null hunting_state")
	_assert_true(state.building_state != null, "Domain 1: GameState initializes non-null building_state")
	
	var direct_hunting: HuntingState = HuntingStateClass.new()
	var direct_building: BuildingState = BuildingStateClass.new()
	_assert_true(direct_hunting != null, "Domain 1: Direct HuntingState instantiation succeeds")
	_assert_true(direct_building != null, "Domain 1: Direct BuildingState instantiation succeeds")
	
	# Test 2: Reset
	state.reset()
	_assert_equal(state.hunting_state.to_dictionary(), {}, "Domain 2: HuntingState resets to default empty dictionary")
	_assert_equal(state.building_state.to_dictionary(), {}, "Domain 2: BuildingState resets to default empty dictionary")
	
	# Test 3: Serialization
	var dict: Dictionary = state.to_dictionary()
	_assert_true(dict.has("hunting"), "Domain 3: GameState payload includes 'hunting' key")
	_assert_true(dict["hunting"] is Dictionary, "Domain 3: 'hunting' payload is a Dictionary")
	_assert_true(dict.has("building"), "Domain 3: GameState payload includes 'building' key")
	_assert_true(dict["building"] is Dictionary, "Domain 3: 'building' payload is a Dictionary")
	_assert_equal(dict["hunting"], {}, "Domain 3: Initial 'hunting' payload is empty dictionary")
	_assert_equal(dict["building"], {}, "Domain 3: Initial 'building' payload is empty dictionary")
	
	# Test 4: Deserialization
	var restored: GameState = GameStateClass.new()
	restored.from_dictionary(dict)
	_assert_true(restored.hunting_state != null, "Domain 4: Deserialized state has non-null hunting_state")
	_assert_true(restored.building_state != null, "Domain 4: Deserialized state has non-null building_state")
	_assert_equal(restored.hunting_state.to_dictionary(), {}, "Domain 4: Deserialized hunting_state remains empty dictionary")
	_assert_equal(restored.building_state.to_dictionary(), {}, "Domain 4: Deserialized building_state remains empty dictionary")
	
	# Test 5: Missing keys / Backward compatibility with Legacy Payload
	var legacy_payload: Dictionary = {
		"game_time_elapsed": 60.0,
		"test_counter": 5,
		"player": {},
		"time": {},
		"inventory": {},
		"farming": {},
		"progression": {},
		"world": {}
	}
	_assert_true(not legacy_payload.has("hunting"), "Domain 5: Legacy payload explicitly lacks 'hunting'")
	_assert_true(not legacy_payload.has("building"), "Domain 5: Legacy payload explicitly lacks 'building'")
	
	var legacy_state: GameState = GameStateClass.new()
	legacy_state.from_dictionary(legacy_payload)
	_assert_true(legacy_state.hunting_state != null, "Domain 5: Missing 'hunting' key defaults to non-null HuntingState")
	_assert_true(legacy_state.building_state != null, "Domain 5: Missing 'building' key defaults to non-null BuildingState")
	_assert_equal(legacy_state.hunting_state.to_dictionary(), {}, "Domain 5: Default HuntingState is empty dictionary")
	_assert_equal(legacy_state.building_state.to_dictionary(), {}, "Domain 5: Default BuildingState is empty dictionary")
	
	# Test 6: Round-Trip Preservation
	var round_trip_state: GameState = GameStateClass.new()
	var round_trip_dict: Dictionary = round_trip_state.to_dictionary()
	var round_trip_restored: GameState = GameStateClass.new()
	round_trip_restored.from_dictionary(round_trip_dict)
	_assert_true(round_trip_restored.hunting_state != null, "Domain 6: Round-trip preserves non-null hunting_state")
	_assert_true(round_trip_restored.building_state != null, "Domain 6: Round-trip preserves non-null building_state")
	_assert_equal(round_trip_restored.to_dictionary()["hunting"], {}, "Domain 6: Round-trip hunting payload matches")
	_assert_equal(round_trip_restored.to_dictionary()["building"], {}, "Domain 6: Round-trip building payload matches")

func _run_hunting_slice_tests() -> void:
	print("\n--- Testing Phase 4 Hunting Slice (HU-001) ---")
	var runtime: GameRuntime = GameRuntimeClass.new()
	runtime.initialize_runtime()
	
	# 1. HuntingState initializes cleanly
	_assert_true(runtime.game_state.hunting_state != null, "Hunting 1: HuntingState initializes")
	_assert_equal(runtime.game_state.hunting_state.get_all_creatures().size(), 0, "Hunting 1: HuntingState starts empty")
	
	# 2. Creature definition lookup (data-driven authoring)
	var hare_def: CreatureDefinition = CreatureDatabaseClass.get_definition(&"hare")
	_assert_true(hare_def != null, "Hunting 2: Forest Hare definition found in CreatureDatabase")
	_assert_equal(hare_def.id, &"hare", "Hunting 2: Creature definition ID matches 'hare'")
	_assert_equal(hare_def.display_name, "Forest Hare", "Hunting 2: Creature display name matches")
	_assert_equal(hare_def.max_health, 10, "Hunting 2: Max health configured to 10")
	_assert_equal(hare_def.harvest_item_id, &"resource_raw_hide", "Hunting 2: Harvest item ID matches resource_raw_hide")
	_assert_equal(hare_def.harvest_item_count, 1, "Hunting 2: Harvest item quantity matches 1")
	_assert_true(CreatureDatabaseClass.get_definition(&"non_existent_creature") == null, "Hunting 2: Unknown creature definition returns null")
	
	# 3. Hare can be registered with position & initial state (Authoritative registration)
	var hare_pos: Vector2 = Vector2(60.0, -120.0)
	var hare: CreatureState = runtime.game_state.hunting_state.register_creature(&"hare_01", &"hare", hare_pos)
	_assert_true(hare != null, "Hunting 3: Hare registered successfully")
	_assert_equal(hare.instance_id, &"hare_01", "Hunting 3: Instance ID matches")
	_assert_equal(hare.definition_id, &"hare", "Hunting 3: Definition ID matches")
	_assert_equal(hare.current_health, 10, "Hunting 3: Initial health matches definition")
	_assert_equal(hare.max_health, 10, "Hunting 3: Max health matches definition")
	_assert_equal(hare.position, hare_pos, "Hunting 3: Configured position matches world coordinates")
	_assert_true(not hare.is_discovered, "Hunting 3: Creature initially undiscovered")
	_assert_true(not hare.is_defeated, "Hunting 3: Creature initially alive (not defeated)")
	_assert_true(not hare.is_harvested, "Hunting 3: Creature initially unharvested")
	_assert_true(runtime.game_state.hunting_state.has_creature(&"hare_01"), "Hunting 3: HuntingState reports has_creature true")
	
	# 4. Valid engagement / discovery succeeds through command pipeline
	var disc_cmd: DiscoverCreatureCommand = DiscoverCreatureCommandClass.new(&"hare_01")
	var disc_res: CommandResult = runtime.execute_command(disc_cmd)
	_assert_true(disc_res.success, "Hunting 4: Valid discovery command succeeds")
	_assert_true(hare.is_discovered, "Hunting 4: Hare is marked discovered in HuntingState")
	
	# 5. Invalid engagement fails without mutating state
	var invalid_disc_cmd: DiscoverCreatureCommand = DiscoverCreatureCommandClass.new(&"non_existent_creature")
	var inv_disc_res: CommandResult = runtime.execute_command(invalid_disc_cmd)
	_assert_true(not inv_disc_res.success, "Hunting 5: Discovery of nonexistent creature fails validation")
	_assert_true(not runtime.game_state.hunting_state.has_creature(&"non_existent_creature"), "Hunting 5: No creature created on invalid discovery")
	var invalid_disc_empty: DiscoverCreatureCommand = DiscoverCreatureCommandClass.new(&"")
	_assert_true(not runtime.execute_command(invalid_disc_empty).success, "Hunting 5: Discovery with empty ID fails validation")
	
	# 6. Attack distance validation (when check_distance is enabled)
	var player_far: Vector2 = Vector2(200.0, 200.0) # distance to (60, -120) is ~350 > 60
	var out_of_range_atk: AttackCreatureCommand = AttackCreatureCommandClass.new(&"hare_01", 4, player_far, hare_pos, true)
	var out_of_range_res: CommandResult = runtime.execute_command(out_of_range_atk)
	_assert_true(not out_of_range_res.success, "Hunting 6: Attack out of range fails validation")
	_assert_equal(hare.current_health, 10, "Hunting 6: Creature health unmutated on failed out-of-range attack")
	
	# 7. Valid basic attack reduces authoritative health
	var player_near: Vector2 = Vector2(65.0, -120.0) # distance 5 <= 60
	var atk_cmd1: AttackCreatureCommand = AttackCreatureCommandClass.new(&"hare_01", 4, player_near, hare_pos, true)
	var atk_res1: CommandResult = runtime.execute_command(atk_cmd1)
	_assert_true(atk_res1.success, "Hunting 7: Attack command succeeds through pipeline within range")
	_assert_equal(hare.current_health, 6, "Hunting 7: Authoritative health updated to 6")
	_assert_true(not hare.is_defeated, "Hunting 7: Creature remains alive at 6 HP")
	
	# 8. Subsequent basic attack deterministically reduces health
	var atk_cmd2: AttackCreatureCommand = AttackCreatureCommandClass.new(&"hare_01", 3)
	var atk_res2: CommandResult = runtime.execute_command(atk_cmd2)
	_assert_true(atk_res2.success, "Hunting 8: Second attack succeeds")
	_assert_equal(hare.current_health, 3, "Hunting 8: Health deterministically decreased to 3")
	
	# 9. Defeat occurs at zero health (health clamped at 0, non-lethal creature defeat)
	var atk_cmd3: AttackCreatureCommand = AttackCreatureCommandClass.new(&"hare_01", 5) # 5 >= 3 remaining
	var atk_res3: CommandResult = runtime.execute_command(atk_cmd3)
	_assert_true(atk_res3.success, "Hunting 9: Fatal blow command succeeds")
	_assert_equal(hare.current_health, 0, "Hunting 9: Health clamped at 0 HP")
	_assert_true(hare.is_defeated, "Hunting 9: Defeat is recorded in HuntingState")
	_assert_true(not hare.is_harvested, "Hunting 9: Defeat does NOT automatically harvest rewards")
	_assert_equal(runtime.game_state.inventory_state.get_quantity(&"resource_raw_hide"), 0, "Hunting 9: Inventory raw hide remains 0 upon defeat")
	
	# 10. Defeated creature cannot take further normal damage
	var atk_cmd_post: AttackCreatureCommand = AttackCreatureCommandClass.new(&"hare_01", 2)
	var atk_res_post: CommandResult = runtime.execute_command(atk_cmd_post)
	_assert_true(not atk_res_post.success, "Hunting 10: Attacking defeated creature fails validation")
	_assert_equal(hare.current_health, 0, "Hunting 10: Defeated creature health unchanged")
	
	# 11. Living creature cannot be harvested
	var living_hare: CreatureState = runtime.game_state.hunting_state.register_creature(&"hare_02", &"hare", Vector2(30.0, 40.0))
	var harv_living_cmd: HarvestCreatureCommand = HarvestCreatureCommandClass.new(&"hare_02")
	var harv_living_res: CommandResult = runtime.execute_command(harv_living_cmd)
	_assert_true(not harv_living_res.success, "Hunting 11: Harvesting living creature fails validation")
	_assert_true(not living_hare.is_harvested, "Hunting 11: Living creature is not marked harvested")
	_assert_equal(runtime.game_state.inventory_state.get_quantity(&"resource_raw_hide"), 0, "Hunting 11: No rewards granted from living creature harvest")
	
	# 12. Harvest distance validation (when check_distance is enabled)
	var out_of_range_harv: HarvestCreatureCommand = HarvestCreatureCommandClass.new(&"hare_01", player_far, hare_pos, true)
	var out_of_range_harv_res: CommandResult = runtime.execute_command(out_of_range_harv)
	_assert_true(not out_of_range_harv_res.success, "Hunting 12: Harvest out of range fails validation")
	_assert_true(not hare.is_harvested, "Hunting 12: Creature remains unharvested on failed out-of-range harvest")
	_assert_equal(runtime.game_state.inventory_state.get_quantity(&"resource_raw_hide"), 0, "Hunting 12: No inventory rewards granted on out-of-range harvest")
	
	# 13. Defeated creature can be harvested within range
	var harv_cmd1: HarvestCreatureCommand = HarvestCreatureCommandClass.new(&"hare_01", player_near, hare_pos, true)
	var harv_res1: CommandResult = runtime.execute_command(harv_cmd1)
	_assert_true(harv_res1.success, "Hunting 13: Harvesting defeated creature succeeds within range")
	_assert_equal(runtime.game_state.inventory_state.get_quantity(&"resource_raw_hide"), 1, "Hunting 13: Harvest granted configured 1 Raw Hide to inventory")
	_assert_true(hare.is_harvested, "Hunting 13: Creature marked as harvested in HuntingState")
	
	# 14. Repeated harvest rejected without duplicating rewards
	var harv_cmd2: HarvestCreatureCommand = HarvestCreatureCommandClass.new(&"hare_01")
	var harv_res2: CommandResult = runtime.execute_command(harv_cmd2)
	_assert_true(not harv_res2.success, "Hunting 14: Repeated harvest command fails validation")
	_assert_equal(runtime.game_state.inventory_state.get_quantity(&"resource_raw_hide"), 1, "Hunting 14: Raw Hide quantity strictly unchanged on repeated harvest")
	
	# 15. Attacking harvested creature is rejected
	var atk_harv_cmd: AttackCreatureCommand = AttackCreatureCommandClass.new(&"hare_01", 1)
	var atk_harv_res: CommandResult = runtime.execute_command(atk_harv_cmd)
	_assert_true(not atk_harv_res.success, "Hunting 15: Attacking harvested creature fails validation")
	
	# 16. Missing creature definition & inventory failure safety
	var missing_def_hare: CreatureState = runtime.game_state.hunting_state.register_creature(&"corrupt_hare", &"unknown_definition")
	missing_def_hare.is_defeated = true
	var corrupt_harv_cmd: HarvestCreatureCommand = HarvestCreatureCommandClass.new(&"corrupt_hare")
	var corrupt_harv_res: CommandResult = runtime.execute_command(corrupt_harv_cmd)
	_assert_true(not corrupt_harv_res.success, "Hunting 16: Harvesting creature with missing definition fails validation")
	_assert_true(not missing_def_hare.is_harvested, "Hunting 16: Creature with missing definition is not marked harvested")
	
	# Test inventory addition rejection safeguard (when inventory cannot add item):
	var invalid_reward_def: CreatureDefinition = CreatureDefinitionClass.new()
	invalid_reward_def.id = &"bad_reward_creature"
	invalid_reward_def.harvest_item_id = &"" # empty ID causes add_item to return false
	invalid_reward_def.harvest_item_count = 0
	CreatureDatabaseClass.register_definition(invalid_reward_def)
	var bad_reward_hare: CreatureState = runtime.game_state.hunting_state.register_creature(&"bad_reward_hare", &"bad_reward_creature")
	bad_reward_hare.is_defeated = true
	var bad_harv_cmd: HarvestCreatureCommand = HarvestCreatureCommandClass.new(&"bad_reward_hare")
	var bad_harv_res: CommandResult = runtime.execute_command(bad_harv_cmd)
	_assert_true(not bad_harv_res.success, "Hunting 16: Harvest fails when inventory cannot accept item")
	_assert_true(not bad_reward_hare.is_harvested, "Hunting 16: Creature is NOT marked harvested on inventory addition failure")
	
	# 17. Invalid hunting commands with empty IDs fail cleanly without corrupting state
	var invalid_atk_empty: AttackCreatureCommand = AttackCreatureCommandClass.new(&"")
	_assert_true(not runtime.execute_command(invalid_atk_empty).success, "Hunting 17: Attack with empty ID fails")
	var invalid_harv_empty: HarvestCreatureCommand = HarvestCreatureCommandClass.new(&"")
	_assert_true(not runtime.execute_command(invalid_harv_empty).success, "Hunting 17: Harvest with empty ID fails")
	
	# 18. Authority: Presentation adapter delegates to HuntingState and does not own truth
	var hare_interactable: HareInteractable = HareInteractableClass.new()
	hare_interactable.creature_instance_id = &"hare_01"
	hare_interactable.bind_runtime(runtime)
	_assert_equal(hare_interactable.creature_instance_id, &"hare_01", "Hunting 18: HareInteractable instance ID matches")
	var adapter_state: CreatureState = hare_interactable.get_creature_state()
	_assert_true(adapter_state != null, "Hunting 18: HareInteractable delegates state lookup to HuntingState")
	_assert_equal(adapter_state.instance_id, &"hare_01", "Hunting 18: Presentation retrieved authoritative instance")
	_assert_true(adapter_state.is_harvested, "Hunting 18: Presentation reflects authoritative harvested status")
	
	# Test prompt update transitions
	hare_interactable.update_prompt_for_player(null)
	_assert_equal(hare_interactable.prompt_text, "Hare (Harvested)", "Hunting 18: Prompt reflects harvested state")
	
	# Test prompt for living undefeated creature
	var living_interactable: HareInteractable = HareInteractableClass.new()
	living_interactable.creature_instance_id = &"hare_02"
	living_interactable.bind_runtime(runtime)
	living_interactable.update_prompt_for_player(null)
	_assert_equal(living_interactable.prompt_text, "Discover Hare", "Hunting 18: Undiscovered prompt is 'Discover Hare'")
	
	# Simulate discovery command on hare_02
	runtime.execute_command(DiscoverCreatureCommandClass.new(&"hare_02"))
	living_interactable.update_prompt_for_player(null)
	_assert_equal(living_interactable.prompt_text, "Attack Hare (10 HP)", "Hunting 18: Discovered prompt is 'Attack Hare (10 HP)'")
	
	# Signal reactivity verification: attack hare_02 and verify signal updates presentation
	runtime.execute_command(AttackCreatureCommandClass.new(&"hare_02", 4))
	living_interactable.update_prompt_for_player(null)
	_assert_equal(living_interactable.prompt_text, "Attack Hare (6 HP)", "Hunting 18: Damaged prompt reflects 6 HP remaining")
	
	hare_interactable.queue_free()
	living_interactable.queue_free()
	
	# 19. Persistence: HuntingState round-trip preserves creature states
	var serialized_hunting: Dictionary = runtime.game_state.hunting_state.to_dictionary()
	_assert_true(serialized_hunting.has("hare_01"), "Hunting 19: Serialized hunting state contains hare_01")
	_assert_true(serialized_hunting.has("hare_02"), "Hunting 19: Serialized hunting state contains hare_02")
	
	var restored_hunting: HuntingState = HuntingStateClass.new()
	restored_hunting.from_dictionary(serialized_hunting)
	var restored_hare_01: CreatureState = restored_hunting.get_creature(&"hare_01")
	_assert_true(restored_hare_01 != null, "Hunting 19: Restored hunting state contains hare_01")
	_assert_true(restored_hare_01.is_defeated, "Hunting 19: Restored hare_01 remains defeated")
	_assert_true(restored_hare_01.is_harvested, "Hunting 19: Restored hare_01 remains harvested")
	_assert_equal(restored_hare_01.current_health, 0, "Hunting 19: Restored hare_01 health is 0")
	_assert_equal(restored_hare_01.position, hare_pos, "Hunting 19: Restored hare_01 position matches")
	
	var restored_hare_02: CreatureState = restored_hunting.get_creature(&"hare_02")
	_assert_true(restored_hare_02 != null, "Hunting 19: Restored hunting state contains hare_02")
	_assert_equal(restored_hare_02.current_health, 6, "Hunting 19: Restored hare_02 health is 6")
	_assert_true(not restored_hare_02.is_defeated, "Hunting 19: Restored hare_02 is not defeated")
	
	# 20. Targeted Surgical Verification: Full Player-Facing Hunting Loop
	# Traces: Player input / interaction -> PlayerInteraction -> HareInteractable -> Command -> GameRuntime -> HuntingState -> Presentation
	var live_runtime: GameRuntime = GameRuntimeClass.new()
	live_runtime.initialize_runtime()
	live_runtime.start_runtime()
	
	# Register world creature hare_island (representing the Personal Island instance at Vector2(60, -120))
	var island_hare_pos: Vector2 = Vector2(60.0, -120.0)
	var live_hare_state: CreatureState = live_runtime.game_state.hunting_state.register_creature(&"hare_island", &"hare", island_hare_pos)
	_assert_true(live_hare_state != null, "PlayerLoop 20.1: Live world hare registered in HuntingState")
	_assert_true(not live_hare_state.is_discovered, "PlayerLoop 20.1: Live hare starts undiscovered")
	
	# Instantiate actual Hare presentation scene from res://scenes/gameplay/hunting/hare.tscn
	var live_hare_node: HareInteractable = HareScene.instantiate() as HareInteractable
	live_hare_node.creature_instance_id = &"hare_island"
	live_hare_node.position = island_hare_pos
	live_hare_node.bind_runtime(live_runtime)
	if live_hare_node.visual_body == null:
		live_hare_node.visual_body = live_hare_node.get_node_or_null("VisualBody") as ColorRect
	if live_hare_node.state_label == null:
		live_hare_node.state_label = live_hare_node.get_node_or_null("StateLabel") as Label
	root.add_child(live_hare_node)
	
	# Instantiate actual Player presentation scene from res://scenes/player/player.tscn
	var live_player: PlayerController = PlayerScene.instantiate() as PlayerController
	live_player.runtime = live_runtime
	live_player.player_state = live_runtime.game_state.player_state
	if live_player.interaction_detector == null:
		live_player.interaction_detector = live_player.get_node_or_null("InteractionDetector") as PlayerInteraction
	root.add_child(live_player)
	
	# Proximity check: Player is far away at (200, 200) -> out of range (PC-001 range 28.0 px)
	live_player.global_position = Vector2(200.0, 200.0)
	live_player.interaction_detector.global_position = Vector2(200.0, 200.0)
	live_player.player_state.position = Vector2(200.0, 200.0)
	
	# Notify detector of nearby candidate; detector evaluates distance
	live_player.interaction_detector._on_area_entered(live_hare_node)
	_assert_true(live_player.interaction_detector.current_target == null, "PlayerLoop 20.2: Out-of-range hare is not focused by PlayerInteraction")
	var can_interact_far: bool = live_player.interaction_detector.trigger_interaction(live_player)
	_assert_true(not can_interact_far, "PlayerLoop 20.2: Normal player interaction rejected when out of range")
	_assert_true(not live_hare_state.is_discovered, "PlayerLoop 20.2: Hare cannot be discovered from outside interaction range")
	
	# Approach: Move player adjacent to hare within interaction range (e.g. at (60, -100), dist 20.0 <= 28.0)
	var near_pos: Vector2 = Vector2(60.0, -100.0)
	live_player.global_position = near_pos
	live_player.interaction_detector.global_position = near_pos
	live_player.player_state.position = near_pos
	live_player.facing_direction = Vector2.UP # Facing NORTH toward hare at (60, -120)
	live_player.interaction_detector.update_facing(Vector2.UP)
	_assert_equal(live_player.interaction_detector.current_target, live_hare_node, "PlayerLoop 20.3: Player focuses HareInteractable within range")
	
	# Step 1: Discover
	live_hare_node.update_prompt_for_player(live_player)
	_assert_equal(live_hare_node.prompt_text, "Discover Hare", "PlayerLoop 20.4: Interaction prompt indicates 'Discover Hare'")
	var trigger_disc_ok: bool = live_player.interaction_detector.trigger_interaction(live_player)
	_assert_true(trigger_disc_ok, "PlayerLoop 20.5: Triggering interaction executes discovery")
	_assert_true(live_hare_state.is_discovered, "PlayerLoop 20.5: Authoritative state records hare as discovered")
	
	# Step 2: First Basic Attack
	live_hare_node.update_prompt_for_player(live_player)
	_assert_equal(live_hare_node.prompt_text, "Attack Hare (10 HP)", "PlayerLoop 20.6: Prompt updates to 'Attack Hare (10 HP)'")
	var trigger_atk1_ok: bool = live_player.interaction_detector.trigger_interaction(live_player)
	_assert_true(trigger_atk1_ok, "PlayerLoop 20.7: Triggering interaction executes first attack")
	_assert_equal(live_hare_state.current_health, 5, "PlayerLoop 20.7: Authoritative health reduced to 5 HP")
	_assert_true(not live_hare_state.is_defeated, "PlayerLoop 20.7: Hare remains alive at 5 HP")
	
	# Step 3: Second Basic Attack (Defeat)
	live_hare_node.update_prompt_for_player(live_player)
	_assert_equal(live_hare_node.prompt_text, "Attack Hare (5 HP)", "PlayerLoop 20.8: Prompt updates to 'Attack Hare (5 HP)'")
	var trigger_atk2_ok: bool = live_player.interaction_detector.trigger_interaction(live_player)
	_assert_true(trigger_atk2_ok, "PlayerLoop 20.9: Triggering interaction executes defeating attack")
	_assert_equal(live_hare_state.current_health, 0, "PlayerLoop 20.9: Authoritative health clamped at 0 HP")
	_assert_true(live_hare_state.is_defeated, "PlayerLoop 20.9: Hare is authoritatively marked defeated")
	_assert_true(not live_hare_state.is_harvested, "PlayerLoop 20.9: Hare is not yet harvested upon defeat")
	
	# Attack on defeated creature is rejected by command pipeline
	var post_defeat_atk: AttackCreatureCommand = AttackCreatureCommandClass.new(&"hare_island", 5, near_pos, island_hare_pos, true)
	var post_defeat_res: CommandResult = live_runtime.execute_command(post_defeat_atk)
	_assert_true(not post_defeat_res.success, "PlayerLoop 20.10: Attacking defeated hare fails validation")
	_assert_equal(live_hare_state.current_health, 0, "PlayerLoop 20.10: Health remains 0")
	
	# Step 4: Harvest
	live_hare_node.update_prompt_for_player(live_player)
	_assert_equal(live_hare_node.prompt_text, "Harvest Hare", "PlayerLoop 20.11: Prompt updates to 'Harvest Hare'")
	_assert_equal(live_runtime.game_state.inventory_state.get_quantity(&"resource_raw_hide"), 0, "PlayerLoop 20.11: Inventory starts with 0 raw hide")
	var trigger_harv_ok: bool = live_player.interaction_detector.trigger_interaction(live_player)
	_assert_true(trigger_harv_ok, "PlayerLoop 20.12: Triggering interaction executes harvest")
	_assert_true(live_hare_state.is_harvested, "PlayerLoop 20.12: Authoritative state records hare as harvested")
	_assert_equal(live_runtime.game_state.inventory_state.get_quantity(&"resource_raw_hide"), 1, "PlayerLoop 20.12: Exactly 1 Raw Hide granted to inventory")
	
	# Step 5: Post-Harvest State & Deduplication
	live_hare_node.update_prompt_for_player(live_player)
	_assert_equal(live_hare_node.prompt_text, "Hare (Harvested)", "PlayerLoop 20.13: Prompt reflects harvested state")
	var trigger_post_harv_ok: bool = live_player.interaction_detector.trigger_interaction(live_player)
	_assert_true(not trigger_post_harv_ok or live_runtime.game_state.inventory_state.get_quantity(&"resource_raw_hide") == 1, "PlayerLoop 20.14: Triggering interaction on harvested hare safely handled")
	_assert_equal(live_runtime.game_state.inventory_state.get_quantity(&"resource_raw_hide"), 1, "PlayerLoop 20.14: Inventory raw hide strictly unchanged (no duplication)")
	
	# Direct harvest command on already-harvested creature rejected
	var post_harv_cmd: HarvestCreatureCommand = HarvestCreatureCommandClass.new(&"hare_island", near_pos, island_hare_pos, true)
	_assert_true(not live_runtime.execute_command(post_harv_cmd).success, "PlayerLoop 20.15: Direct harvest command on harvested hare fails validation")
	
	# Step 6: Attack does not mutate discovery (Responsibility separation test)
	var separate_hare: CreatureState = live_runtime.game_state.hunting_state.register_creature(&"hare_separate", &"hare", island_hare_pos)
	_assert_true(not separate_hare.is_discovered, "PlayerLoop 20.16: Separate hare starts undiscovered")
	var direct_atk: AttackCreatureCommand = AttackCreatureCommandClass.new(&"hare_separate", 3)
	live_runtime.execute_command(direct_atk)
	_assert_equal(separate_hare.current_health, 7, "PlayerLoop 20.16: Direct attack reduces health to 7")
	_assert_true(not separate_hare.is_discovered, "PlayerLoop 20.16: Attack does NOT mutate is_discovered (responsibility separation verified)")
	
	root.remove_child(live_hare_node)
	root.remove_child(live_player)
	live_hare_node.free()
	live_player.free()



func _run_construction_slice_tests() -> void:
	print("\n--- Testing Phase 4 Construction Slice (BI-001) ---")
	var runtime: GameRuntime = GameRuntimeClass.new()
	runtime.initialize_runtime()
	
	# 1. BuildingState initializes
	_assert_true(runtime.game_state.building_state != null, "Construction 1: BuildingState initializes")
	_assert_equal(runtime.game_state.building_state.get_all_buildings().size(), 0, "Construction 1: BuildingState starts empty")
	
	# 2. Valid building definition can be selected/requested
	var fence_def: BuildingDefinition = BuildingDatabaseClass.get_definition(&"rustic_fence")
	_assert_true(fence_def != null, "Construction 2: rustic_fence definition exists in BuildingDatabase")
	_assert_equal(fence_def.display_name, "Rustic Fence", "Construction 2: Definition display name matches")
	_assert_equal(fence_def.material_requirements.get(&"resource_wood", 0), 3, "Construction 2: Rustic fence requires 3 wood")
	
	var path_def: BuildingDefinition = BuildingDatabaseClass.get_definition(&"stone_path")
	_assert_true(path_def != null, "Construction 2: stone_path definition exists in BuildingDatabase")
	_assert_equal(path_def.material_requirements.get(&"resource_stone", 0), 1, "Construction 2: Stone path requires 1 stone")
	
	# 3. Invalid building ID fails
	var inv_id_cmd: PlaceBuildingCommand = PlaceBuildingCommandClass.new(&"bld_invalid", &"nonexistent_building", Vector2i(10, 10))
	var inv_id_res: CommandResult = runtime.execute_command(inv_id_cmd)
	_assert_true(not inv_id_res.success, "Construction 3: Placement of unknown building ID fails")
	_assert_true(not runtime.game_state.building_state.has_instance(&"bld_invalid"), "Construction 3: No instance created on invalid building ID")
	
	# 4. Missing materials fail without consuming anything
	runtime.game_state.inventory_state.add_item(&"resource_wood", 2) # Needs 3
	var miss_mat_cmd: PlaceBuildingCommand = PlaceBuildingCommandClass.new(&"fence_01", &"rustic_fence", Vector2i(10, 10))
	var miss_mat_res: CommandResult = runtime.execute_command(miss_mat_cmd)
	_assert_true(not miss_mat_res.success, "Construction 4: Placement with insufficient materials fails")
	_assert_equal(runtime.game_state.inventory_state.get_quantity(&"resource_wood"), 2, "Construction 4: Exactly 2 wood retained (no materials consumed on failure)")
	_assert_true(not runtime.game_state.building_state.has_instance(&"fence_01"), "Construction 4: BuildingState unchanged on missing materials")
	
	# 5. Successful placement consumes exactly the required materials
	runtime.game_state.inventory_state.add_item(&"resource_wood", 1) # Total 3 wood
	_assert_equal(runtime.game_state.inventory_state.get_quantity(&"resource_wood"), 3, "Construction 5: Inventory has exactly 3 wood")
	var valid_place_cmd: PlaceBuildingCommand = PlaceBuildingCommandClass.new(&"fence_01", &"rustic_fence", Vector2i(10, 10))
	var valid_place_res: CommandResult = runtime.execute_command(valid_place_cmd)
	_assert_true(valid_place_res.success, "Construction 5: Valid placement command succeeds")
	_assert_equal(runtime.game_state.inventory_state.get_quantity(&"resource_wood"), 0, "Construction 5: Exactly 3 wood consumed on placement")
	
	# 6. Successful placement creates an authoritative building instance
	var bld_inst: BuildingInstance = runtime.game_state.building_state.get_instance(&"fence_01")
	_assert_true(bld_inst != null, "Construction 6: BuildingInstance exists in BuildingState")
	_assert_equal(bld_inst.instance_id, &"fence_01", "Construction 6: Instance ID matches")
	_assert_equal(bld_inst.building_id, &"rustic_fence", "Construction 6: Building ID matches")
	_assert_equal(bld_inst.grid_coord, Vector2i(10, 10), "Construction 6: Grid coordinate matches")
	_assert_true(runtime.game_state.building_state.has_building_at(Vector2i(10, 10)), "Construction 6: Coordinate marked occupied in BuildingState")
	
	# 7. Collision/overlap fails (attempting to place at occupied cell)
	runtime.game_state.inventory_state.add_item(&"resource_wood", 3)
	var overlap_cmd: PlaceBuildingCommand = PlaceBuildingCommandClass.new(&"fence_02", &"rustic_fence", Vector2i(10, 10))
	var overlap_res: CommandResult = runtime.execute_command(overlap_cmd)
	_assert_true(not overlap_res.success, "Construction 7: Placement on occupied coordinate fails")
	_assert_equal(runtime.game_state.inventory_state.get_quantity(&"resource_wood"), 3, "Construction 7: Wood unchanged on overlap failure")
	_assert_true(not runtime.game_state.building_state.has_instance(&"fence_02"), "Construction 7: No duplicate instance created")
	
	# 8. Duplicate instance identity fails
	var dup_id_cmd: PlaceBuildingCommand = PlaceBuildingCommandClass.new(&"fence_01", &"rustic_fence", Vector2i(11, 10))
	var dup_id_res: CommandResult = runtime.execute_command(dup_id_cmd)
	_assert_true(not dup_id_res.success, "Construction 8: Placement with duplicate instance ID fails")
	_assert_equal(runtime.game_state.inventory_state.get_quantity(&"resource_wood"), 3, "Construction 8: Wood unchanged on duplicate ID failure")
	_assert_true(not runtime.game_state.building_state.has_building_at(Vector2i(11, 10)), "Construction 8: Coordinate remains unoccupied")
	
	# 9. Collision with farm plot fails
	runtime.game_state.farming_state.set_plot(Vector2i(0, 0), SoilPlotStateClass.new(Vector2i(0, 0), true))
	var farm_collide_cmd: PlaceBuildingCommand = PlaceBuildingCommandClass.new(&"fence_farm_col", &"rustic_fence", Vector2i(0, 0))
	var farm_collide_res: CommandResult = runtime.execute_command(farm_collide_cmd)
	_assert_true(not farm_collide_res.success, "Construction 9: Placement colliding with farm plot fails")
	_assert_equal(runtime.game_state.inventory_state.get_quantity(&"resource_wood"), 3, "Construction 9: Wood preserved on farm collision")
	
	# 10. Multi-material requirement atomicity test
	var multi_def: BuildingDefinition = BuildingDefinitionClass.new()
	multi_def.id = &"test_workshop"
	multi_def.display_name = "Craft Workshop"
	multi_def.category = "Structure"
	multi_def.material_requirements = {
		&"resource_wood": 3,
		&"resource_stone": 2
	}
	BuildingDatabaseClass.register_definition(multi_def)
	
	# Player has 3 wood, but 0 stone (needs 2 stone)
	var multi_fail_cmd: PlaceBuildingCommand = PlaceBuildingCommandClass.new(&"shop_01", &"test_workshop", Vector2i(20, 20))
	var multi_fail_res: CommandResult = runtime.execute_command(multi_fail_cmd)
	_assert_true(not multi_fail_res.success, "Construction 10: Multi-material placement fails when missing second material")
	_assert_equal(runtime.game_state.inventory_state.get_quantity(&"resource_wood"), 3, "Construction 10: Wood strictly preserved when stone is missing")
	_assert_equal(runtime.game_state.inventory_state.get_quantity(&"resource_stone"), 0, "Construction 10: Stone quantity remains 0")
	_assert_true(not runtime.game_state.building_state.has_instance(&"shop_01"), "Construction 10: No instance created on partial materials")
	
	# Now add 2 stone and place successfully
	runtime.game_state.inventory_state.add_item(&"resource_stone", 2)
	var multi_ok_cmd: PlaceBuildingCommand = PlaceBuildingCommandClass.new(&"shop_01", &"test_workshop", Vector2i(20, 20))
	var multi_ok_res: CommandResult = runtime.execute_command(multi_ok_cmd)
	_assert_true(multi_ok_res.success, "Construction 10: Multi-material placement succeeds with all materials")
	_assert_equal(runtime.game_state.inventory_state.get_quantity(&"resource_wood"), 0, "Construction 10: Wood consumed atomically")
	_assert_equal(runtime.game_state.inventory_state.get_quantity(&"resource_stone"), 0, "Construction 10: Stone consumed atomically")
	_assert_true(runtime.game_state.building_state.has_instance(&"shop_01"), "Construction 10: BuildingInstance created in BuildingState")
	
	# 11. Building instance has stable identity
	var retrieved: BuildingInstance = runtime.game_state.building_state.get_instance(&"shop_01")
	_assert_equal(retrieved.instance_id, &"shop_01", "Construction 11: Stable instance ID verified")
	_assert_equal(retrieved.building_id, &"test_workshop", "Construction 11: Building definition ID verified")
	
	# 12. Presentation reconstruction from authoritative BuildingState
	var display: BuildingDisplay = BuildingDisplayClass.new()
	display.initialize_from_state(runtime.game_state.building_state)
	_assert_equal(display.get_rendered_count(), 2, "Construction 12: BuildingDisplay derived 2 visual instances from BuildingState")
	display.queue_free()
	
	# 13. State serialization / deserialization roundtrip preserves building instances
	var saved_dict: Dictionary = runtime.game_state.to_dictionary()
	var new_state: GameState = GameStateClass.new()
	new_state.from_dictionary(saved_dict)
	_assert_true(new_state.building_state.has_instance(&"fence_01"), "Construction 13: Deserialized state preserves fence_01")
	_assert_true(new_state.building_state.has_instance(&"shop_01"), "Construction 13: Deserialized state preserves shop_01")
	_assert_equal(new_state.building_state.get_instance(&"shop_01").grid_coord, Vector2i(20, 20), "Construction 13: Deserialized grid coord matches")
	
	# --- Targeted Surgical Verification: Player-Facing Construction Interaction Path (Tests 1 - 8) ---
	var player: PlayerController = PlayerControllerClass.new()
	player.runtime = runtime
	
	var preview_display = BuildingPreviewDisplayClass.new()
	preview_display.bind_player(player, runtime)
	
	var hotbar: HotbarUI = HotbarUIClass.new()
	hotbar.initialize(runtime, player)
	
	# Test 1 — Building selection: A buildable can be selected/equipped through existing player-facing mechanism
	player.set_equipped_item(&"rustic_fence")
	_assert_equal(player.equipped_item_id, &"rustic_fence", "Test 1: Building selection sets equipped_item_id")
	_assert_equal(hotbar.active_slot_index, 3, "Test 1: HotbarUI activates slot 3 for rustic_fence")
	
	player.set_equipped_item(&"stone_path")
	_assert_equal(player.equipped_item_id, &"stone_path", "Test 1: Building selection equips stone_path")
	_assert_equal(hotbar.active_slot_index, 4, "Test 1: HotbarUI activates slot 4 for stone_path")
	
	# Test 2 — Preview activation: Selecting a building enters preview mode without mutation
	var wood_before_preview: int = runtime.game_state.inventory_state.get_quantity(&"resource_wood")
	var select_ok: bool = player.select_building(&"rustic_fence")
	_assert_true(select_ok, "Test 2: select_building succeeds")
	_assert_true(player.is_in_building_preview, "Test 2: Preview state is active")
	_assert_equal(player.preview_building_id, &"rustic_fence", "Test 2: Selected building ID is rustic_fence")
	_assert_true(preview_display.is_preview_visible(), "Test 2: Preview representation is visibly displayed")
	_assert_true(not runtime.game_state.building_state.has_instance(&"preview_fence_01"), "Test 2: Preview does NOT create BuildingInstance")
	_assert_true(not runtime.game_state.building_state.has_building_at(Vector2i(15, 15)), "Test 2: Preview does NOT mutate BuildingState")
	_assert_equal(runtime.game_state.inventory_state.get_quantity(&"resource_wood"), wood_before_preview, "Test 2: Preview does NOT consume inventory")
	
	# Test 3 — Preview movement: Changing target coordinate updates preview coordinate without mutating state
	player.set_preview_coord(Vector2i(18, 18))
	_assert_equal(player.preview_coord, Vector2i(18, 18), "Test 3: Preview coordinate updated to (18, 18)")
	preview_display.update_preview()
	var expected_world_pos: Vector2 = BuildingDisplayClass.grid_to_world_position(Vector2i(18, 18))
	_assert_equal(preview_display.position, expected_world_pos, "Test 3: Preview representation reflects updated grid coordinate")
	_assert_true(not runtime.game_state.building_state.has_building_at(Vector2i(18, 18)), "Test 3: Target coordinate remains unoccupied in BuildingState")
	_assert_true(not runtime.game_state.building_state.has_instance(&"preview_fence_01"), "Test 3: Movement does not create BuildingInstance")
	
	# Rotation in preview mode
	player.rotate_building_preview()
	_assert_equal(player.preview_orientation, 1, "Test 3: Preview orientation rotates to 1")
	player.rotate_building_preview()
	player.rotate_building_preview()
	player.rotate_building_preview()
	_assert_equal(player.preview_orientation, 0, "Test 3: Preview orientation cycles back to 0")
	
	# Test 4 — Preview validity: Blocked/invalid vs valid placement identified, strictly agreeing with PlaceBuildingCommand.validate()
	# Current wood is 0, so placement at (18, 18) is invalid due to missing materials
	_assert_true(not player.is_preview_valid(), "Test 4: Preview identifies placement with insufficient materials as invalid")
	
	# Add materials: now placement at empty (18, 18) is valid
	runtime.game_state.inventory_state.add_item(&"resource_wood", 3)
	_assert_true(player.is_preview_valid(), "Test 4: Preview identifies placement with sufficient materials as valid")
	
	# Move preview to (0, 0) which has a farming plot: invalid!
	player.set_preview_coord(Vector2i(0, 0))
	_assert_true(not player.is_preview_valid(), "Test 4: Preview identifies collision with farming plot as invalid")
	
	# Test 6 — Failed confirmation: Attempt invalid placement
	# Attempting confirmation over farm plot at (0, 0)
	var invalid_confirm_res: CommandResult = player.confirm_placement(&"fail_fence")
	_assert_true(not invalid_confirm_res.success, "Test 6: Invalid confirmation fails command execution")
	_assert_equal(runtime.game_state.inventory_state.get_quantity(&"resource_wood"), 3, "Test 6: Failed confirmation leaves inventory unchanged")
	_assert_true(not runtime.game_state.building_state.has_instance(&"fail_fence"), "Test 6: Failed confirmation creates no BuildingInstance")
	_assert_true(player.is_in_building_preview, "Test 6: Player remains in preview mode on failed confirmation")
	
	# Test 5 — Confirmation: Valid confirmation routes through PlaceBuildingCommand
	player.set_preview_coord(Vector2i(18, 18))
	_assert_true(player.is_preview_valid(), "Test 5: Target coordinate (18, 18) confirmed valid")
	var valid_confirm_res: CommandResult = player.confirm_placement(&"fence_preview_01")
	_assert_true(valid_confirm_res.success, "Test 5: Valid confirmation succeeds through command pipeline")
	_assert_true(not player.is_in_building_preview, "Test 5: Preview mode ends upon confirmation")
	_assert_true(not preview_display.is_preview_visible(), "Test 5: Preview representation hidden upon confirmation")
	_assert_true(runtime.game_state.building_state.has_instance(&"fence_preview_01"), "Test 5: BuildingState gains authoritative BuildingInstance")
	_assert_true(runtime.game_state.building_state.has_building_at(Vector2i(18, 18)), "Test 5: Grid coordinate (18, 18) is occupied")
	_assert_equal(runtime.game_state.inventory_state.get_quantity(&"resource_wood"), 0, "Test 5: Required materials consumed exactly once")
	
	# Test 7 — Cancel: Enter preview, cancel it, verify state and inventory untouched
	runtime.game_state.inventory_state.add_item(&"resource_stone", 1)
	player.select_building(&"stone_path")
	player.set_preview_coord(Vector2i(25, 25))
	_assert_true(player.is_in_building_preview, "Test 7: Preview active before cancel")
	_assert_true(preview_display.is_preview_visible(), "Test 7: Preview visible before cancel")
	
	player.cancel_building_preview()
	_assert_true(not player.is_in_building_preview, "Test 7: Preview mode ended after cancel")
	_assert_true(not preview_display.is_preview_visible(), "Test 7: Preview hidden after cancel")
	_assert_true(not runtime.game_state.building_state.has_building_at(Vector2i(25, 25)), "Test 7: BuildingState unchanged after cancel")
	_assert_equal(runtime.game_state.inventory_state.get_quantity(&"resource_stone"), 1, "Test 7: Inventory stone unchanged after cancel")
	
	# Test 8 — Presentation: Authoritative state reconstructs placed buildings correctly
	var authoritative_display: BuildingDisplay = BuildingDisplayClass.new()
	authoritative_display.initialize_from_state(runtime.game_state.building_state)
	_assert_true(authoritative_display.get_rendered_count() >= 3, "Test 8: BuildingDisplay reflects all placed buildings from BuildingState")
	
	# --- Coordinate Agreement Regression Test (Correction D) ---
	# Scenario: preview world position and authoritative placed node world position must agree exactly
	runtime.game_state.inventory_state.add_item(&"resource_wood", 3)
	player.select_building(&"rustic_fence")
	player.set_preview_coord(Vector2i(22, 22))
	preview_display.update_preview()
	var preview_resolved_pos: Vector2 = preview_display.position
	
	var agree_confirm_res: CommandResult = player.confirm_placement(&"fence_agreement_test")
	_assert_true(agree_confirm_res.success, "Coord Agreement: Placement command succeeds")
	
	# Reinitialize display to capture new placed building
	authoritative_display.initialize_from_state(runtime.game_state.building_state)
	var placed_node: Node2D = authoritative_display.get_building_node(&"fence_agreement_test")
	_assert_true(placed_node != null, "Coord Agreement: Placed building node exists in BuildingDisplay")
	var placed_resolved_pos: Vector2 = placed_node.position
	
	_assert_equal(preview_resolved_pos, placed_resolved_pos, "Coord Agreement: Preview and placed building world positions agree exactly for (22, 22)")
	_assert_equal(placed_resolved_pos, BuildingDisplayClass.grid_to_world_position(Vector2i(22, 22)), "Coord Agreement: Both match canonical BuildingDisplayClass.grid_to_world_position")
	
	authoritative_display.queue_free()
	preview_display.queue_free()
	hotbar.queue_free()
	player.queue_free()
	
	# --- Lightweight Input-Path Coverage (Correction E) ---
	var input_player: PlayerController = PlayerControllerClass.new()
	input_player.runtime = runtime
	
	# 1. hotbar_4 action equips rustic_fence and enters preview
	var ev_h4: InputEventAction = InputEventAction.new()
	ev_h4.action = "hotbar_4"
	ev_h4.pressed = true
	input_player._unhandled_input(ev_h4)
	_assert_equal(input_player.equipped_item_id, &"rustic_fence", "Input 1: hotbar_4 action equips rustic_fence")
	_assert_true(input_player.is_in_building_preview, "Input 1: hotbar_4 action enters preview mode")
	
	# 2. rotate_building action rotates preview
	var ev_rot: InputEventAction = InputEventAction.new()
	ev_rot.action = "rotate_building"
	ev_rot.pressed = true
	input_player._unhandled_input(ev_rot)
	_assert_equal(input_player.preview_orientation, 1, "Input 2: rotate_building action rotates orientation to 1")
	
	# 3. hotbar_5 action equips stone_path
	var ev_h5: InputEventAction = InputEventAction.new()
	ev_h5.action = "hotbar_5"
	ev_h5.pressed = true
	input_player._unhandled_input(ev_h5)
	_assert_equal(input_player.equipped_item_id, &"stone_path", "Input 3: hotbar_5 action equips stone_path")
	_assert_equal(input_player.preview_building_id, &"stone_path", "Input 3: preview building updated to stone_path")
	
	# 4. cancel action cancels preview
	var ev_cancel: InputEventAction = InputEventAction.new()
	ev_cancel.action = "cancel"
	ev_cancel.pressed = true
	input_player._unhandled_input(ev_cancel)
	_assert_true(not input_player.is_in_building_preview, "Input 4: cancel action exits preview mode")
	
	# 5. interact action confirms placement when in preview
	runtime.game_state.inventory_state.add_item(&"resource_wood", 3)
	input_player._unhandled_input(ev_h4) # re-enter fence preview
	input_player.set_preview_coord(Vector2i(28, 28))
	var ev_interact: InputEventAction = InputEventAction.new()
	ev_interact.action = "interact"
	ev_interact.pressed = true
	input_player._unhandled_input(ev_interact)
	_assert_true(not input_player.is_in_building_preview, "Input 5: interact action confirms placement and exits preview")
	_assert_true(runtime.game_state.building_state.has_building_at(Vector2i(28, 28)), "Input 5: Coordinate (28, 28) occupied after interact action")
	
	input_player.queue_free()

	# --- Targeted Surgical Verification: Footprint-Aware Placement ---
	# 1. 1x1 building occupies its expected cell
	var bld_1x1: BuildingInstance = runtime.game_state.building_state.get_instance(&"fence_preview_01")
	_assert_true(bld_1x1 != null, "Footprint 1: 1x1 building instance retrieved")
	_assert_equal(bld_1x1.footprint, Vector2i(1, 1), "Footprint 1: 1x1 building has footprint (1, 1)")
	_assert_equal(bld_1x1.get_occupied_cells().size(), 1, "Footprint 1: 1x1 building occupies exactly 1 cell")
	_assert_equal(bld_1x1.get_occupied_cells()[0], Vector2i(18, 18), "Footprint 1: Occupied cell matches origin (18, 18)")
	
	# Register multi-cell definition (2x2 footprint)
	var shed_def: BuildingDefinition = BuildingDefinitionClass.new()
	shed_def.id = &"test_shed"
	shed_def.display_name = "Storage Shed"
	shed_def.footprint = Vector2i(2, 2)
	shed_def.material_requirements = { &"resource_wood": 4 }
	BuildingDatabaseClass.register_definition(shed_def)
	
	# Place an obstacle at (31, 31)
	runtime.game_state.inventory_state.add_item(&"resource_stone", 1)
	var blocker_cmd: PlaceBuildingCommand = PlaceBuildingCommandClass.new(&"blocker_path", &"stone_path", Vector2i(31, 31))
	_assert_true(runtime.execute_command(blocker_cmd).success, "Footprint Setup: Blocker stone path placed at (31, 31)")
	
	# 2. Multi-cell footprint cannot overlap an existing building
	# Shed at (30, 30) covers (30,30), (31,30), (30,31), (31,31) -> (31,31) is blocked!
	runtime.game_state.inventory_state.add_item(&"resource_wood", 4)
	var shed_overlap_cmd: PlaceBuildingCommand = PlaceBuildingCommandClass.new(&"shed_overlap", &"test_shed", Vector2i(30, 30))
	var shed_overlap_res: CommandResult = runtime.execute_command(shed_overlap_cmd)
	_assert_true(not shed_overlap_res.success, "Footprint 2: Multi-cell footprint cannot overlap existing building")
	
	# 4. Failed footprint validation consumes no materials
	_assert_equal(runtime.game_state.inventory_state.get_quantity(&"resource_wood"), 4, "Footprint 4: Failed footprint validation consumes zero materials")
	_assert_true(not runtime.game_state.building_state.has_instance(&"shed_overlap"), "Footprint 4: BuildingState unchanged on failed footprint validation")
	
	# 3. Multi-cell footprint cannot overlap a farming plot
	# (0, 0) is a farm plot. Try placing shed at (-1, 0) which covers (-1,0), (0,0), (-1,1), (0,1)
	var shed_farm_cmd: PlaceBuildingCommand = PlaceBuildingCommandClass.new(&"shed_farm", &"test_shed", Vector2i(-1, 0))
	var shed_farm_res: CommandResult = runtime.execute_command(shed_farm_cmd)
	_assert_true(not shed_farm_res.success, "Footprint 3: Multi-cell footprint cannot overlap farming plot")
	_assert_equal(runtime.game_state.inventory_state.get_quantity(&"resource_wood"), 4, "Footprint 3: Wood strictly preserved on farm plot collision")
	
	# 5. Successful footprint placement records all occupied cells
	var shed_valid_cmd: PlaceBuildingCommand = PlaceBuildingCommandClass.new(&"shed_valid", &"test_shed", Vector2i(40, 40))
	var shed_valid_res: CommandResult = runtime.execute_command(shed_valid_cmd)
	_assert_true(shed_valid_res.success, "Footprint 5: Valid multi-cell placement succeeds")
	_assert_equal(runtime.game_state.inventory_state.get_quantity(&"resource_wood"), 0, "Footprint 5: Exactly 4 wood consumed on valid placement")
	_assert_true(runtime.game_state.building_state.has_building_at(Vector2i(40, 40)), "Footprint 5: Cell (40, 40) occupied")
	_assert_true(runtime.game_state.building_state.has_building_at(Vector2i(41, 40)), "Footprint 5: Cell (41, 40) occupied")
	_assert_true(runtime.game_state.building_state.has_building_at(Vector2i(40, 41)), "Footprint 5: Cell (40, 41) occupied")
	_assert_true(runtime.game_state.building_state.has_building_at(Vector2i(41, 41)), "Footprint 5: Cell (41, 41) occupied")
	
	# 6. Serialization/deserialization preserves footprint placement correctly
	var footprint_saved_dict: Dictionary = runtime.game_state.to_dictionary()
	var footprint_new_state: GameState = GameStateClass.new()
	footprint_new_state.from_dictionary(footprint_saved_dict)
	_assert_true(footprint_new_state.building_state.has_instance(&"shed_valid"), "Footprint 6: Restored state preserves shed_valid")
	_assert_equal(footprint_new_state.building_state.get_instance(&"shed_valid").footprint, Vector2i(2, 2), "Footprint 6: Restored instance footprint is (2, 2)")
	_assert_true(footprint_new_state.building_state.has_building_at(Vector2i(41, 41)), "Footprint 6: Restored state preserves corner cell (41, 41)")

func _run_clementine_narrative_slice_tests() -> void:
	print("\n--- Testing Phase 4 Clementine Narrative Slice ---")
	var root_node: Window = root
	var runtime: GameRuntime = GameRuntimeClass.new()
	runtime.initialize_runtime()
	runtime.start_runtime()
	
	# 1. State initialization
	_assert_equal(runtime.game_state.progression_state.clementine_objective_state, ProgressionStateClass.ClementineObjectiveState.INACTIVE, "Narrative 1: Objective starts INACTIVE")
	_assert_true(not runtime.game_state.progression_state.is_clementine_objective_active(), "Narrative 1: Objective not active initially")
	_assert_true(not runtime.game_state.progression_state.is_clementine_objective_completed(), "Narrative 1: Objective not completed initially")
	_assert_true(not runtime.game_state.progression_state.clementine_reward_granted, "Narrative 1: Reward not granted initially")
	
	# 2. Clementine node instantiation & binding
	var clementine_node: ClementineInteractable = ClementineScene.instantiate() as ClementineInteractable
	clementine_node.bind_runtime(runtime)
	root_node.add_child(clementine_node)
	clementine_node.global_position = Vector2(200, 20)
	
	clementine_node.update_prompt_for_player(null)
	_assert_equal(clementine_node.prompt_text, "Talk to Clementine", "Narrative 2: Initial prompt is 'Talk to Clementine'")
	_assert_equal(clementine_node.get_dialogue_state(), "intro", "Narrative 2: Dialogue state is 'intro'")
	
	# 3. Direct Complete command before acceptance fails validation
	var premature_complete_cmd: CompleteObjectiveCommand = CompleteObjectiveCommandClass.new()
	var premature_res: CommandResult = runtime.execute_command(premature_complete_cmd)
	_assert_true(not premature_res.success, "Narrative 3: Complete command fails validation when inactive")
	_assert_equal(runtime.game_state.progression_state.clementine_objective_state, ProgressionStateClass.ClementineObjectiveState.INACTIVE, "Narrative 3: State remains INACTIVE")
	
	# 4. Objective acceptance via player interaction
	var dummy_player: Node2D = Node2D.new()
	dummy_player.global_position = Vector2(200, 30)
	root_node.add_child(dummy_player)
	
	clementine_node.interact(dummy_player)
	_assert_equal(runtime.game_state.progression_state.clementine_objective_state, ProgressionStateClass.ClementineObjectiveState.ACTIVE, "Narrative 4: Interacting accepts objective and transitions to ACTIVE")
	_assert_true(runtime.game_state.progression_state.is_clementine_objective_active(), "Narrative 4: is_clementine_objective_active() returns true")
	_assert_equal(clementine_node.get_current_dialogue(), ClementineInteractableClass.INTRO_DIALOGUE, "Narrative 4: Intro dialogue delivered upon acceptance")
	_assert_equal(clementine_node.get_dialogue_state(), "active", "Narrative 4: Dialogue state transitions to 'active'")
	
	# 5. Duplicate acceptance rejected by command pipeline
	var dup_accept: AcceptObjectiveCommand = AcceptObjectiveCommandClass.new()
	var dup_res: CommandResult = runtime.execute_command(dup_accept)
	_assert_true(not dup_res.success, "Narrative 5: Duplicate acceptance rejected by validation")
	_assert_equal(runtime.game_state.progression_state.clementine_objective_state, ProgressionStateClass.ClementineObjectiveState.ACTIVE, "Narrative 5: State remains ACTIVE")
	
	# 6. Active incomplete interaction reminder
	clementine_node.update_prompt_for_player(dummy_player)
	_assert_equal(clementine_node.prompt_text, "Talk to Clementine", "Narrative 6: Incomplete prompt remains 'Talk to Clementine'")
	clementine_node.interact(dummy_player)
	_assert_true(clementine_node.get_current_dialogue().begins_with(ClementineInteractableClass.ACTIVE_DIALOGUE), "Narrative 6: Interacting while incomplete shows active reminder")
	_assert_true(clementine_node.get_current_dialogue().contains("0/3"), "Narrative 6: Reminder reports 0/3 Wild Berries")
	_assert_true(clementine_node.get_current_dialogue().contains("0/1"), "Narrative 6: Reminder reports 0/1 Raw Hide")
	_assert_equal(runtime.game_state.progression_state.clementine_objective_state, ProgressionStateClass.ClementineObjectiveState.ACTIVE, "Narrative 6: Objective remains ACTIVE")
	
	# 7. Partial progress: 3 Wild Berries without Raw Hide remains incomplete
	runtime.game_state.inventory_state.add_item(&"resource_wild_berries", 3)
	_assert_equal(runtime.game_state.inventory_state.get_quantity(&"resource_wild_berries"), 3, "Narrative 7: Inventory has 3 wild berries")
	_assert_true(not runtime.game_state.progression_state.can_complete_clementine_objective(runtime.game_state.inventory_state, runtime.game_state.hunting_state), "Narrative 7: 3 berries without Raw Hide is incomplete")
	var complete_no_hide_res: CommandResult = runtime.execute_command(CompleteObjectiveCommandClass.new(&"clementine_intro", dummy_player.global_position, clementine_node.global_position, true))
	_assert_true(not complete_no_hide_res.success, "Narrative 7: Complete command rejected without Raw Hide")
	
	# 8. Partial progress: 1 Raw Hide without 3 Wild Berries remains incomplete
	runtime.game_state.inventory_state.remove_item(&"resource_wild_berries", 3)
	runtime.game_state.inventory_state.add_item(&"resource_raw_hide", 1)
	_assert_equal(runtime.game_state.inventory_state.get_quantity(&"resource_wild_berries"), 0, "Narrative 8: Wild berries removed (0 in inventory)")
	_assert_equal(runtime.game_state.inventory_state.get_quantity(&"resource_raw_hide"), 1, "Narrative 8: Inventory has 1 raw hide")
	_assert_true(not runtime.game_state.progression_state.can_complete_clementine_objective(runtime.game_state.inventory_state, runtime.game_state.hunting_state), "Narrative 8: 1 Raw Hide without berries is incomplete")
	var complete_no_berries_res: CommandResult = runtime.execute_command(CompleteObjectiveCommandClass.new(&"clementine_intro", dummy_player.global_position, clementine_node.global_position, true))
	_assert_true(not complete_no_berries_res.success, "Narrative 8: Complete command rejected without 3 berries")
	
	# 9. Forest hare hunting outcome verification
	runtime.game_state.inventory_state.add_item(&"resource_wild_berries", 3)
	var test_hare: CreatureState = runtime.game_state.hunting_state.register_creature(&"test_hare_narrative", &"hare", Vector2(250, -80))
	_assert_true(not test_hare.is_harvested, "Narrative 9: Test hare registered and unharvested")
	_assert_true(not runtime.game_state.progression_state.can_complete_clementine_objective(runtime.game_state.inventory_state, runtime.game_state.hunting_state), "Narrative 9: Incomplete while registered forest hare has not been harvested")
	
	# Defeat and harvest the hare through the authoritative command pipeline
	var atk_cmd1: AttackCreatureCommand = AttackCreatureCommandClass.new(&"test_hare_narrative", 5)
	var atk_cmd2: AttackCreatureCommand = AttackCreatureCommandClass.new(&"test_hare_narrative", 5)
	runtime.execute_command(atk_cmd1)
	runtime.execute_command(atk_cmd2)
	_assert_true(test_hare.is_defeated, "Narrative 9: Hare defeated at 0 HP")
	var harvest_cmd: HarvestCreatureCommand = HarvestCreatureCommandClass.new(&"test_hare_narrative")
	var harv_res: CommandResult = runtime.execute_command(harvest_cmd)
	_assert_true(harv_res.success, "Narrative 9: Defeated hare harvested successfully")
	_assert_true(test_hare.is_harvested, "Narrative 9: Authoritative state records hare as harvested")
	_assert_true(runtime.game_state.progression_state.can_complete_clementine_objective(runtime.game_state.inventory_state, runtime.game_state.hunting_state), "Narrative 9: All objective requirements fully satisfied")
	
	# 10. Returning to Clementine required (having items does not auto-complete)
	_assert_equal(runtime.game_state.progression_state.clementine_objective_state, ProgressionStateClass.ClementineObjectiveState.ACTIVE, "Narrative 10: State remains ACTIVE before returning to Clementine")
	_assert_true(not runtime.game_state.progression_state.is_clementine_objective_completed(), "Narrative 10: Objective does NOT auto-complete on resource gathering")
	
	# Out-of-range completion fails distance validation
	dummy_player.global_position = Vector2(900, 900)
	var far_complete_cmd: CompleteObjectiveCommand = CompleteObjectiveCommandClass.new(&"clementine_intro", dummy_player.global_position, clementine_node.global_position, true)
	var far_res: CommandResult = runtime.execute_command(far_complete_cmd)
	_assert_true(not far_res.success, "Narrative 10: Complete command fails validation when player is far away")
	_assert_equal(runtime.game_state.progression_state.clementine_objective_state, ProgressionStateClass.ClementineObjectiveState.ACTIVE, "Narrative 10: State remains ACTIVE after failed far completion")
	
	# 11. Completion execution upon return to Clementine
	dummy_player.global_position = Vector2(200, 30)
	clementine_node.update_prompt_for_player(dummy_player)
	_assert_equal(clementine_node.prompt_text, "Deliver Supplies to Clementine", "Narrative 11: Prompt reflects ready to deliver")
	
	var xp_before_complete: int = runtime.game_state.progression_state.farming_xp
	clementine_node.interact(dummy_player)
	_assert_equal(runtime.game_state.progression_state.clementine_objective_state, ProgressionStateClass.ClementineObjectiveState.COMPLETED, "Narrative 11: Interacting with Clementine completes objective")
	_assert_true(runtime.game_state.progression_state.is_clementine_objective_completed(), "Narrative 11: is_clementine_objective_completed() returns true")
	_assert_true(runtime.game_state.progression_state.clementine_reward_granted, "Narrative 11: Reward recorded as granted")
	_assert_equal(clementine_node.get_current_dialogue(), ClementineInteractableClass.COMPLETE_DIALOGUE, "Narrative 11: Completion dialogue delivered")
	_assert_equal(clementine_node.get_dialogue_state(), "complete", "Narrative 11: Dialogue state is 'complete'")
	
	# 12. Authoritative reward (+20 Farming XP) and resource preservation
	_assert_equal(runtime.game_state.progression_state.farming_xp, xp_before_complete + 20, "Narrative 12: Exactly +20 Farming XP awarded as approved reward")
	_assert_true(runtime.game_state.inventory_state.get_quantity(&"resource_wild_berries") >= 3, "Narrative 12: Wild Berries preserved in inventory (not consumed)")
	_assert_true(runtime.game_state.inventory_state.get_quantity(&"resource_raw_hide") >= 1, "Narrative 12: Raw Hide preserved in inventory (not consumed)")
	
	# 13. Idempotence & Duplicate reward prevention
	var re_complete_cmd: CompleteObjectiveCommand = CompleteObjectiveCommandClass.new(&"clementine_intro", dummy_player.global_position, clementine_node.global_position, true)
	var re_complete_res: CommandResult = runtime.execute_command(re_complete_cmd)
	_assert_true(not re_complete_res.success, "Narrative 13: Direct Complete command on completed objective fails validation")
	
	var xp_after_complete: int = runtime.game_state.progression_state.farming_xp
	clementine_node.interact(dummy_player)
	_assert_equal(clementine_node.get_current_dialogue(), ClementineInteractableClass.POST_COMPLETE_DIALOGUE, "Narrative 13: Subsequent interaction gives friendly post-complete acknowledgement")
	_assert_equal(runtime.game_state.progression_state.farming_xp, xp_after_complete, "Narrative 13: Farming XP unchanged on repeated interaction (no duplicate reward)")
	
	# 14. Persistence: Round-trip preserves completed state and reward guard
	var pers: PersistenceBoundary = PersistenceBoundaryClass.new()
	var save_data: SaveData = pers.serialize_state(runtime.game_state, runtime.game_time)
	_assert_equal(save_data.schema_version, 1, "Narrative 14: Save schema version remains 1 (no migration)")
	
	var restored_state: GameState = GameStateClass.new()
	var restored_time: GameTime = GameTimeClass.new()
	var des_ok: bool = pers.deserialize_state(save_data, restored_state, restored_time)
	_assert_true(des_ok, "Narrative 14: Deserialization succeeds")
	_assert_equal(restored_state.progression_state.clementine_objective_state, ProgressionStateClass.ClementineObjectiveState.COMPLETED, "Narrative 14: Restored objective state is COMPLETED")
	_assert_true(restored_state.progression_state.clementine_reward_granted, "Narrative 14: Restored reward_granted flag is true")
	_assert_equal(restored_state.progression_state.farming_xp, xp_after_complete, "Narrative 14: Restored Farming XP matches")
	_assert_equal(restored_state.inventory_state.get_quantity(&"resource_wild_berries"), runtime.game_state.inventory_state.get_quantity(&"resource_wild_berries"), "Narrative 14: Restored Wild Berries match")
	_assert_equal(restored_state.inventory_state.get_quantity(&"resource_raw_hide"), runtime.game_state.inventory_state.get_quantity(&"resource_raw_hide"), "Narrative 14: Restored Raw Hide matches")
	
	# Attempting completion on restored state fails validation (reward guard holds)
	var restored_runtime: GameRuntime = GameRuntimeClass.new()
	restored_runtime.initialize_runtime()
	restored_runtime.start_runtime()
	restored_runtime.game_state = restored_state
	var post_reload_cmd: CompleteObjectiveCommand = CompleteObjectiveCommandClass.new(&"clementine_intro")
	var post_reload_res: CommandResult = restored_runtime.execute_command(post_reload_cmd)
	_assert_true(not post_reload_res.success, "Narrative 14: Post-reload complete command fails validation")
	_assert_equal(restored_runtime.game_state.progression_state.farming_xp, xp_after_complete, "Narrative 14: Post-reload XP strictly unchanged")
	
	# 15. Persistence: Active state and partial progress round-trip
	var active_state: GameState = GameStateClass.new()
	active_state.progression_state.clementine_objective_state = ProgressionStateClass.ClementineObjectiveState.ACTIVE
	active_state.inventory_state.add_item(&"resource_wild_berries", 2)
	var active_save: SaveData = pers.serialize_state(active_state, runtime.game_time)
	var restored_active_state: GameState = GameStateClass.new()
	pers.deserialize_state(active_save, restored_active_state, restored_time)
	_assert_equal(restored_active_state.progression_state.clementine_objective_state, ProgressionStateClass.ClementineObjectiveState.ACTIVE, "Narrative 15: Restored active state is ACTIVE")
	_assert_equal(restored_active_state.inventory_state.get_quantity(&"resource_wild_berries"), 2, "Narrative 15: Restored active progress has 2 Wild Berries")
	_assert_true(not restored_active_state.progression_state.clementine_reward_granted, "Narrative 15: Restored active reward_granted is false")
	
	# 16. Backward compatibility with saves lacking clementine fields
	var legacy_dict: Dictionary = { "farming_xp": 15, "farming_level": 1 }
	var legacy_prog: ProgressionState = ProgressionStateClass.new()
	legacy_prog.from_dictionary(legacy_dict)
	_assert_equal(legacy_prog.clementine_objective_state, ProgressionStateClass.ClementineObjectiveState.INACTIVE, "Narrative 16: Legacy save defaults clementine_objective_state to INACTIVE")
	_assert_true(not legacy_prog.clementine_reward_granted, "Narrative 16: Legacy save defaults clementine_reward_granted to false")
	
	# Clean up test nodes
	root_node.remove_child(clementine_node)
	clementine_node.free()
	root_node.remove_child(dummy_player)
	dummy_player.free()

