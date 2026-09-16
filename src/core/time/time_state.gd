class_name TimeState
extends RefCounted

## Derived calendar and simulation time representation container.
## Tracks day counter and elapsed simulation time synchronized from canonical GameTime per A-001.
## Pure data container. Authoritative simulation time is governed solely by GameTime.

signal day_changed(new_day: int)
signal time_advanced(elapsed_seconds: float)

## Tier B Prototype Tuning Default: 240 seconds per day cycle
const DEFAULT_DAY_DURATION: float = 240.0

var elapsed_seconds: float = 0.0
var current_day: int = 1
var day_duration: float = DEFAULT_DAY_DURATION

func _init(p_elapsed: float = 0.0, p_day: int = 1, p_duration: float = DEFAULT_DAY_DURATION) -> void:
	day_duration = maxf(1.0, p_duration)
	sync_from_elapsed_seconds(p_elapsed)
	if p_day > current_day:
		current_day = p_day

## Synchronizes calendar state from canonical GameTime.
func sync_from_game_time(game_time: GameTime) -> void:
	if game_time == null:
		return
	sync_from_elapsed_seconds(game_time.elapsed_seconds)

## Derives current day and calendar position from canonical elapsed seconds using configured day_duration.
func sync_from_elapsed_seconds(seconds: float) -> void:
	var prev_day: int = current_day
	elapsed_seconds = maxf(0.0, seconds)
	if day_duration > 0.0:
		current_day = int(floor(elapsed_seconds / day_duration)) + 1
	else:
		current_day = 1
	
	if current_day != prev_day:
		day_changed.emit(current_day)
	time_advanced.emit(elapsed_seconds)

## @deprecated A-001: Simulation time is governed strictly by GameTime.
func advance_time(_delta: float) -> void:
	push_warning("TimeState.advance_time() is deprecated under A-001. Simulation time must be advanced via GameTime.")

## @deprecated A-001: Day advancement is governed by authoritative GameTime.
func advance_day() -> void:
	push_warning("TimeState.advance_day() is deprecated under A-001. Day advancement must be executed via GameTime or SleepCommand.")

func get_day_progress() -> float:
	if day_duration <= 0.0:
		return 0.0
	var time_in_day: float = fposmod(elapsed_seconds, day_duration)
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
	day_duration = maxf(1.0, float(dict.get("day_duration", DEFAULT_DAY_DURATION)))
	var raw_elapsed: float = float(dict.get("elapsed_seconds", 0.0))
	sync_from_elapsed_seconds(raw_elapsed)
