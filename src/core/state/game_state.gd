class_name GameState
extends RefCounted

## Authoritative domain state container for Underhallow.
## Strictly data-only. Zero rendering dependencies, zero scene-tree nodes.
## Integrates focused domain sub-states per IA-001 Section 3.2.

var game_time_elapsed: float = 0.0
var test_counter: int = 0
var player_state: PlayerState
var time_state: TimeState
var inventory_state: InventoryState
var farming_state: FarmingState
var progression_state: ProgressionState
var world_state: WorldState

func _init() -> void:
	player_state = PlayerState.new()
	time_state = TimeState.new()
	inventory_state = InventoryState.new()
	farming_state = FarmingState.new()
	progression_state = ProgressionState.new()
	world_state = WorldState.new()
	reset()

func reset() -> void:
	game_time_elapsed = 0.0
	test_counter = 0
	if player_state != null:
		player_state.reset()
	if time_state != null:
		time_state.reset()
	if inventory_state != null:
		inventory_state.reset()
	if farming_state != null:
		farming_state.reset()
	if progression_state != null:
		progression_state.reset()
	if world_state != null:
		world_state.reset()

func to_dictionary() -> Dictionary:
	return {
		"game_time_elapsed": game_time_elapsed,
		"test_counter": test_counter,
		"player": player_state.to_dictionary() if player_state != null else {},
		"time": time_state.to_dictionary() if time_state != null else {},
		"inventory": inventory_state.to_dictionary() if inventory_state != null else {},
		"farming": farming_state.to_dictionary() if farming_state != null else {},
		"progression": progression_state.to_dictionary() if progression_state != null else {},
		"world": world_state.to_dictionary() if world_state != null else {}
	}

func from_dictionary(dict: Dictionary) -> void:
	game_time_elapsed = float(dict.get("game_time_elapsed", 0.0))
	test_counter = int(dict.get("test_counter", 0))
	
	if player_state == null:
		player_state = PlayerState.new()
	if dict.has("player") and dict["player"] is Dictionary:
		player_state.from_dictionary(dict["player"])
	
	if time_state == null:
		time_state = TimeState.new()
	if dict.has("time") and dict["time"] is Dictionary:
		time_state.from_dictionary(dict["time"])
	# Canonical synchronization: ensure time_state calendar derives strictly from game_time_elapsed
	time_state.sync_from_elapsed_seconds(game_time_elapsed)
	
	if inventory_state == null:
		inventory_state = InventoryState.new()
	if dict.has("inventory") and dict["inventory"] is Dictionary:
		inventory_state.from_dictionary(dict["inventory"])
	
	if farming_state == null:
		farming_state = FarmingState.new()
	if dict.has("farming") and dict["farming"] is Dictionary:
		farming_state.from_dictionary(dict["farming"])
	
	if progression_state == null:
		progression_state = ProgressionState.new()
	if dict.has("progression") and dict["progression"] is Dictionary:
		progression_state.from_dictionary(dict["progression"])
	
	if world_state == null:
		world_state = WorldState.new()
	if dict.has("world") and dict["world"] is Dictionary:
		world_state.from_dictionary(dict["world"])
