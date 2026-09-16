class_name BuildingInstance
extends RefCounted

## Authoritative domain state for an individual placed building/structure instance.
## Pure data container per BI-001 & Invariant 4.

var instance_id: StringName = &""
var building_id: StringName = &""
var grid_coord: Vector2i = Vector2i.ZERO
var orientation: int = 0

func _init(
	p_instance_id: StringName = &"",
	p_building_id: StringName = &"",
	p_coord: Vector2i = Vector2i.ZERO,
	p_orientation: int = 0
) -> void:
	instance_id = p_instance_id
	building_id = p_building_id
	grid_coord = p_coord
	orientation = p_orientation

func to_dictionary() -> Dictionary:
	return {
		"instance_id": str(instance_id),
		"building_id": str(building_id),
		"coord_x": grid_coord.x,
		"coord_y": grid_coord.y,
		"orientation": orientation
	}

static func from_dictionary(dict: Dictionary) -> BuildingInstance:
	var inst_id: StringName = StringName(str(dict.get("instance_id", "")))
	var bld_id: StringName = StringName(str(dict.get("building_id", "")))
	var coord: Vector2i = Vector2i(int(dict.get("coord_x", 0)), int(dict.get("coord_y", 0)))
	var orient: int = int(dict.get("orientation", 0))
	return BuildingInstance.new(inst_id, bld_id, coord, orient)
