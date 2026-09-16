class_name CreatureState
extends RefCounted

## Authoritative domain state for an individual creature instance.
## Pure data container per HU-001 & Invariant 4.

var instance_id: StringName = &""
var definition_id: StringName = &""
var current_health: int = 10
var max_health: int = 10
var is_discovered: bool = false
var is_defeated: bool = false
var is_harvested: bool = false
var position: Vector2 = Vector2.ZERO

func _init(
	p_instance_id: StringName = &"",
	p_def_id: StringName = &"",
	p_health: int = 10,
	p_max_health: int = 10,
	p_discovered: bool = false,
	p_defeated: bool = false,
	p_harvested: bool = false,
	p_pos: Vector2 = Vector2.ZERO
) -> void:
	instance_id = p_instance_id
	definition_id = p_def_id
	current_health = p_health
	max_health = p_max_health
	is_discovered = p_discovered
	is_defeated = p_defeated
	is_harvested = p_harvested
	position = p_pos

func to_dictionary() -> Dictionary:
	return {
		"instance_id": str(instance_id),
		"definition_id": str(definition_id),
		"current_health": current_health,
		"max_health": max_health,
		"is_discovered": is_discovered,
		"is_defeated": is_defeated,
		"is_harvested": is_harvested,
		"pos_x": position.x,
		"pos_y": position.y
	}

static func from_dictionary(dict: Dictionary) -> CreatureState:
	var inst_id: StringName = StringName(str(dict.get("instance_id", "")))
	var def_id: StringName = StringName(str(dict.get("definition_id", "")))
	var health: int = int(dict.get("current_health", 10))
	var m_health: int = int(dict.get("max_health", 10))
	var disc: bool = bool(dict.get("is_discovered", false))
	var def: bool = bool(dict.get("is_defeated", false))
	var harv: bool = bool(dict.get("is_harvested", false))
	var pos: Vector2 = Vector2(float(dict.get("pos_x", 0.0)), float(dict.get("pos_y", 0.0)))
	return CreatureState.new(inst_id, def_id, health, m_health, disc, def, harv, pos)
