class_name AcceptObjectiveCommand
extends Command

## Authoritative command to accept Clementine's introductory objective.
## Strictly scoped to Clementine's intro task per Phase 4 directives.
## Command -> Validation -> Mutation -> Event flow per IA-001.

const CLEMENTINE_INTRO_ID: StringName = &"clementine_intro"

var objective_id: StringName = CLEMENTINE_INTRO_ID

func _init(p_objective_id: StringName = CLEMENTINE_INTRO_ID) -> void:
	objective_id = p_objective_id

func validate(state: GameState) -> CommandResult:
	if state == null or state.progression_state == null:
		return CommandResult.fail("Invalid game state for objective acceptance.")
	
	if objective_id != CLEMENTINE_INTRO_ID:
		return CommandResult.fail("Only Clementine's intro objective is supported by this command.")
	
	var current_state: int = state.progression_state.clementine_objective_state
	if current_state == ProgressionState.ClementineObjectiveState.COMPLETED:
		return CommandResult.fail("Clementine's objective has already been completed.")
	
	if current_state == ProgressionState.ClementineObjectiveState.ACTIVE:
		return CommandResult.fail("Clementine's objective is already active.")
	
	return CommandResult.ok()

func _execute_mutation(state: GameState) -> CommandResult:
	state.progression_state.clementine_objective_state = ProgressionState.ClementineObjectiveState.ACTIVE
	state.progression_state.clementine_objective_state_changed.emit(ProgressionState.ClementineObjectiveState.ACTIVE)
	return CommandResult.ok("Accepted Clementine's task: Collect 3 Wild Berries and obtain 1 Raw Hide from a forest hare.")
