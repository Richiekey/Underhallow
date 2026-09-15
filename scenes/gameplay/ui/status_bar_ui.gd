class_name StatusBarUI
extends Control

## Minimal HUD status display for Day count and Farming progression.
## Subordinate to gameplay loop per PH4-001.

@onready var day_label: Label = $VBox/DayLabel
@onready var farming_label: Label = $VBox/FarmingLabel

var runtime: GameRuntime = null

func initialize(p_runtime: GameRuntime) -> void:
	runtime = p_runtime
	if runtime != null and runtime.game_state != null:
		if runtime.game_state.time_state != null:
			runtime.game_state.time_state.day_changed.connect(func(_d): update_display())
		if runtime.game_state.progression_state != null:
			runtime.game_state.progression_state.farming_xp_gained.connect(func(_a, _t): update_display())
			runtime.game_state.progression_state.farming_leveled_up.connect(func(_l): update_display())
	
	update_display()

func update_display() -> void:
	var current_day: int = 1
	var xp: int = 0
	var level: int = 1
	
	if runtime != null and runtime.game_state != null:
		if runtime.game_state.time_state != null:
			current_day = runtime.game_state.time_state.current_day
		if runtime.game_state.progression_state != null:
			xp = runtime.game_state.progression_state.farming_xp
			level = runtime.game_state.progression_state.farming_level
	
	if day_label != null:
		day_label.text = "Day %d" % current_day
	if farming_label != null:
		farming_label.text = "Farming Lv. %d (%d XP)" % [level, xp]
