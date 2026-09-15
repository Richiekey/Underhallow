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

var total_tests: int = 0
var passed_tests: int = 0
var failed_tests: int = 0

func _init() -> void:
	print("==================================================")
	print("Underhallow Phase 1, 2 & 3 — Deterministic Test Suite")
	print("==================================================")
	
	_run_gametime_tests()
	_run_simulation_step_boundary_tests()
	_run_command_pipeline_tests()
	_run_state_and_persistence_tests()
	_run_runtime_lifecycle_tests()
	_run_player_foundation_tests()
	_run_world_foundation_tests()
	
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
