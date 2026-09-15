class_name HarvestCropCommand
extends Command

## Authoritative command to harvest a mature crop.
## Validates maturity, adds harvest items to inventory, removes crop, awards Farming XP.

var grid_coord: Vector2i
var player_position: Vector2
var plot_world_position: Vector2
var check_distance: bool

func _init(p_coord: Vector2i = Vector2i.ZERO, p_player_pos: Vector2 = Vector2.ZERO, p_plot_pos: Vector2 = Vector2.ZERO, p_check_dist: bool = false) -> void:
	grid_coord = p_coord
	player_position = p_player_pos
	plot_world_position = p_plot_pos
	check_distance = p_check_dist

func validate(state: GameState) -> CommandResult:
	if state == null or state.farming_state == null or state.inventory_state == null:
		return CommandResult.fail("Invalid game state for harvesting.")
	
	if check_distance and player_position.distance_to(plot_world_position) > 50.0:
		return CommandResult.fail("Too far away to harvest crop.")
	
	var plot: SoilPlotState = state.farming_state.get_plot(grid_coord)
	if plot == null or plot.crop == null:
		return CommandResult.fail("No crop to harvest on this plot.")
	
	if not plot.crop.is_mature and plot.crop.growth_stage < 2:
		return CommandResult.fail("Crop is not ready for harvest yet.")
	
	return CommandResult.ok()

func _execute_mutation(state: GameState) -> CommandResult:
	var plot: SoilPlotState = state.farming_state.get_plot(grid_coord)
	var crop: CropState = plot.crop
	var crop_def: CropDefinition = CropDatabase.get_definition(crop.crop_id)
	
	var yield_qty: int = 1
	var harvest_item: StringName = &"crop_carrot"
	var xp_reward: int = 20
	var crop_name: String = "Carrot"
	
	if crop_def != null:
		yield_qty = crop_def.harvest_yield_min
		harvest_item = crop_def.harvest_item_id
		xp_reward = crop_def.xp_reward_harvest
		crop_name = crop_def.display_name
	
	# Add harvested item to inventory
	state.inventory_state.add_item(harvest_item, yield_qty)
	
	# Remove crop from plot (soil remains tilled for future planting)
	plot.crop = null
	state.farming_state.set_plot(grid_coord, plot)
	
	# Award harvest XP
	if state.progression_state != null:
		state.progression_state.add_farming_xp(xp_reward)
	
	return CommandResult.ok("Harvested %d %s!" % [yield_qty, crop_name])
