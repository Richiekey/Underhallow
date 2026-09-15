class_name InventoryState
extends RefCounted

## Authoritative domain state container for player inventory.
## Data-only, zero rendering dependencies, guarded against negative quantities.
## Emits domain signals on state changes per IA-001 Section 3.2.

signal item_changed(item_id: StringName, new_quantity: int)
signal inventory_cleared()

var _items: Dictionary = {}

func _init() -> void:
	reset()

func reset() -> void:
	_items.clear()
	# Phase 4 starting items (Tier B prototype tuning)
	_items[&"tool_hoe"] = 1
	_items[&"tool_watering_can"] = 1
	_items[&"seed_carrot"] = 5
	inventory_cleared.emit()

func add_item(item_id: StringName, count: int = 1) -> bool:
	if item_id == &"" or count <= 0:
		return false
	
	var current: int = _items.get(item_id, 0)
	var new_qty: int = current + count
	_items[item_id] = new_qty
	item_changed.emit(item_id, new_qty)
	return true

func remove_item(item_id: StringName, count: int = 1) -> bool:
	if item_id == &"" or count <= 0:
		return false
	
	var current: int = _items.get(item_id, 0)
	if current < count:
		return false
	
	var new_qty: int = current - count
	if new_qty <= 0:
		_items.erase(item_id)
		new_qty = 0
	else:
		_items[item_id] = new_qty
	
	item_changed.emit(item_id, new_qty)
	return true

func has_item(item_id: StringName, count: int = 1) -> bool:
	if item_id == &"" or count <= 0:
		return false
	return _items.get(item_id, 0) >= count

func get_quantity(item_id: StringName) -> int:
	return _items.get(item_id, 0)

func get_all_items() -> Dictionary:
	return _items.duplicate()

func to_dictionary() -> Dictionary:
	var serialized: Dictionary = {}
	for key: Variant in _items.keys():
		serialized[str(key)] = _items[key]
	return serialized

func from_dictionary(dict: Dictionary) -> void:
	_items.clear()
	for key: Variant in dict.keys():
		var id: StringName = StringName(str(key))
		var qty: int = maxi(0, int(dict[key]))
		if qty > 0:
			_items[id] = qty
	inventory_cleared.emit()
