class_name PlayerController
extends CharacterBody2D

## Primary player controller for Underhallow.
## Responsible for input interpretation, continuous movement, diagonal normalization,
## acceleration/friction, 8-directional facing, interaction triggering, and
## non-authoritative construction preview/placement confirmation per PC-001 & BI-001.
##
## ARCHITECTURAL CONSTRAINTS:
## - No stamina system; no sprint system (Invariant 5 & PC-001).
## - Direct screen-space movement is a Tier B Prototype Default.
## - Click-to-move is deferred beyond V0.1 Phase 2 per PC-001.
## - Does not own inventory, farming, combat, persistence, or world simulation.
## - Construction preview is non-authoritative and never mutates BuildingState directly.

## Tier B Prototype Tuning Values
@export_group("Movement Tuning")
@export var move_speed: float = 150.0
@export var acceleration: float = 1200.0
@export var friction: float = 1600.0

signal equipped_item_changed(new_item_id: StringName)
signal building_preview_started(building_id: StringName, coord: Vector2i)
signal building_preview_cancelled()
signal building_placement_confirmed(instance_id: StringName, building_id: StringName, coord: Vector2i)
signal preview_coord_changed(new_coord: Vector2i)
signal preview_orientation_changed(new_orientation: int)

@onready var interaction_detector: PlayerInteraction = $InteractionDetector
@onready var facing_indicator: Node2D = $Visual/FacingIndicator

var player_state: PlayerState = null
var runtime: GameRuntime = null

var facing_direction: Vector2 = Vector2.DOWN
var facing_cardinal: int = PlayerState.FacingDirection.SOUTH
var input_vector: Vector2 = Vector2.ZERO
var is_moving: bool = false
var equipped_item_id: StringName = &"tool_hoe"

# Non-authoritative building placement preview state
var is_in_building_preview: bool = false
var preview_building_id: StringName = &""
var preview_coord: Vector2i = Vector2i.ZERO
var preview_orientation: int = 0
var _instance_counter: int = 0

func _ready() -> void:
	# If no state was assigned externally by runtime, initialize default
	if player_state == null:
		player_state = PlayerState.new()
	
	# Apply initial state
	global_position = player_state.position
	facing_direction = player_state.facing_direction
	facing_cardinal = player_state.facing_cardinal
	_update_visual_facing()

func _physics_process(delta: float) -> void:
	_process_movement(delta)
	_sync_state()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("cancel"):
		if is_in_building_preview:
			cancel_building_preview()
	elif event.is_action_pressed("interact"):
		if is_in_building_preview:
			confirm_placement()
		elif interaction_detector != null:
			interaction_detector.trigger_interaction(self)
	elif event.is_action_pressed("rotate_building") or (event is InputEventKey and event.pressed and not event.echo and event.keycode == KEY_R):
		if is_in_building_preview:
			rotate_building_preview()
	elif event.is_action_pressed("hotbar_1"):
		set_equipped_item(&"tool_hoe")
	elif event.is_action_pressed("hotbar_2"):
		set_equipped_item(&"tool_watering_can")
	elif event.is_action_pressed("hotbar_3"):
		set_equipped_item(&"seed_carrot")
	elif event.is_action_pressed("hotbar_4"):
		set_equipped_item(&"rustic_fence")
	elif event.is_action_pressed("hotbar_5"):
		set_equipped_item(&"stone_path")

func set_equipped_item(item_id: StringName) -> void:
	if equipped_item_id != item_id:
		equipped_item_id = item_id
		equipped_item_changed.emit(equipped_item_id)
		
		# If a buildable structure is equipped, enter non-authoritative preview
		var bld_def: BuildingDefinition = BuildingDatabase.get_definition(item_id)
		if bld_def != null:
			start_building_preview(item_id, preview_coord)
		elif is_in_building_preview:
			cancel_building_preview()

const BuildingDisplayClass = preload("res://scenes/gameplay/building/building_display.gd")

## Selects and equips a buildable structure, activating non-authoritative preview.
func select_building(building_id: StringName) -> bool:
	set_equipped_item(building_id)
	return is_in_building_preview and preview_building_id == building_id

## Starts non-authoritative building preview. Does not mutate BuildingState or InventoryState.
func start_building_preview(building_id: StringName, initial_coord: Vector2i = Vector2i.ZERO) -> bool:
	if building_id == &"":
		return false
	
	var def: BuildingDefinition = BuildingDatabase.get_definition(building_id)
	if def == null:
		return false
	
	is_in_building_preview = true
	preview_building_id = building_id
	preview_orientation = 0
	
	if initial_coord == Vector2i.ZERO and facing_direction != Vector2.ZERO:
		var target_pos: Vector2 = global_position + facing_direction.normalized() * 24.0
		preview_coord = BuildingDisplayClass.world_to_grid_coordinate(target_pos)
	else:
		preview_coord = initial_coord
	
	building_preview_started.emit(building_id, preview_coord)
	return true

