class_name Command
extends RefCounted

## Abstract base class for authoritative state mutation commands.
## Direct mutation without validation is strictly prohibited.
## Public state mutations must be dispatched through GameRuntime.execute_command().

## Validates whether this command is permitted to execute against the current state.
func validate(_state: GameState) -> CommandResult:
	return CommandResult.ok()

## Internal mutation implementation. Subclasses override this to perform state changes.
## Must only be invoked after validate() has succeeded.
func _execute_mutation(_state: GameState) -> CommandResult:
	return CommandResult.ok()

## Context-aware mutation implementation for commands requiring authoritative simulation time.
## Subclasses requiring GameTime override this. By default, delegates to _execute_mutation(state).
func _execute_with_time(state: GameState, _time: GameTime) -> CommandResult:
	return _execute_mutation(state)

## Guarded execution: enforces validation check before any mutation can occur.
func execute_verified(state: GameState, time: GameTime = null) -> CommandResult:
	var validation: CommandResult = validate(state)
	if not validation.success:
		return validation
	if time != null:
		return _execute_with_time(state, time)
	return _execute_mutation(state)
