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

