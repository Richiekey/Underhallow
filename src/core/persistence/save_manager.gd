class_name SaveManager
extends RefCounted

## Local JSON file persistence storage adapter for Underhallow.
## Satisfies IA-001 §17.1-§17.2 and §18.1 (Prototype Local Save Storage).
## Writes human-readable structured JSON to user://saves/{slot_name}.json.
## Pure RefCounted container with zero scene tree or rendering dependencies.

signal save_completed(slot_name: String)
signal load_completed(slot_name: String)

const SAVES_DIR: String = "user://saves"
const DEFAULT_SLOT: String = "default"

var persistence: PersistenceBoundary = null

func _init(p_persistence: PersistenceBoundary = null) -> void:
	if p_persistence != null:
		persistence = p_persistence
	else:
		persistence = PersistenceBoundary.new()

## Returns the canonical file system path for a given save slot.
func get_save_path(slot_name: String = DEFAULT_SLOT) -> String:
	return "%s/%s.json" % [SAVES_DIR, slot_name]

## Checks whether a save file exists for the given slot.
func has_save(slot_name: String = DEFAULT_SLOT) -> bool:
	return FileAccess.file_exists(get_save_path(slot_name))

## Deletes the save file for the given slot if it exists.
func delete_save(slot_name: String = DEFAULT_SLOT) -> bool:
	var path: String = get_save_path(slot_name)
	if not FileAccess.file_exists(path):
		return false
	var err: Error = DirAccess.remove_absolute(path)
	if err != OK:
		printerr("SaveManager Error: Failed to remove save file at: ", path, " (Error: ", err, ")")
		return false
	return true

## Serializes and writes authoritative state and simulation time to disk as JSON.
## Ensures the save directory exists and validates output format.
func save_game(game_state: GameState, game_time: GameTime, slot_name: String = DEFAULT_SLOT) -> bool:
	if game_state == null:
		printerr("SaveManager Error: Cannot save null game_state.")
		return false
	if game_time == null:
		printerr("SaveManager Error: Cannot save null game_time.")
		return false
	if persistence == null:
		printerr("SaveManager Error: PersistenceBoundary reference is null.")
		return false
	
	# Ensure user://saves directory exists
	var dir: DirAccess = DirAccess.open("user://")
	if dir != null:
		if not dir.dir_exists("saves"):
			var mk_err: Error = dir.make_dir_recursive("saves")
			if mk_err != OK and not dir.dir_exists("saves"):
				printerr("SaveManager Error: Failed to create saves directory (Error: ", mk_err, ")")
				return false
	else:
		var abs_err: Error = DirAccess.make_dir_recursive_absolute(SAVES_DIR)
		if abs_err != OK and not DirAccess.dir_exists_absolute(SAVES_DIR):
			printerr("SaveManager Error: Failed to create saves directory via absolute path (Error: ", abs_err, ")")
			return false
	
	var save_data: SaveData = persistence.serialize_state(game_state, game_time)
	if save_data == null:
		printerr("SaveManager Error: PersistenceBoundary failed to serialize state.")
		return false
	
	var dict: Dictionary = save_data.to_dictionary()
	var json_string: String = JSON.stringify(dict, "\t")
	
	var path: String = get_save_path(slot_name)
	var file: FileAccess = FileAccess.open(path, FileAccess.WRITE)
	if file == null:
		printerr("SaveManager Error: Failed to open save file for writing at: ", path, " (Error: ", FileAccess.get_open_error(), ")")
		return false
	
	file.store_string(json_string)
	file.close()
	
	save_completed.emit(slot_name)
	return true

## Reads, parses, and validates a JSON save file from disk.
## Returns deserialized SaveData DTO, or null on any validation failure.
func load_game(slot_name: String = DEFAULT_SLOT) -> SaveData:
	var path: String = get_save_path(slot_name)
	if not FileAccess.file_exists(path):
		return null
	
	var file: FileAccess = FileAccess.open(path, FileAccess.READ)
	if file == null:
		printerr("SaveManager Error: Failed to open save file for reading at: ", path, " (Error: ", FileAccess.get_open_error(), ")")
		return null
	
	var json_string: String = file.get_as_text()
	file.close()
	
	var json: JSON = JSON.new()
	var parse_err: Error = json.parse(json_string)
	if parse_err != OK:
		printerr("SaveManager Error: Failed to parse JSON from save file: ", path, " (Error: ", json.get_error_message(), " at line ", json.get_error_line(), ")")
		return null
	
	if not (json.data is Dictionary):
		printerr("SaveManager Error: Save file root is not a Dictionary in: ", path)
		return null
	
	var dict: Dictionary = json.data as Dictionary
	if not dict.has("schema_version"):
		printerr("SaveManager Error: Missing schema_version in save file: ", path)
		return null
	
	var version: int = int(dict.get("schema_version", 0))
	if version != SaveData.CURRENT_SCHEMA_VERSION:
		printerr("SaveManager Error: Unsupported schema version ", version, " (expected ", SaveData.CURRENT_SCHEMA_VERSION, ") in: ", path)
		return null
	
	var save_data: SaveData = SaveData.from_dictionary(dict)
	load_completed.emit(slot_name)
	return save_data
