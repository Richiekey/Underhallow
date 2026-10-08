class_name PlayerAnimationPresentation
extends Node

## Drives AnimatedSprite2D animation state based on PlayerController movement.
## Strictly a presentation consumer — does not modify movement, input, or domain state.
##
## Maps PlayerState.FacingDirection (8-dir) to visual animation directions (4-dir):
##   SOUTH, NORTH, EAST (+ flip for WEST)
##   Diagonals map to their primary cardinal (SE/SW → SOUTH, NE/NW → NORTH, etc.)

@onready var sprite: AnimatedSprite2D = $"../AnimatedSprite"

var _controller: PlayerController = null
var _last_facing: int = PlayerState.FacingDirection.SOUTH
var _last_moving: bool = false

func _ready() -> void:
	_controller = get_parent().get_parent() as PlayerController
	if _controller == null:
		printerr("PlayerAnimationPresentation: Grandparent is not a PlayerController.")
		return
	
	if sprite == null:
		printerr("PlayerAnimationPresentation: AnimatedSprite not found at ../AnimatedSprite.")
		return
	
	_update_animation(false, PlayerState.FacingDirection.SOUTH)

func _process(_delta: float) -> void:
	if _controller == null or sprite == null:
		return
	
	var is_moving: bool = _controller.is_moving
	var facing: int = _controller.facing_cardinal
	
	# Only update animation when state actually changes
	if is_moving != _last_moving or facing != _last_facing:
		_last_moving = is_moving
		_last_facing = facing
		_update_animation(is_moving, facing)

func _update_animation(is_moving: bool, facing: int) -> void:
	var direction_name: String = _facing_to_direction_name(facing)
	var flip_h: bool = _should_flip(facing)
	
	sprite.flip_h = flip_h
	
	var anim_name: String
	if is_moving:
		anim_name = "walk_" + direction_name
	else:
		anim_name = "idle_" + direction_name
	
	if sprite.sprite_frames != null and sprite.sprite_frames.has_animation(anim_name):
		if sprite.animation != anim_name:
			sprite.play(anim_name)
	else:
		# Fallback: try south if direction-specific animation doesn't exist
		var fallback: String = "walk_south" if is_moving else "idle_south"
		if sprite.animation != fallback:
			sprite.play(fallback)

## Maps 8-directional facing to one of 4 visual directions (south, north, east).
## West directions use east animations with flip_h = true.
static func _facing_to_direction_name(facing: int) -> String:
	match facing:
		PlayerState.FacingDirection.SOUTH, \
		PlayerState.FacingDirection.SOUTHEAST, \
		PlayerState.FacingDirection.SOUTHWEST:
			return "south"
		PlayerState.FacingDirection.NORTH, \
		PlayerState.FacingDirection.NORTHEAST, \
		PlayerState.FacingDirection.NORTHWEST:
			return "north"
		PlayerState.FacingDirection.EAST:
			return "east"
		PlayerState.FacingDirection.WEST:
			return "east"  # Flipped horizontally
		_:
			return "south"

## Returns true if the facing direction requires horizontal sprite flip.
static func _should_flip(facing: int) -> bool:
	match facing:
		PlayerState.FacingDirection.WEST, \
		PlayerState.FacingDirection.SOUTHWEST, \
		PlayerState.FacingDirection.NORTHWEST:
			return true
		_:
			return false
