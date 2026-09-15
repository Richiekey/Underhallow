class_name PlayerState
extends RefCounted

## Player domain state container.
## Strictly data-only. Zero rendering dependencies, zero scene-tree nodes.
## Subordinated directly under GameState to maintain single authoritative truth.

enum FacingDirection {
	NORTH,
	NORTHEAST,
	EAST,
	SOUTHEAST,
	SOUTH,
	SOUTHWEST,
	WEST,
	NORTHWEST
}

## Tier B Prototype Default: baseline movement speed in pixels per second.
const DEFAULT_MOVE_SPEED: float = 150.0

var position: Vector2 = Vector2.ZERO
var facing_direction: Vector2 = Vector2.DOWN
var facing_cardinal: int = FacingDirection.SOUTH
var is_moving: bool = false
var move_speed: float = DEFAULT_MOVE_SPEED

func _init() -> void:
	reset()

func reset() -> void:
	position = Vector2.ZERO
	facing_direction = Vector2.DOWN
	facing_cardinal = FacingDirection.SOUTH
	is_moving = false
	move_speed = DEFAULT_MOVE_SPEED

## Resolves an 8-directional facing enum from a 2D directional vector.
## If vector is roughly zero, retains previous facing.
static func vector_to_facing_direction(dir: Vector2) -> int:
	if dir.length_squared() < 0.001:
		return FacingDirection.SOUTH
	
	var angle: float = dir.angle() # Range -PI to PI, 0 is (1, 0) Right/East
	# Convert angle so 0 is NORTH (up / -Y) or calculate sector directly:
	# Godot 2D coordinates: Right = (1, 0) angle 0. Down = (0, 1) angle PI/2.
	# Left = (-1, 0) angle PI / -PI. Up = (0, -1) angle -PI/2.
	# 8 sectors of 45 degrees (PI/4 = ~0.3927 rad half-sector).
	var deg: float = rad_to_deg(angle) # -180 to 180
	if deg >= -22.5 and deg < 22.5:
		return FacingDirection.EAST
	elif deg >= 22.5 and deg < 67.5:
		return FacingDirection.SOUTHEAST
	elif deg >= 67.5 and deg < 112.5:
		return FacingDirection.SOUTH
	elif deg >= 112.5 and deg < 157.5:
		return FacingDirection.SOUTHWEST
	elif deg >= 157.5 or deg < -157.5:
		return FacingDirection.WEST
	elif deg >= -157.5 and deg < -112.5:
		return FacingDirection.NORTHWEST
	elif deg >= -112.5 and deg < -67.5:
		return FacingDirection.NORTH
	else: # deg >= -67.5 and deg < -22.5
		return FacingDirection.NORTHEAST

static func facing_direction_to_vector(dir: int) -> Vector2:
	match dir:
		FacingDirection.NORTH:
			return Vector2.UP
		FacingDirection.NORTHEAST:
			return Vector2(1, -1).normalized()
		FacingDirection.EAST:
			return Vector2.RIGHT
		FacingDirection.SOUTHEAST:
			return Vector2(1, 1).normalized()
		FacingDirection.SOUTH:
			return Vector2.DOWN
		FacingDirection.SOUTHWEST:
			return Vector2(-1, 1).normalized()
		FacingDirection.WEST:
			return Vector2.LEFT
		FacingDirection.NORTHWEST:
			return Vector2(-1, -1).normalized()
		_:
			return Vector2.DOWN

func to_dictionary() -> Dictionary:
	return {
		"position_x": position.x,
		"position_y": position.y,
		"facing_x": facing_direction.x,
		"facing_y": facing_direction.y,
		"facing_cardinal": facing_cardinal,
		"is_moving": is_moving,
		"move_speed": move_speed
	}

func from_dictionary(dict: Dictionary) -> void:
	position = Vector2(
		float(dict.get("position_x", 0.0)),
		float(dict.get("position_y", 0.0))
	)
	facing_direction = Vector2(
		float(dict.get("facing_x", 0.0)),
		float(dict.get("facing_y", 1.0))
	)
	facing_cardinal = int(dict.get("facing_cardinal", FacingDirection.SOUTH))
	is_moving = bool(dict.get("is_moving", false))
	move_speed = float(dict.get("move_speed", DEFAULT_MOVE_SPEED))
