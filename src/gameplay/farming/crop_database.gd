class_name CropDatabase
extends RefCounted

## Resource loader and query provider for CropDefinition assets.
## Loads Godot Resources from res://data/crops/ per Invariant 8.

const CROPS_PATH: String = "res://data/crops/"

static var _crops: Dictionary = {}
static var _crops_by_seed: Dictionary = {}
static var _initialized: bool = false

static func initialize() -> void:
	if _initialized:
		return
	_crops.clear()
	_crops_by_seed.clear()
	
	var known_crops: Array[String] = [
		"crop_carrot"
	]
	
	for crop_name: String in known_crops:
		var path: String = CROPS_PATH + crop_name + ".tres"
		if ResourceLoader.exists(path):
			var crop_res: CropDefinition = load(path) as CropDefinition
			if crop_res != null:
				_crops[crop_res.id] = crop_res
				if crop_res.seed_item_id != &"":
					_crops_by_seed[crop_res.seed_item_id] = crop_res
	
	_initialized = true

static func get_definition(crop_id: StringName) -> CropDefinition:
	if not _initialized:
		initialize()
	return _crops.get(crop_id, null)

static func get_by_seed(seed_id: StringName) -> CropDefinition:
	if not _initialized:
		initialize()
	return _crops_by_seed.get(seed_id, null)

static func get_all_definitions() -> Dictionary:
	if not _initialized:
		initialize()
	return _crops

static func clear() -> void:
	_crops.clear()
	_crops_by_seed.clear()
	_initialized = false
