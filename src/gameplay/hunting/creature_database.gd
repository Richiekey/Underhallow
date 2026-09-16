class_name CreatureDatabase
extends RefCounted

## Resource loader and query provider for CreatureDefinition assets.
## Loads Godot Resources from res://data/creatures/ per HU-001 & Invariant 8.

const CREATURES_PATH: String = "res://data/creatures/"

static var _creatures: Dictionary = {}
static var _initialized: bool = false

static func initialize() -> void:
	if _initialized:
		return
	_creatures.clear()
	
	var known_creatures: Array[String] = [
		"hare"
	]
	
	for creature_name: String in known_creatures:
		var path: String = CREATURES_PATH + creature_name + ".tres"
		if ResourceLoader.exists(path):
			var res: CreatureDefinition = load(path) as CreatureDefinition
			if res != null:
				_creatures[res.id] = res
	
	# Programmatic fallback ensures headless/isolated test reliability
	if not _creatures.has(&"hare"):
		var hare_def: CreatureDefinition = CreatureDefinition.new()
		hare_def.id = &"hare"
		hare_def.display_name = "Forest Hare"
		hare_def.max_health = 10
		hare_def.harvest_item_id = &"resource_raw_hide"
		hare_def.harvest_item_count = 1
		hare_def.description = "A nimble woodland hare with soft grey-brown fur."
		_creatures[&"hare"] = hare_def
	
	_initialized = true

static func get_definition(creature_id: StringName) -> CreatureDefinition:
	if not _initialized:
		initialize()
	return _creatures.get(creature_id, null)

static func get_all_definitions() -> Dictionary:
	if not _initialized:
		initialize()
	return _creatures.duplicate()

static func register_definition(definition: CreatureDefinition) -> void:
	if definition != null and definition.id != &"":
		_creatures[definition.id] = definition

static func clear() -> void:
	_creatures.clear()
	_initialized = false
