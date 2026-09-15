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

## Guarded execution: enforces validation check before any mutation can occur.
func execute_verified(state: GameState) -> CommandResult:
	var validation: CommandResult = validate(state)
	if not validation.success:
		return validation
	return _execute_mutation(state)
