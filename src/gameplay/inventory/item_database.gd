class_name ItemDatabase
extends RefCounted

## Resource loader and query provider for ItemDefinition assets.
## Loads Godot Resources from res://data/items/ per Invariant 8.

const ITEMS_PATH: String = "res://data/items/"

static var _items: Dictionary = {}
static var _initialized: bool = false

static func initialize() -> void:
	if _initialized:
		return
	_items.clear()
	
	# Load standard Phase 4 item definition resources
	var known_items: Array[String] = [
		"tool_hoe",
		"tool_watering_can",
		"seed_carrot",
		"crop_carrot",
		"resource_wild_berries",
		"resource_raw_hide",
		"resource_meat",
		"resource_wood",
		"resource_stone"
	]
	
	for item_name: String in known_items:
		var path: String = ITEMS_PATH + item_name + ".tres"
		if ResourceLoader.exists(path):
			var item_res: ItemDefinition = load(path) as ItemDefinition
			if item_res != null:
				_items[item_res.id] = item_res
	
	_initialized = true

static func get_definition(item_id: StringName) -> ItemDefinition:
	if not _initialized:
		initialize()
	return _items.get(item_id, null)

static func get_all_definitions() -> Dictionary:
	if not _initialized:
		initialize()
	return _items

static func clear() -> void:
	_items.clear()
	_initialized = false
