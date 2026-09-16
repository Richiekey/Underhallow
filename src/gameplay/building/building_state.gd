class_name BuildingState
extends RefCounted

## Authoritative domain state container for Building & Construction (BI-001).
## Strictly data-only. Zero rendering dependencies, zero scene-tree nodes.

signal building_placed(instance: BuildingInstance)
signal building_state_cleared()

# Dictionary mapping StringName (instance_id) -> BuildingInstance
var _instances: Dictionary = {}
# Dictionary mapping Vector2i (grid_coord) -> StringName (instance_id)
var _occupied_coords: Dictionary = {}

func _init() -> void:
	reset()

func reset() -> void:
	_instances.clear()
	_occupied_coords.clear()
	building_state_cleared.emit()

func place_building(
	instance_id: StringName,
	building_id: StringName,
	coord: Vector2i,
	orientation: int = 0,
	custom_footprint: Vector2i = Vector2i.ZERO
) -> BuildingInstance:
	if instance_id == &"" or building_id == &"":
		return null
	
	var fp: Vector2i = custom_footprint
	if fp == Vector2i.ZERO:
		var def: BuildingDefinition = BuildingDatabase.get_definition(building_id)
		fp = def.footprint if def != null else Vector2i(1, 1)
	fp = Vector2i(maxi(1, fp.x), maxi(1, fp.y))
	
	var instance: BuildingInstance = BuildingInstance.new(instance_id, building_id, coord, orientation, fp)
	_instances[instance_id] = instance
	
	for cell: Vector2i in instance.get_occupied_cells():
		_occupied_coords[cell] = instance_id
	
	building_placed.emit(instance)
	return instance

func has_instance(instance_id: StringName) -> bool:
	return _instances.has(instance_id)

func get_instance(instance_id: StringName) -> BuildingInstance:
	return _instances.get(instance_id, null)

func has_building_at(coord: Vector2i) -> bool:
	return _occupied_coords.has(coord)

func get_building_at(coord: Vector2i) -> BuildingInstance:
	var inst_id: Variant = _occupied_coords.get(coord, null)
	if inst_id != null:
		return _instances.get(inst_id, null)
	return null

func get_occupied_cells() -> Array[Vector2i]:
	var cells: Array[Vector2i] = []
	for c: Variant in _occupied_coords.keys():
		cells.append(c as Vector2i)
	return cells

func get_all_buildings() -> Dictionary:
	return _instances.duplicate()

func to_dictionary() -> Dictionary:
	var serialized: Dictionary = {}
	for inst_id: Variant in _instances.keys():
		var inst: BuildingInstance = _instances[inst_id] as BuildingInstance
		if inst != null:
			serialized[str(inst_id)] = inst.to_dictionary()
	return serialized

func from_dictionary(dict: Dictionary) -> void:
	_instances.clear()
	_occupied_coords.clear()
	for key_str: Variant in dict.keys():
		var b_dict: Dictionary = dict[key_str] as Dictionary
		if b_dict != null:
			var inst: BuildingInstance = BuildingInstance.from_dictionary(b_dict)
			_instances[inst.instance_id] = inst
			for cell: Vector2i in inst.get_occupied_cells():
				_occupied_coords[cell] = inst.instance_id
	building_state_cleared.emit()
