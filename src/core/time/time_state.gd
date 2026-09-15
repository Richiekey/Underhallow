class_name TimeState
extends RefCounted

## Authoritative calendar and simulation time state container.
## Tracks day counter and elapsed simulation time per IA-001 & PH4-001.
## Pure data container. Simulation execution is handled externally by GameTime and Commands.

signal day_changed(new_day: int)
signal time_advanced(elapsed_seconds: float)

## Tier B Prototype Tuning Default: 240 seconds per day cycle
const DEFAULT_DAY_DURATION: float = 240.0

var elapsed_seconds: float = 0.0
var current_day: int = 1
var day_duration: float = DEFAULT_DAY_DURATION

func _init(p_elapsed: float = 0.0, p_day: int = 1, p_duration: float = DEFAULT_DAY_DURATION) -> void:
	elapsed_seconds = maxf(0.0, p_elapsed)
	current_day = maxi(1, p_day)
	day_duration = maxf(1.0, p_duration)

func advance_time(delta: float) -> void:
	if delta <= 0.0:
		return
	elapsed_seconds += delta
	time_advanced.emit(elapsed_seconds)

func advance_day() -> void:
	current_day += 1
	# Snap elapsed time to the start of the new day cycle
	elapsed_seconds = float(current_day - 1) * day_duration
	day_changed.emit(current_day)

func get_day_progress() -> float:
	if day_duration <= 0.0:
		return 0.0
	var time_in_day: float = fmod(elapsed_seconds, day_duration)
	return time_in_day / day_duration

func reset() -> void:
	elapsed_seconds = 0.0
	current_day = 1
	day_duration = DEFAULT_DAY_DURATION

func to_dictionary() -> Dictionary:
	return {
		"elapsed_seconds": elapsed_seconds,
		"current_day": current_day,
		"day_duration": day_duration
	}

func from_dictionary(dict: Dictionary) -> void:
	elapsed_seconds = float(dict.get("elapsed_seconds", 0.0))
	current_day = maxi(1, int(dict.get("current_day", 1)))
	day_duration = maxf(1.0, float(dict.get("day_duration", DEFAULT_DAY_DURATION)))
