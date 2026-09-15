class_name InputProvider
extends RefCounted

## Thin logical access boundary over Godot's Input Map.
## Prevents hardcoded physical keys from permeating gameplay code.
## Does NOT implement movement or rebinding UI.

const ACTION_MOVE_UP: StringName = &"move_up"
const ACTION_MOVE_DOWN: StringName = &"move_down"
const ACTION_MOVE_LEFT: StringName = &"move_left"
const ACTION_MOVE_RIGHT: StringName = &"move_right"
const ACTION_INTERACT: StringName = &"interact"
const ACTION_CANCEL: StringName = &"cancel"

func is_action_pressed(action: StringName) -> bool:
	return Input.is_action_pressed(action)

func is_action_just_pressed(action: StringName) -> bool:
	return Input.is_action_just_pressed(action)

func get_movement_vector() -> Vector2:
	return Input.get_vector(ACTION_MOVE_LEFT, ACTION_MOVE_RIGHT, ACTION_MOVE_UP, ACTION_MOVE_DOWN)
