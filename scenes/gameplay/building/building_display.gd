class_name BuildingDisplay
extends Node2D

## Presentation manager for placed buildings and structures.
## Strictly reactive representation derived from authoritative BuildingState.
## Zero authoritative state is stored here.

const CELL_SIZE: float = 16.0
const DEFAULT_ORIGIN_OFFSET: Vector2 = Vector2(-130.0, -20.0)

@export var origin_offset: Vector2 = DEFAULT_ORIGIN_OFFSET

var _rendered_instances: Dictionary = {} # instance_id -> Node2D

## Canonical world-to-grid and grid-to-world transform for construction presentation.
## Single source of truth for building coordinate resolution.
static func grid_to_world_position(coord: Vector2i, origin: Vector2 = DEFAULT_ORIGIN_OFFSET) -> Vector2:
	return origin + Vector2(float(coord.x) * CELL_SIZE, float(coord.y) * CELL_SIZE)

static func world_to_grid_coordinate(world_pos: Vector2, origin: Vector2 = DEFAULT_ORIGIN_OFFSET) -> Vector2i:
	var local: Vector2 = world_pos - origin
	return Vector2i(roundi(local.x / CELL_SIZE), roundi(local.y / CELL_SIZE))

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
	node.position = grid_to_world_position(instance.grid_coord, origin_offset)
	node.rotation = float(instance.orientation) * (PI / 2.0)
	
	var width: float = float(instance.footprint.x) * CELL_SIZE
	var height: float = float(instance.footprint.y) * CELL_SIZE
	
	var rect: ColorRect = ColorRect.new()
	rect.custom_minimum_size = Vector2(maxf(14.0, width - 2.0), maxf(14.0, height - 2.0))
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

func get_building_node(instance_id: StringName) -> Node2D:
	return _rendered_instances.get(instance_id, null)

func get_rendered_count() -> int:
	return _rendered_instances.size()
