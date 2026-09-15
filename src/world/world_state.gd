class_name WorldState
extends RefCounted

## Authoritative domain state container for world/resource node state.
## Pure data container per IA-001 & user architectural guidance.
## Tracks world resource node states (e.g. gathered nodes). Zero calendar/day logic.

signal resource_state_changed(node_id: StringName, is_gathered: bool)
signal world_state_cleared()

# Dictionary mapping StringName (node_id) -> bool (is_gathered)
var _gathered_resources: Dictionary = {}

func _init() -> void:
	reset()

func reset() -> void:
	_gathered_resources.clear()
	world_state_cleared.emit()

func mark_gathered(node_id: StringName) -> void:
	if node_id != &"":
		_gathered_resources[node_id] = true
		resource_state_changed.emit(node_id, true)

func is_gathered(node_id: StringName) -> bool:
	return _gathered_resources.get(node_id, false)

func reset_daily_resources() -> void:
	_gathered_resources.clear()
	world_state_cleared.emit()

func to_dictionary() -> Dictionary:
	var serialized: Dictionary = {}
	for id: Variant in _gathered_resources.keys():
		serialized[str(id)] = _gathered_resources[id]
	return {
		"gathered_resources": serialized
	}

func from_dictionary(dict: Dictionary) -> void:
	_gathered_resources.clear()
	var raw_gathered: Dictionary = dict.get("gathered_resources", {})
	for id_str: Variant in raw_gathered.keys():
		_gathered_resources[StringName(str(id_str))] = bool(raw_gathered[id_str])
	world_state_cleared.emit()
