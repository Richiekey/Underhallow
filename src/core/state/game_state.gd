class_name GameState
extends RefCounted

## Authoritative domain state container for Underhallow.
## Strictly data-only. Zero rendering dependencies, zero scene-tree nodes.

var game_time_elapsed: float = 0.0
var test_counter: int = 0

func _init() -> void:
	reset()

func reset() -> void:
	game_time_elapsed = 0.0
	test_counter = 0

func to_dictionary() -> Dictionary:
	return {
		"game_time_elapsed": game_time_elapsed,
		"test_counter": test_counter
	}

func from_dictionary(dict: Dictionary) -> void:
	game_time_elapsed = float(dict.get("game_time_elapsed", 0.0))
	test_counter = int(dict.get("test_counter", 0))
