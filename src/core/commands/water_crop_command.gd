class_name WaterCropCommand
extends Command

## Authoritative command to water a tilled or planted plot.
## Marks the plot watered for the day; awards Farming XP.

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
	if state == null or state.farming_state == null:
		return CommandResult.fail("Invalid game state for watering.")
	
	if check_distance and player_position.distance_to(plot_world_position) > 50.0:
		return CommandResult.fail("Too far away to water.")
	
	var plot: SoilPlotState = state.farming_state.get_plot(grid_coord)
	if plot == null or not plot.is_tilled:
		return CommandResult.fail("Cannot water untilled soil. Till with hoe first.")
	
	if plot.is_watered:
		return CommandResult.fail("Soil is already adequately watered today.")
	
	return CommandResult.ok()

func _execute_mutation(state: GameState) -> CommandResult:
	var plot: SoilPlotState = state.farming_state.get_plot(grid_coord)
	plot.is_watered = true
	state.farming_state.set_plot(grid_coord, plot)
	
	# Award watering XP (+2 XP)
	if state.progression_state != null:
		state.progression_state.add_farming_xp(2)
	
	return CommandResult.ok("Plot watered.")
