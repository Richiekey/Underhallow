class_name TillSoilCommand
extends Command

## Authoritative command to till a farm grid plot.
## Command -> Validation -> Mutation -> Event per IA-001 Section 3.3.

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
		return CommandResult.fail("Invalid game state for tilling.")
	
	if not FarmingGrid.is_valid_cell(grid_coord):
		return CommandResult.fail("Grid coordinate (%d, %d) is outside the valid farming boundary." % [grid_coord.x, grid_coord.y])
	
	if check_distance and player_position.distance_to(plot_world_position) > 50.0:
		return CommandResult.fail("Too far away to till soil.")
	
	var plot: SoilPlotState = state.farming_state.get_plot(grid_coord)
	if plot != null and plot.is_tilled:
		return CommandResult.fail("Soil is already tilled.")
	
	return CommandResult.ok()

func _execute_mutation(state: GameState) -> CommandResult:
	var plot: SoilPlotState = state.farming_state.get_plot(grid_coord)
	if plot == null:
		plot = SoilPlotState.new(grid_coord, true, false, null)
		state.farming_state.set_plot(grid_coord, plot)
	else:
		plot.is_tilled = true
		state.farming_state.set_plot(grid_coord, plot)
	
	# Award +2 Farming XP (Tier B prototype tuning)
	if state.progression_state != null:
		state.progression_state.add_farming_xp(2)
	
	return CommandResult.ok("Soil tilled.")
