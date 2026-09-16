class_name PlaceBuildingCommand
extends Command

## Authoritative command to construct/place a building instance.
## Command -> Validation -> Mutation -> Event per BI-001 & Invariant 4.

var instance_id: StringName
var building_id: StringName
var grid_coord: Vector2i
var orientation: int

func _init(
	p_instance_id: StringName = &"",
	p_building_id: StringName = &"",
	p_coord: Vector2i = Vector2i.ZERO,
	p_orientation: int = 0
) -> void:
	instance_id = p_instance_id
	building_id = p_building_id
	grid_coord = p_coord
	orientation = p_orientation

func validate(state: GameState) -> CommandResult:
	if state == null or state.building_state == null or state.inventory_state == null:
		return CommandResult.fail("Invalid game state for construction.")
	
	if instance_id == &"":
		return CommandResult.fail("Building instance ID cannot be empty.")
	
	if building_id == &"":
		return CommandResult.fail("Building ID cannot be empty.")
	
	var def: BuildingDefinition = BuildingDatabase.get_definition(building_id)
	if def == null:
		return CommandResult.fail("Unknown building definition '%s'." % str(building_id))
	
	# Duplicate identity check
	if state.building_state.has_instance(instance_id):
		return CommandResult.fail("Building instance '%s' already exists." % str(instance_id))
	
	# Collision / overlap checks
	if state.building_state.has_building_at(grid_coord):
		return CommandResult.fail("Placement coordinate %s is already occupied by another building." % str(grid_coord))
	
	if state.farming_state != null and state.farming_state.has_plot(grid_coord):
		return CommandResult.fail("Placement coordinate %s collides with an existing farm plot." % str(grid_coord))
	
	# Materials check: verify all required resources exist in inventory
	for mat_id: Variant in def.material_requirements.keys():
		var req_qty: int = int(def.material_requirements[mat_id])
		var item_id: StringName = StringName(str(mat_id))
		if not state.inventory_state.has_item(item_id, req_qty):
			var item_def: ItemDefinition = ItemDatabase.get_definition(item_id)
			var item_name: String = item_def.display_name if item_def != null else str(item_id)
			return CommandResult.fail("Insufficient materials for %s: requires %d of %s." % [def.display_name, req_qty, item_name])
	
	return CommandResult.ok()

func _execute_mutation(state: GameState) -> CommandResult:
	var def: BuildingDefinition = BuildingDatabase.get_definition(building_id)
	
	# Atomic mutation: 1. Deduct all required materials
	for mat_id: Variant in def.material_requirements.keys():
		var req_qty: int = int(def.material_requirements[mat_id])
		var item_id: StringName = StringName(str(mat_id))
		state.inventory_state.remove_item(item_id, req_qty)
	
	# Atomic mutation: 2. Record authoritative building in BuildingState
	state.building_state.place_building(instance_id, building_id, grid_coord, orientation)
	
	return CommandResult.ok("Constructed %s." % def.display_name)
