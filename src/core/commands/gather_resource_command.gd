class_name GatherResourceCommand
extends Command

## Authoritative command to gather a wild resource node.
## Command -> Validation -> Mutation -> Event per IA-001 Section 3.3.

var node_id: StringName
var resource_item_id: StringName
var yield_count: int
var player_position: Vector2
var node_world_position: Vector2
var check_distance: bool

func _init(p_node_id: StringName = &"", p_resource_id: StringName = &"resource_wild_berries", p_yield: int = 3, p_player_pos: Vector2 = Vector2.ZERO, p_node_pos: Vector2 = Vector2.ZERO, p_check_dist: bool = false) -> void:
	node_id = p_node_id
	resource_item_id = p_resource_id
	yield_count = maxi(1, p_yield)
	player_position = p_player_pos
	node_world_position = p_node_pos
	check_distance = p_check_dist

func validate(state: GameState) -> CommandResult:
	if state == null or state.world_state == null or state.inventory_state == null:
		return CommandResult.fail("Invalid game state for gathering.")
	
	if check_distance and player_position.distance_to(node_world_position) > 50.0:
		return CommandResult.fail("Too far away to gather.")
	
	if state.world_state.is_gathered(node_id):
		return CommandResult.fail("Resource has already been gathered today.")
	
	return CommandResult.ok()

func _execute_mutation(state: GameState) -> CommandResult:
	state.world_state.mark_gathered(node_id)
	state.inventory_state.add_item(resource_item_id, yield_count)
	
	var item_def: ItemDefinition = ItemDatabase.get_definition(resource_item_id)
	var item_name: String = item_def.display_name if item_def != null else "Wild Berries"
	return CommandResult.ok("Gathered %d %s." % [yield_count, item_name])
