class_name SaveData
extends RefCounted

## Versioned persistence data transfer object.
## Note: `timestamp` is wall-clock persistence metadata only and never drives
## authoritative GameTime or simulation state. Authoritative time is stored in `game_time_elapsed`.

const CURRENT_SCHEMA_VERSION: int = 1

var schema_version: int = CURRENT_SCHEMA_VERSION
var timestamp: int = 0 # Metadata only (wall-clock UNIX timestamp when saved)
var game_time_elapsed: float = 0.0 # Authoritative simulation time
var payload: Dictionary = {}

func _init(p_version: int = CURRENT_SCHEMA_VERSION, p_timestamp: int = 0, p_game_time: float = 0.0, p_payload: Dictionary = {}) -> void:
	schema_version = p_version
	timestamp = p_timestamp
	game_time_elapsed = maxf(0.0, p_game_time)
	payload = p_payload

func to_dictionary() -> Dictionary:
	return {
		"schema_version": schema_version,
		"timestamp": timestamp,
		"game_time_elapsed": game_time_elapsed,
		"payload": payload
	}

static func from_dictionary(dict: Dictionary) -> SaveData:
	var version: int = int(dict.get("schema_version", 0))
	var ts: int = int(dict.get("timestamp", 0))
	var gt: float = float(dict.get("game_time_elapsed", 0.0))
	var p: Dictionary = dict.get("payload", {})
	return SaveData.new(version, ts, gt, p)
