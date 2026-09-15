class_name PlantCropCommand
extends Command

## Authoritative command to plant a seed on a tilled plot.
## Consumes 1 seed from inventory, creates CropState on the plot, awards Farming XP.

var grid_coord: Vector2i
var crop_id: StringName
var player_position: Vector2
var plot_world_position: Vector2
var check_distance: bool

func _init(p_coord: Vector2i = Vector2i.ZERO, p_crop_id: StringName = &"carrot", p_player_pos: Vector2 = Vector2.ZERO, p_plot_pos: Vector2 = Vector2.ZERO, p_check_dist: bool = false) -> void:
	grid_coord = p_coord
	crop_id = p_crop_id
	player_position = p_player_pos
	plot_world_position = p_plot_pos
	check_distance = p_check_dist

func validate(state: GameState) -> CommandResult:
	if state == null or state.farming_state == null or state.inventory_state == null:
		return CommandResult.fail("Invalid game state for planting.")
	
	if not FarmingGrid.is_valid_cell(grid_coord):
		return CommandResult.fail("Grid coordinate (%d, %d) is outside the valid farming boundary." % [grid_coord.x, grid_coord.y])
	
	if check_distance and player_position.distance_to(plot_world_position) > 50.0:
		return CommandResult.fail("Too far away to plant seed.")
	
	var plot: SoilPlotState = state.farming_state.get_plot(grid_coord)
	if plot == null or not plot.is_tilled:
		return CommandResult.fail("Cannot plant on untilled soil. Till with hoe first.")
	
	if plot.crop != null:
		return CommandResult.fail("Plot already contains a growing crop.")
	
	var crop_def: CropDefinition = CropDatabase.get_definition(crop_id)
	if crop_def == null:
		return CommandResult.fail("Unknown crop definition: " + str(crop_id))
	
	if not state.inventory_state.has_item(crop_def.seed_item_id, 1):
		return CommandResult.fail("No %s in inventory." % crop_def.seed_item_id)
	
	return CommandResult.ok()

func _execute_mutation(state: GameState) -> CommandResult:
	var crop_def: CropDefinition = CropDatabase.get_definition(crop_id)
	if crop_def == null:
		return CommandResult.fail("Unknown crop definition: " + str(crop_id))
	
	# Consume 1 seed from inventory
	if not state.inventory_state.remove_item(crop_def.seed_item_id, 1):
		return CommandResult.fail("Failed to consume seed from inventory.")
	
	var plot: SoilPlotState = state.farming_state.get_plot(grid_coord)
	plot.crop = CropState.new(crop_id, 0, 0, false)
	state.farming_state.set_plot(grid_coord, plot)
	
	# Award planting XP (+5 XP)
	if state.progression_state != null:
		state.progression_state.add_farming_xp(crop_def.xp_reward_plant)
	
	return CommandResult.ok("Planted %s." % crop_def.display_name)
