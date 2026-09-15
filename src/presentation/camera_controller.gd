class_name CameraController
extends Camera2D

## Dedicated camera controller for Underhallow.
## Responsible for smooth target tracking, zoom clamping, and world boundary limits.
##
## ARCHITECTURAL CONSTRAINTS:
## - Fixed isometric orientation: strictly NO camera rotation in V1 (SR-001 & IA-001 Section 14).
## - Dedicated presentation controller separate from the player scene.
## - All smoothing and zoom parameters are Tier B Prototype Tuning Values.

@export_group("Target Tracking")
@export var target: Node2D = null
@export var follow_smoothing_speed: float = 8.0

@export_group("Zoom Tuning")
@export var default_zoom_level: float = 2.0
@export var min_zoom_level: float = 1.0
@export var max_zoom_level: float = 3.0
@export var zoom_step: float = 0.25
@export var zoom_smoothing_speed: float = 10.0

var target_zoom_level: float = default_zoom_level

func _ready() -> void:
	target_zoom_level = default_zoom_level
	zoom = Vector2(target_zoom_level, target_zoom_level)
	
	# Snap directly to target initially if assigned
	if target != null:
		global_position = target.global_position

func _process(delta: float) -> void:
	_update_target_tracking(delta)
	_update_zoom_smoothing(delta)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("zoom_in"):
		target_zoom_level = clampf(target_zoom_level + zoom_step, min_zoom_level, max_zoom_level)
	elif event.is_action_pressed("zoom_out"):
		target_zoom_level = clampf(target_zoom_level - zoom_step, min_zoom_level, max_zoom_level)

func _update_target_tracking(delta: float) -> void:
	if target == null:
		return
	
	# Exponential smoothing lerp decoupled from frame rate
	var target_pos: Vector2 = target.global_position
	var t: float = 1.0 - exp(-follow_smoothing_speed * delta)
	global_position = global_position.lerp(target_pos, t)

func _update_zoom_smoothing(delta: float) -> void:
	var target_vec: Vector2 = Vector2(target_zoom_level, target_zoom_level)
	var t: float = 1.0 - exp(-zoom_smoothing_speed * delta)
	zoom = zoom.lerp(target_vec, t)

## Public API to dynamically assign camera follow target
func set_target(new_target: Node2D) -> void:
	target = new_target
	if target != null:
		global_position = target.global_position
