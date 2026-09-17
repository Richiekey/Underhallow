class_name DiscoverCreatureCommand
extends Command

## Authoritative command to discover/engage an existing creature.
## Command -> Validation -> Mutation -> Event per HU-001 & IA-001.
## Note: Contextual discovery proximity/range is authoritatively enforced by the
## player interaction layer (PlayerInteraction, PC-001 Section 14/15, range 28.0 px).
## This command owns discovery state mutation, remaining free of competing range logic.

var creature_instance_id: StringName

func _init(p_instance_id: StringName = &"") -> void:
	creature_instance_id = p_instance_id

func validate(state: GameState) -> CommandResult:
	if state == null or state.hunting_state == null:
		return CommandResult.fail("Invalid game state for creature discovery.")
	
	if creature_instance_id == &"":
		return CommandResult.fail("Creature instance ID cannot be empty.")
	
	if not state.hunting_state.has_creature(creature_instance_id):
		return CommandResult.fail("Creature '%s' does not exist." % str(creature_instance_id))
	
	return CommandResult.ok()

func _execute_mutation(state: GameState) -> CommandResult:
	var creature: CreatureState = state.hunting_state.get_creature(creature_instance_id)
	creature.is_discovered = true
	state.hunting_state.creature_updated.emit(creature)
	
	var def: CreatureDefinition = CreatureDatabase.get_definition(creature.definition_id)
	var display: String = def.display_name if def != null else "Creature"
	return CommandResult.ok("Discovered %s." % display)
