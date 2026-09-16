class_name AttackCreatureCommand
extends Command

## Authoritative command to perform a basic attack against a creature.
## Command -> Validation -> Mutation -> Event per HU-001 & Invariant 4.

var creature_instance_id: StringName
var damage: int
var player_position: Vector2
var creature_position: Vector2
var check_distance: bool

func _init(
	p_instance_id: StringName = &"",
	p_damage: int = 5,
	p_player_pos: Vector2 = Vector2.ZERO,
	p_creature_pos: Vector2 = Vector2.ZERO,
	p_check_dist: bool = false
) -> void:
	creature_instance_id = p_instance_id
	damage = maxi(1, p_damage)
	player_position = p_player_pos
	creature_position = p_creature_pos
	check_distance = p_check_dist

func validate(state: GameState) -> CommandResult:
	if state == null or state.hunting_state == null:
		return CommandResult.fail("Invalid game state for creature attack.")
	
	if creature_instance_id == &"":
		return CommandResult.fail("Creature instance ID cannot be empty.")
	
	if not state.hunting_state.has_creature(creature_instance_id):
		return CommandResult.fail("Creature '%s' does not exist." % str(creature_instance_id))
	
	var creature: CreatureState = state.hunting_state.get_creature(creature_instance_id)
	if creature.is_defeated:
		return CommandResult.fail("Creature has already been defeated.")
	
	if creature.is_harvested:
		return CommandResult.fail("Creature has already been harvested.")
	
	if check_distance and player_position.distance_to(creature_position) > 60.0:
		return CommandResult.fail("Too far away to attack creature.")
	
	return CommandResult.ok()

func _execute_mutation(state: GameState) -> CommandResult:
	var creature: CreatureState = state.hunting_state.get_creature(creature_instance_id)
	creature.current_health = maxi(0, creature.current_health - damage)
	
	var defeated_now: bool = false
	if creature.current_health == 0:
		creature.is_defeated = true
		defeated_now = true
	
	state.hunting_state.creature_updated.emit(creature)
	
	var def: CreatureDefinition = CreatureDatabase.get_definition(creature.definition_id)
	var display: String = def.display_name if def != null else "Creature"
	
	if defeated_now:
		return CommandResult.ok("Attacked %s for %d damage. Creature defeated!" % [display, damage])
	else:
		return CommandResult.ok("Attacked %s for %d damage (%d HP remaining)." % [display, damage, creature.current_health])
