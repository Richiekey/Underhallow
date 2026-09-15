class_name SleepCommand
extends Command

## Authoritative command to sleep, ending the day and advancing deterministic simulation.
## Resolves daily crop progression, resets soil watering, and respawns daily gatherables.

var player_position: Vector2
var cottage_position: Vector2
var enforce_proximity: bool

func _init(p_player_pos: Vector2 = Vector2.ZERO, p_cottage_pos: Vector2 = Vector2.ZERO, p_enforce_prox: bool = true) -> void:
	player_position = p_player_pos
	cottage_position = p_cottage_pos
	enforce_proximity = p_enforce_prox

func validate(state: GameState) -> CommandResult:
	if state == null or state.time_state == null or state.farming_state == null or state.world_state == null:
		return CommandResult.fail("Invalid game state for sleep.")
	
	if enforce_proximity and player_position.distance_to(cottage_position) > 60.0:
		return CommandResult.fail("Must be near the cottage to sleep.")
	
	return CommandResult.ok()

func _execute_mutation(state: GameState) -> CommandResult:
	# 1. Advance calendar day
	state.time_state.advance_day()
	state.game_time_elapsed = state.time_state.elapsed_seconds
	
	# 2. Resolve crop growth across all farm plots
	var all_plots: Dictionary = state.farming_state.get_all_plots()
	for coord: Variant in all_plots.keys():
		var plot: SoilPlotState = all_plots[coord] as SoilPlotState
		if plot == null:
			continue
		
		if plot.crop != null:
			if plot.is_watered:
				plot.crop.days_grown += 1
				var crop_def: CropDefinition = CropDatabase.get_definition(plot.crop.crop_id)
				var days_needed: int = crop_def.days_to_mature if crop_def != null else 2
				
				if plot.crop.days_grown >= days_needed:
					plot.crop.growth_stage = 2
					plot.crop.is_mature = true
				else:
					plot.crop.growth_stage = 1
			else:
				# Forgiving Invariant: Unwatered crop growth pauses; crop is NOT destroyed.
				pass
			
			# Reset soil watering for the new day
			plot.is_watered = false
			state.farming_state.set_plot(plot.grid_coord, plot)
		else:
			if plot.is_watered:
				plot.is_watered = false
				state.farming_state.set_plot(plot.grid_coord, plot)
	
	# 3. Respawn daily gatherable resources
	state.world_state.reset_daily_resources()
	
	return CommandResult.ok("Day %d begins." % state.time_state.current_day)
