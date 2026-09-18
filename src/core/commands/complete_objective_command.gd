class_name CompleteObjectiveCommand
extends Command

## Authoritative command to complete Clementine's introductory objective.
## Strictly scoped to Clementine's intro task per Phase 4 directives.
## Command -> Validation -> Mutation -> Event flow per IA-001.

const CLEMENTINE_INTRO_ID: StringName = &"clementine_intro"
const REWARD_FARMING_XP: int = 20

var objective_id: StringName = CLEMENTINE_INTRO_ID
var player_position: Vector2 = Vector2.ZERO
var npc_position: Vector2 = Vector2.ZERO
var check_distance: bool = false

func _init(
	p_objective_id: StringName = CLEMENTINE_INTRO_ID,
	p_player_pos: Vector2 = Vector2.ZERO,
	p_npc_pos: Vector2 = Vector2.ZERO,
	p_check_dist: bool = false
) -> void:
	objective_id = p_objective_id
	player_position = p_player_pos
	npc_position = p_npc_pos
	check_distance = p_check_dist

func validate(state: GameState) -> CommandResult:
	if state == null or state.progression_state == null or state.inventory_state == null:
		return CommandResult.fail("Invalid game state for objective completion.")
	
	if objective_id != CLEMENTINE_INTRO_ID:
		return CommandResult.fail("Only Clementine's intro objective is supported by this command.")
	
	var current_state: int = state.progression_state.clementine_objective_state
	if current_state == ProgressionState.ClementineObjectiveState.COMPLETED:
		return CommandResult.fail("Clementine's objective has already been completed.")
	
	if current_state != ProgressionState.ClementineObjectiveState.ACTIVE:
		return CommandResult.fail("Clementine's objective is not active.")
	
	if state.progression_state.clementine_reward_granted:
		return CommandResult.fail("Reward has already been granted for this objective.")
	
	if check_distance and player_position.distance_to(npc_position) > 60.0:
		return CommandResult.fail("Too far away to complete objective with Clementine.")
	
	# Verify inventory requirements
	var berries: int = state.inventory_state.get_quantity(&"resource_wild_berries")
	if berries < 3:
		return CommandResult.fail("Insufficient Wild Berries: have %d, need 3." % berries)
	
	var hide: int = state.inventory_state.get_quantity(&"resource_raw_hide")
	if hide < 1:
		return CommandResult.fail("Missing Raw Hide: need 1 obtained from a forest hare.")
	
	# Verify hunting contract: if hunting state has registered creatures, verify a hare was harvested
	if state.hunting_state != null:
		var creatures: Dictionary = state.hunting_state.get_all_creatures()
		var has_hares: bool = false
		var hare_harvested: bool = false
		for c: Variant in creatures.values():
			var creature: CreatureState = c as CreatureState
			if creature != null and creature.definition_id == &"hare":
				has_hares = true
				if creature.is_harvested:
					hare_harvested = true
					break
		if has_hares and not hare_harvested:
			return CommandResult.fail("Raw Hide must be obtained by harvesting a defeated forest hare.")
	
	return CommandResult.ok()

func _execute_mutation(state: GameState) -> CommandResult:
	state.progression_state.clementine_objective_state = ProgressionState.ClementineObjectiveState.COMPLETED
	state.progression_state.clementine_reward_granted = true
	state.progression_state.add_farming_xp(REWARD_FARMING_XP)
	state.progression_state.clementine_objective_state_changed.emit(ProgressionState.ClementineObjectiveState.COMPLETED)
	
	# Gathered materials (berries and hide) are preserved in inventory per Section 9
	return CommandResult.ok("Completed Clementine's task! Awarded %d Farming XP." % REWARD_FARMING_XP)
