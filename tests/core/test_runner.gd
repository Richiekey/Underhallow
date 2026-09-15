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

var total_tests: int = 0
var passed_tests: int = 0
var failed_tests: int = 0

func _init() -> void:
	print("==================================================")
	print("Underhallow Phase 1 — Deterministic Core Test Suite")
	print("==================================================")
	
	_run_gametime_tests()
	_run_command_pipeline_tests()
	_run_state_and_persistence_tests()
	_run_runtime_lifecycle_tests()
	
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
# 2. Command Pipeline Tests
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
# 3. State & Persistence Tests
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
# 4. Runtime Lifecycle Tests
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
	
	runtime.update_simulation(1.5)
	_assert_approx(runtime.game_time.elapsed_seconds, 1.5, "Lifecycle 13: update_simulation advances GameTime in RUNNING state")
	_assert_approx(runtime.game_state.game_time_elapsed, 1.5, "Lifecycle 13: update_simulation syncs GameState time")
	
	runtime.shutdown_runtime()
	_assert_equal(runtime.current_state, GameRuntime.LifecycleState.SHUTDOWN, "Lifecycle 13: shutdown() transitions to SHUTDOWN")
	
	# Verify simulation does not advance when in SHUTDOWN
	runtime.update_simulation(2.0)
	_assert_approx(runtime.game_time.elapsed_seconds, 1.5, "Lifecycle 13: Simulation does not advance in SHUTDOWN state")
	
	_assert_equal(observed_states.size(), 3, "Lifecycle 13: Emitted exactly 3 state transition signals")
	
	runtime.free()
