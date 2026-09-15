class_name PlayerController
extends CharacterBody2D

## Primary player controller for Underhallow.
## Responsible for input interpretation, continuous movement, diagonal normalization,
## acceleration/friction, 8-directional facing, and interaction triggering.
##
## ARCHITECTURAL CONSTRAINTS:
## - No stamina system; no sprint system (Invariant 5 & PC-001).
## - Direct screen-space movement is a Tier B Prototype Default.
## - Click-to-move is deferred beyond V0.1 Phase 2 per PC-001.
## - Does not own inventory, farming, combat, persistence, or world simulation.

## Tier B Prototype Tuning Values
@export_group("Movement Tuning")
@export var move_speed: float = 150.0
@export var acceleration: float = 1200.0
@export var friction: float = 1600.0

signal equipped_item_changed(new_item_id: StringName)

@onready var interaction_detector: PlayerInteraction = $InteractionDetector
@onready var facing_indicator: Node2D = $Visual/FacingIndicator

var player_state: PlayerState = null
var facing_direction: Vector2 = Vector2.DOWN
var facing_cardinal: int = PlayerState.FacingDirection.SOUTH
var input_vector: Vector2 = Vector2.ZERO
var is_moving: bool = false
var equipped_item_id: StringName = &"tool_hoe"

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
	if event.is_action_pressed("interact"):
		if interaction_detector != null:
			interaction_detector.trigger_interaction(self)
	elif event.is_action_pressed("hotbar_1"):
		set_equipped_item(&"tool_hoe")
	elif event.is_action_pressed("hotbar_2"):
		set_equipped_item(&"tool_watering_can")
	elif event.is_action_pressed("hotbar_3"):
		set_equipped_item(&"seed_carrot")

func set_equipped_item(item_id: StringName) -> void:
	if equipped_item_id != item_id:
		equipped_item_id = item_id
		equipped_item_changed.emit(equipped_item_id)

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
