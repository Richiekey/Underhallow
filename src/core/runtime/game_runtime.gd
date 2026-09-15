class_name GameRuntime
extends Node

## Central runtime lifecycle coordinator and authoritative mutation gateway for Underhallow.
## Owns core state, simulation time, persistence boundary, and input provider.
## Zero Autoload singletons; managed via explicit scene composition.

enum LifecycleState {
	BOOT,
	INITIALIZE,
	RUNNING,
	SHUTDOWN
}

signal lifecycle_changed(new_state: LifecycleState)
signal command_executed(command: Command, result: CommandResult)
signal command_failed(command: Command, result: CommandResult)

var current_state: LifecycleState = LifecycleState.BOOT
var game_state: GameState = null
var game_time: GameTime = null
var persistence: PersistenceBoundary = null
var input_provider: InputProvider = null

func _init() -> void:
	game_state = GameState.new()
	game_time = GameTime.new()
	persistence = PersistenceBoundary.new()
	input_provider = InputProvider.new()
	current_state = LifecycleState.BOOT

## Transitions runtime from BOOT to INITIALIZE.
func initialize_runtime() -> void:
	if current_state != LifecycleState.BOOT:
		printerr("Runtime Warning: initialize_runtime() called while in state ", current_state)
		return
	
	current_state = LifecycleState.INITIALIZE
	lifecycle_changed.emit(current_state)
	
	game_state.reset()
	game_time.reset()

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

## Advances deterministic simulation time when in RUNNING state.
func update_simulation(delta: float) -> void:
	if current_state != LifecycleState.RUNNING:
		return
	
	game_time.advance(delta)
	game_state.game_time_elapsed = game_time.elapsed_seconds

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
