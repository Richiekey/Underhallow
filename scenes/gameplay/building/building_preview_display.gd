class_name BuildingPreviewDisplay
extends Node2D

## Presentation component for non-authoritative construction preview per PC-001 & BI-001.
## Strictly visual feedback for proposed building placement.
## Reads state from PlayerController and validates against GameState via PlaceBuildingCommand.validate().
## Consumes canonical coordinate transform from BuildingDisplay.
## Never mutates BuildingState or InventoryState.

const BuildingDisplayClass = preload("res://scenes/gameplay/building/building_display.gd")

@export var origin_offset: Vector2 = BuildingDisplayClass.DEFAULT_ORIGIN_OFFSET

var player: PlayerController = null
var runtime: GameRuntime = null

var _preview_rect: ColorRect = null
var _border_rect: ReferenceRect = null

func _ready() -> void:
	z_index = 5 # Display above floor tiles and placed structures
	visible = false
	_create_visuals()

func _create_visuals() -> void:
	if _preview_rect == null:
		_preview_rect = ColorRect.new()
		_preview_rect.name = "PreviewFill"
		add_child(_preview_rect)
	
	if _border_rect == null:
		_border_rect = ReferenceRect.new()
		_border_rect.name = "PreviewBorder"
		_border_rect.editor_only = false
		_border_rect.border_width = 1.5
		add_child(_border_rect)

func bind_player(p_player: PlayerController, p_runtime: GameRuntime = null) -> void:
	if player != null:
		if player.building_preview_started.is_connected(_on_preview_started):
			player.building_preview_started.disconnect(_on_preview_started)
		if player.building_preview_cancelled.is_connected(_on_preview_cancelled):
			player.building_preview_cancelled.disconnect(_on_preview_cancelled)
		if player.building_placement_confirmed.is_connected(_on_placement_confirmed):
			player.building_placement_confirmed.disconnect(_on_placement_confirmed)
		if player.preview_coord_changed.is_connected(_on_preview_coord_changed):
			player.preview_coord_changed.disconnect(_on_preview_coord_changed)
		if player.preview_orientation_changed.is_connected(_on_preview_orientation_changed):
			player.preview_orientation_changed.disconnect(_on_preview_orientation_changed)
	
	player = p_player
	runtime = p_runtime
	
	if player != null:
		player.building_preview_started.connect(_on_preview_started)
		player.building_preview_cancelled.connect(_on_preview_cancelled)
		player.building_placement_confirmed.connect(_on_placement_confirmed)
		player.preview_coord_changed.connect(_on_preview_coord_changed)
		player.preview_orientation_changed.connect(_on_preview_orientation_changed)
		
		if player.is_in_building_preview:
			_on_preview_started(player.preview_building_id, player.preview_coord)
		else:
			visible = false

func _on_preview_started(_building_id: StringName, _coord: Vector2i) -> void:
	visible = true
	update_preview()

func _on_preview_cancelled() -> void:
	visible = false

func _on_placement_confirmed(_inst_id: StringName, _building_id: StringName, _coord: Vector2i) -> void:
	visible = false

func _on_preview_coord_changed(_new_coord: Vector2i) -> void:
	update_preview()

func _on_preview_orientation_changed(_new_orientation: int) -> void:
	update_preview()

func update_preview() -> void:
	if player == null or not player.is_in_building_preview:
		visible = false
		return
	
	visible = true
	var def: BuildingDefinition = BuildingDatabase.get_definition(player.preview_building_id)
	if def == null:
		visible = false
		return
	
	var coord: Vector2i = player.preview_coord
	var orientation: int = player.preview_orientation
	var footprint: Vector2i = def.footprint
	
	# Compute world position consuming canonical BuildingDisplay transform
	position = BuildingDisplayClass.grid_to_world_position(coord, origin_offset)
	rotation = float(orientation) * (PI / 2.0)
	
	var width: float = float(footprint.x) * BuildingDisplayClass.CELL_SIZE
	var height: float = float(footprint.y) * BuildingDisplayClass.CELL_SIZE
	var draw_size: Vector2 = Vector2(maxf(14.0, width - 2.0), maxf(14.0, height - 2.0))
	var draw_pos: Vector2 = Vector2(-7.0, -7.0)
	
	if _preview_rect != null:
		_preview_rect.custom_minimum_size = draw_size
		_preview_rect.size = draw_size
		_preview_rect.position = draw_pos
	
	if _border_rect != null:
		_border_rect.custom_minimum_size = draw_size
		_border_rect.size = draw_size
		_border_rect.position = draw_pos
	
	# Preview validity presentation: Green/Valid vs Red/Blocked
	var is_valid: bool = player.is_preview_valid()
	if is_valid:
		if _preview_rect != null:
			_preview_rect.color = Color(0.2, 0.85, 0.4, 0.45)
		if _border_rect != null:
			_border_rect.border_color = Color(0.3, 1.0, 0.5, 0.9)
	else:
		if _preview_rect != null:
			_preview_rect.color = Color(0.9, 0.25, 0.2, 0.45)
		if _border_rect != null:
			_border_rect.border_color = Color(1.0, 0.3, 0.25, 0.9)

func is_preview_visible() -> bool:
	return visible
