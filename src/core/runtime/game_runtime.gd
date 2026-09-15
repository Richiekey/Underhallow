class_name GameRuntime
extends Node

## Central runtime lifecycle coordinator and authoritative mutation gateway for Underhallow.
## Owns core state, simulation time, persistence boundary, and input provider.
## Establishes a controlled, deterministic simulation-step boundary decoupled from render cadence.
## Zero Autoload singletons; managed via explicit scene composition.

enum LifecycleState {
	BOOT,
	INITIALIZE,
	RUNNING,
	SHUTDOWN
}

signal lifecycle_changed(new_state: LifecycleState)
signal simulation_stepped(step_delta: float)
signal command_executed(command: Command, result: CommandResult)
signal command_failed(command: Command, result: CommandResult)

## Prototype default: 60Hz fixed simulation step (1/60s ~ 0.0166667s).
## Configurable per runtime instance; not locked as final game design.
const DEFAULT_SIMULATION_STEP: float = 1.0 / 60.0

## Prototype safety cap: Maximum simulation steps allowed per rendered frame
## to prevent spiral-of-death stalls during extreme frame hitches.
const DEFAULT_MAX_STEPS_PER_FRAME: int = 8

## Precision tolerance for float accumulator comparison
const EPSILON: float = 0.000001

var current_state: LifecycleState = LifecycleState.BOOT
var game_state: GameState = null
var game_time: GameTime = null
var persistence: PersistenceBoundary = null
var input_provider: InputProvider = null

## Controlled simulation stepping configuration
var simulation_step: float = DEFAULT_SIMULATION_STEP
var max_simulation_steps_per_frame: int = DEFAULT_MAX_STEPS_PER_FRAME
var time_accumulator: float = 0.0

func _init() -> void:
	game_state = GameState.new()
	game_time = GameTime.new()
	persistence = PersistenceBoundary.new()
	input_provider = InputProvider.new()
	current_state = LifecycleState.BOOT
	simulation_step = DEFAULT_SIMULATION_STEP
	max_simulation_steps_per_frame = DEFAULT_MAX_STEPS_PER_FRAME
	time_accumulator = 0.0

## Transitions runtime from BOOT to INITIALIZE.
func initialize_runtime() -> void:
	if current_state != LifecycleState.BOOT:
		printerr("Runtime Warning: initialize_runtime() called while in state ", current_state)
		return
	
	current_state = LifecycleState.INITIALIZE
	lifecycle_changed.emit(current_state)
	
	game_state.reset()
	game_time.reset()
	time_accumulator = 0.0

## Transitions runtime from INITIALIZE to RUNNING.
func start_runtime() -> void:
	if current_state != LifecycleState.INITIALIZE:
		printerr("Runtime Warning: start_runtime() called while in state ", current_state)
		return
	
	current_state = LifecycleState.RUNNING
	lifecycle_changed.emit(current_state)

## Transitions runtime to SHUTDOWN.
func shutdown_runtime() -> void:
	current_state = LifecycleState.SHUTDOWN
	lifecycle_changed.emit(current_state)

## Executes exactly one discrete simulation step of size `step_delta`.
## Direct simulation advancement path independent of render frame accumulation.
## Protected by lifecycle state: only executes when in RUNNING state with valid positive step_delta.
func step_simulation(step_delta: float) -> void:
	if current_state != LifecycleState.RUNNING:
		return
	
	if step_delta <= 0.0 or is_nan(step_delta) or is_inf(step_delta):
		return
	
	game_time.advance(step_delta)
	game_state.game_time_elapsed = game_time.elapsed_seconds
	simulation_stepped.emit(step_delta)

## Receives variable render/frame delta from engine loop, accumulates it, and executes
## controlled discrete simulation steps of fixed size (`simulation_step`).
## Protects against spiral-of-death by capping steps per frame.
## Hardened against floating-point precision loss, negative drift, and invalid deltas.
## Returns the number of discrete simulation steps executed.
func update_simulation(render_delta: float) -> int:
	if current_state != LifecycleState.RUNNING:
		return 0
	
	if render_delta <= 0.0 or is_nan(render_delta) or is_inf(render_delta):
		return 0
	
	if simulation_step <= 0.0 or is_nan(simulation_step) or is_inf(simulation_step):
		return 0
	
	time_accumulator += render_delta
	
	# Anti-spiral-of-death safeguard: clamp accumulated time if it exceeds maximum allowable window
	var max_accumulated_time: float = simulation_step * float(max_simulation_steps_per_frame)
	if time_accumulator > max_accumulated_time:
		time_accumulator = max_accumulated_time
	
	var steps_taken: int = 0
	var step_threshold: float = simulation_step - EPSILON
	while time_accumulator >= step_threshold and steps_taken < max_simulation_steps_per_frame:
		step_simulation(simulation_step)
		time_accumulator -= simulation_step
		steps_taken += 1
	
	# Hardened boundary: eliminate negative float underflow or sub-epsilon residue
	if time_accumulator < EPSILON:
		time_accumulator = 0.0
	
	return steps_taken

## Resets accumulated unconsumed render time (e.g. after scene transition or pause).
func reset_accumulator() -> void:
	time_accumulator = 0.0

## Centralized authoritative mutation pathway.
## Enforces command validation before mutation can occur.
## Public state mutations MUST pass through this method.
func execute_command(command: Command) -> CommandResult:
	if command == null:
		var null_err: CommandResult = CommandResult.fail("Cannot execute null command.")
		command_failed.emit(command, null_err)
		return null_err
	
	if current_state != LifecycleState.RUNNING and current_state != LifecycleState.INITIALIZE:
		var state_err: CommandResult = CommandResult.fail("Cannot execute commands outside active runtime.")
		command_failed.emit(command, state_err)
		return state_err
	
	# Step 1: Explicit Validation
	var validation: CommandResult = command.validate(game_state)
	if not validation.success:
		command_failed.emit(command, validation)
		return validation
	
	# Step 2: Authoritative Mutation (strictly after validation succeeded)
	var execution: CommandResult = command._execute_mutation(game_state)
	if execution.success:
		command_executed.emit(command, execution)
	else:
		command_failed.emit(command, execution)
	return execution
