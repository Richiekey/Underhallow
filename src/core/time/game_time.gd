class_name GameTime
extends RefCounted

## Deterministic simulation clock for Underhallow.
## Decoupled from real-world wall clock and rendering frame delta accumulation.

signal time_advanced(elapsed_seconds: float, delta_applied: float)
signal pause_state_changed(is_paused: bool)
signal time_scale_changed(new_scale: float)

var elapsed_seconds: float = 0.0
var time_scale: float = 1.0
var is_paused: bool = false
var total_ticks: int = 0

func _init(initial_time: float = 0.0, initial_scale: float = 1.0) -> void:
	elapsed_seconds = maxf(0.0, initial_time)
	time_scale = maxf(0.0, initial_scale)
	is_paused = false
	total_ticks = 0

## Advances simulation time deterministically by delta_seconds scaled by time_scale.
## Does not advance if paused or if delta_seconds <= 0.
func advance(delta_seconds: float) -> void:
	if is_paused or delta_seconds <= 0.0:
		return
	
	var applied_delta: float = delta_seconds * time_scale
	elapsed_seconds += applied_delta
	total_ticks += 1
	time_advanced.emit(elapsed_seconds, applied_delta)

func pause() -> void:
	if not is_paused:
		is_paused = true
		pause_state_changed.emit(true)

func resume() -> void:
	if is_paused:
		is_paused = false
		pause_state_changed.emit(false)

func set_time_scale(scale: float) -> void:
	var clamped_scale: float = maxf(0.0, scale)
	if not is_equal_approx(time_scale, clamped_scale):
		time_scale = clamped_scale
		time_scale_changed.emit(time_scale)

func reset(time: float = 0.0) -> void:
	elapsed_seconds = maxf(0.0, time)
	time_scale = 1.0
	is_paused = false
	total_ticks = 0
