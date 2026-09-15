class_name GameState
extends RefCounted

## Authoritative domain state container for Underhallow.
## Strictly data-only. Zero rendering dependencies, zero scene-tree nodes.

var game_time_elapsed: float = 0.0
var test_counter: int = 0
var player_state: PlayerState

func _init() -> void:
	player_state = PlayerState.new()
	reset()

func reset() -> void:
	game_time_elapsed = 0.0
	test_counter = 0
	if player_state != null:
		player_state.reset()

func to_dictionary() -> Dictionary:
	return {
		"game_time_elapsed": game_time_elapsed,
		"test_counter": test_counter,
		"player": player_state.to_dictionary() if player_state != null else {}
	}

func from_dictionary(dict: Dictionary) -> void:
	game_time_elapsed = float(dict.get("game_time_elapsed", 0.0))
	test_counter = int(dict.get("test_counter", 0))
	if player_state == null:
		player_state = PlayerState.new()
	if dict.has("player") and dict["player"] is Dictionary:
		player_state.from_dictionary(dict["player"])
