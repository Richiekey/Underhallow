class_name PersistenceBoundary
extends RefCounted

## Boundary abstraction decoupling in-memory domain state from persistence formats.
## Rejects unversioned or incompatible save data.
## Critical: `timestamp` is metadata only and never drives simulation time.

signal save_serialized(save_data: SaveData)
signal save_deserialized(save_data: SaveData)

func serialize_state(state: GameState, time: GameTime) -> SaveData:
	# Store wall-clock timestamp purely as persistence metadata (e.g. for display)
	var metadata_timestamp: int = int(Time.get_unix_time_from_system())
	# Authoritative simulation time is preserved directly from GameTime
	var sim_time: float = time.elapsed_seconds
	state.game_time_elapsed = sim_time
	if state.time_state != null:
		state.time_state.sync_from_game_time(time)
	var payload: Dictionary = state.to_dictionary()
	
	var save: SaveData = SaveData.new(
		SaveData.CURRENT_SCHEMA_VERSION,
		metadata_timestamp,
		sim_time,
		payload
	)
	save_serialized.emit(save)
	return save

func deserialize_state(save_data: SaveData, target_state: GameState, target_time: GameTime) -> bool:
	if save_data == null:
		printerr("Persistence Error: Attempted to deserialize null save data.")
		return false
	
	if save_data.schema_version != SaveData.CURRENT_SCHEMA_VERSION:
		printerr("Persistence Error: Unsupported schema version ", save_data.schema_version, 
			" (expected ", SaveData.CURRENT_SCHEMA_VERSION, ").")
		return false
	
	# Authoritative simulation time is restored directly from game_time_elapsed.
	# The metadata timestamp is intentionally ignored for simulation time calculation.
	# Authority chain: SaveData.game_time_elapsed -> GameTime -> TimeState
	target_time.reset(save_data.game_time_elapsed)
	target_state.from_dictionary(save_data.payload)
	target_state.game_time_elapsed = target_time.elapsed_seconds
	if target_state.time_state != null:
		target_state.time_state.sync_from_game_time(target_time)
	save_deserialized.emit(save_data)
	return true