func set_preview_coord(coord: Vector2i) -> void:
	if preview_coord != coord:
		preview_coord = coord
		preview_coord_changed.emit(preview_coord)

func rotate_building_preview() -> void:
	preview_orientation = (preview_orientation + 1) % 4
	preview_orientation_changed.emit(preview_orientation)

func cancel_building_preview() -> void:
	if is_in_building_preview:
		is_in_building_preview = false
		preview_building_id = &""
		building_preview_cancelled.emit()

## Updates the non-authoritative preview target coordinate to match player facing and position.
func update_preview_target_from_facing() -> void:
	if not is_in_building_preview:
		return
	var target_pos: Vector2 = global_position + facing_direction.normalized() * 24.0
	var coord: Vector2i = BuildingDisplayClass.world_to_grid_coordinate(target_pos)
	set_preview_coord(coord)

## Queries whether the current preview placement would pass PlaceBuildingCommand validation.
## Strictly non-authoritative query for presentation feedback only.
func is_preview_valid() -> bool:
	if not is_in_building_preview or preview_building_id == &"":
		return false
	if runtime == null:
		_find_runtime()
	if runtime == null or runtime.game_state == null:
		return false
	
	var check_cmd: PlaceBuildingCommand = PlaceBuildingCommand.new(
		&"__preview_check__",
		preview_building_id,
		preview_coord,
		preview_orientation
	)
	var result: CommandResult = check_cmd.validate(runtime.game_state)
	return result.success

## Confirms placement by dispatching PlaceBuildingCommand through GameRuntime.
## Validation, mutation, material deduction, and BuildingState updates are strictly authoritative.
func confirm_placement(custom_instance_id: StringName = &"") -> CommandResult:
	if not is_in_building_preview or preview_building_id == &"":
		return CommandResult.fail("Not currently in building preview mode.")
	
	if runtime == null:
		_find_runtime()
	if runtime == null:
		return CommandResult.fail("GameRuntime unavailable for placement confirmation.")
	
	var inst_id: StringName = custom_instance_id
	if inst_id == &"":
		_instance_counter += 1
		inst_id = StringName("%s_%d" % [preview_building_id, _instance_counter])
	
	var cmd: PlaceBuildingCommand = PlaceBuildingCommand.new(inst_id, preview_building_id, preview_coord, preview_orientation)
	var result: CommandResult = runtime.execute_command(cmd)
	if result.success:
		building_placement_confirmed.emit(inst_id, preview_building_id, preview_coord)
		cancel_building_preview()
	
	return result

func _find_runtime() -> void:
	if runtime == null and is_inside_tree():
		var root: Node = get_tree().root
		var game_node: Node = root.get_node_or_null("Game")
		if game_node != null:
			runtime = game_node.get_node_or_null("Systems/Runtime") as GameRuntime

## Computes normalized input vector from logical actions.
## Screen-space mapping (Tier B Prototype Default):
## W = (0, -1), S = (0, 1), A = (-1, 0), D = (1, 0).
func get_movement_input() -> Vector2:
	var x: float = Input.get_axis("move_left", "move_right")
	var y: float = Input.get_axis("move_up", "move_down")
	var raw_input: Vector2 = Vector2(x, y)
	
	# Diagonal normalization prevents moving faster diagonally
	if raw_input.length_squared() > 1.0:
		return raw_input.normalized()
	return raw_input

## Core physics movement execution.
func _process_movement(delta: float) -> void:
	input_vector = get_movement_input()
	
	if input_vector != Vector2.ZERO:
		# Accelerate towards target velocity
		var target_velocity: Vector2 = input_vector * move_speed
		velocity = velocity.move_toward(target_velocity, acceleration * delta)
		
		# Update 8-directional facing while moving
		facing_direction = input_vector.normalized()
		facing_cardinal = PlayerState.vector_to_facing_direction(facing_direction)
		is_moving = true
		
		if interaction_detector != null:
			interaction_detector.update_facing(facing_direction)
		_update_visual_facing()
		if is_in_building_preview:
			update_preview_target_from_facing()
	else:
		# Apply friction when no input is received; retain last facing direction
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
		is_moving = velocity.length_squared() > 1.0
	
	if is_inside_tree() and get_world_2d() != null and get_world_2d().space.is_valid():
		move_and_slide()

func _update_visual_facing() -> void:
	if facing_indicator != null and facing_direction != Vector2.ZERO:
		# Position the directional nose/marker in front of the character
		facing_indicator.position = facing_direction.normalized() * 10.0

## Synchronizes domain state with the single authoritative source of truth.
func _sync_state() -> void:
	if player_state != null:
		player_state.position = global_position
		player_state.facing_direction = facing_direction
		player_state.facing_cardinal = facing_cardinal
		player_state.is_moving = is_moving
		player_state.move_speed = move_speed
