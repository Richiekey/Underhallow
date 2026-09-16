class_name BuildingDisplay
extends Node2D

## Presentation manager for placed buildings and structures.
## Strictly reactive representation derived from authoritative BuildingState.
## Zero authoritative state is stored here.

const CELL_SIZE: float = 16.0

@export var origin_offset: Vector2 = Vector2(-130.0, -20.0)

var _rendered_instances: Dictionary = {} # instance_id -> Node2D

func initialize_from_state(building_state: BuildingState) -> void:
	clear_display()
	if building_state == null:
		return
	
	if not building_state.building_placed.is_connected(_on_building_placed):
		building_state.building_placed.connect(_on_building_placed)
	if not building_state.building_state_cleared.is_connected(_on_building_state_cleared):
		building_state.building_state_cleared.connect(_on_building_state_cleared)
	
	var all_blds: Dictionary = building_state.get_all_buildings()
	for inst_id: Variant in all_blds.keys():
		var inst: BuildingInstance = all_blds[inst_id] as BuildingInstance
		if inst != null:
			_render_building_instance(inst)

func clear_display() -> void:
	for node: Node in get_children():
		node.queue_free()
	_rendered_instances.clear()

func _on_building_placed(instance: BuildingInstance) -> void:
	_render_building_instance(instance)

func _on_building_state_cleared() -> void:
	clear_display()

func _render_building_instance(instance: BuildingInstance) -> void:
	if instance == null or _rendered_instances.has(instance.instance_id):
		return
	
	var node: Node2D = Node2D.new()
	node.name = "Building_%s" % str(instance.instance_id)
	node.position = origin_offset + Vector2(float(instance.grid_coord.x) * CELL_SIZE, float(instance.grid_coord.y) * CELL_SIZE)
	node.rotation = float(instance.orientation) * (PI / 2.0)
	
	var rect: ColorRect = ColorRect.new()
	rect.custom_minimum_size = Vector2(14, 14)
	rect.position = Vector2(-7, -7)
	
	if instance.building_id == &"rustic_fence":
		rect.color = Color(0.55, 0.38, 0.22, 1.0) # Wood brown
	elif instance.building_id == &"stone_path":
		rect.color = Color(0.65, 0.65, 0.68, 1.0) # Slate grey
	else:
		rect.color = Color(0.7, 0.6, 0.4, 1.0) # Generic structure
	
	node.add_child(rect)
	add_child(node)
	_rendered_instances[instance.instance_id] = node

func get_rendered_count() -> int:
	return _rendered_instances.size()
