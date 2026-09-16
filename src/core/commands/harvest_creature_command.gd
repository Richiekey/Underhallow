class_name HarvestCreatureCommand
extends Command

## Authoritative command to harvest a defeated creature.
## Command -> Validation -> Mutation -> Event per HU-001 & Invariant 6.

var creature_instance_id: StringName
var player_position: Vector2
var creature_position: Vector2
var check_distance: bool

func _init(
	p_instance_id: StringName = &"",
	p_player_pos: Vector2 = Vector2.ZERO,
	p_creature_pos: Vector2 = Vector2.ZERO,
	p_check_dist: bool = false
) -> void:
	creature_instance_id = p_instance_id
	player_position = p_player_pos
	creature_position = p_creature_pos
	check_distance = p_check_dist

func validate(state: GameState) -> CommandResult:
	if state == null or state.hunting_state == null or state.inventory_state == null:
		return CommandResult.fail("Invalid game state for creature harvest.")
	
	if creature_instance_id == &"":
		return CommandResult.fail("Creature instance ID cannot be empty.")
	
	if not state.hunting_state.has_creature(creature_instance_id):
		return CommandResult.fail("Creature '%s' does not exist." % str(creature_instance_id))
	
	var creature: CreatureState = state.hunting_state.get_creature(creature_instance_id)
	if not creature.is_defeated:
		return CommandResult.fail("Living creature cannot be harvested.")
	
	if creature.is_harvested:
		return CommandResult.fail("Creature has already been harvested.")
	
	if check_distance and player_position.distance_to(creature_position) > 60.0:
		return CommandResult.fail("Too far away to harvest creature.")
	
	return CommandResult.ok()

func _execute_mutation(state: GameState) -> CommandResult:
	var creature: CreatureState = state.hunting_state.get_creature(creature_instance_id)
	creature.is_harvested = true
	
	var def: CreatureDefinition = CreatureDatabase.get_definition(creature.definition_id)
	var harvest_item: StringName = def.harvest_item_id if def != null else &"resource_raw_hide"
	var harvest_count: int = def.harvest_item_count if def != null else 1
	
	state.inventory_state.add_item(harvest_item, harvest_count)
	state.hunting_state.creature_updated.emit(creature)
	
	var item_def: ItemDefinition = ItemDatabase.get_definition(harvest_item)
	var item_name: String = item_def.display_name if item_def != null else "Raw Hide"
	var creature_name: String = def.display_name if def != null else "Creature"
	
	return CommandResult.ok("Harvested %d %s from %s." % [harvest_count, item_name, creature_name])
