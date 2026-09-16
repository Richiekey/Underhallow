class_name HuntingState
extends RefCounted

## Authoritative domain state container for Hunting & Combat (HU-001).
## Strictly data-only. Zero rendering dependencies, zero scene-tree nodes.

signal creature_registered(creature: CreatureState)
signal creature_updated(creature: CreatureState)
signal hunting_cleared()

# Dictionary mapping StringName (instance_id) -> CreatureState
var _creatures: Dictionary = {}

func _init() -> void:
	reset()

func reset() -> void:
	_creatures.clear()
	hunting_cleared.emit()

func register_creature(instance_id: StringName, definition_id: StringName, pos: Vector2 = Vector2.ZERO) -> CreatureState:
	if instance_id == &"" or definition_id == &"":
		return null
	
	var def: CreatureDefinition = CreatureDatabase.get_definition(definition_id)
	var max_hp: int = def.max_health if def != null else 10
	var creature: CreatureState = CreatureState.new(
		instance_id,
		definition_id,
		max_hp,
		max_hp,
		false, # is_discovered
		false, # is_defeated
		false, # is_harvested
		pos
	)
	_creatures[instance_id] = creature
	creature_registered.emit(creature)
	return creature

func has_creature(instance_id: StringName) -> bool:
	return _creatures.has(instance_id)

func get_creature(instance_id: StringName) -> CreatureState:
	return _creatures.get(instance_id, null)

func get_all_creatures() -> Dictionary:
	return _creatures.duplicate()

func to_dictionary() -> Dictionary:
	var serialized: Dictionary = {}
	for inst_id: Variant in _creatures.keys():
		var c: CreatureState = _creatures[inst_id] as CreatureState
		if c != null:
			serialized[str(inst_id)] = c.to_dictionary()
	return serialized

func from_dictionary(dict: Dictionary) -> void:
	_creatures.clear()
	for key_str: Variant in dict.keys():
		var c_dict: Dictionary = dict[key_str] as Dictionary
		if c_dict != null:
			var creature: CreatureState = CreatureState.from_dictionary(c_dict)
			_creatures[creature.instance_id] = creature
	hunting_cleared.emit()
