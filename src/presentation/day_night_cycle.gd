class_name DayNightCycle
extends CanvasModulate

## Lightweight, deterministic day/night lighting presentation for Underhallow.
## Driven strictly by GameTime simulation progression, never raw real-time delta accumulation.
## All cycle lengths and color palette values are Tier B Prototype Tuning Values.

## Tier B Prototype Default: 240s (4 minutes) full day/night cycle.
@export var day_length_seconds: float = 240.0

## Prototype palette colors:
const COLOR_DAY: Color = Color(1.0, 0.98, 0.94, 1.0)        # Warm clear sunlight
const COLOR_TWILIGHT: Color = Color(0.96, 0.70, 0.45, 1.0)   # Golden amber sunset
const COLOR_NIGHT: Color = Color(0.40, 0.46, 0.62, 1.0)      # Soft readable midnight blue
const COLOR_DAWN: Color = Color(0.92, 0.82, 0.76, 1.0)       # Rose-gold morning twilight

## Pure function evaluating ambient color from deterministic elapsed simulation time.
static func evaluate_ambient_color(elapsed_seconds: float, day_length: float = 240.0) -> Color:
	if day_length <= 0.0:
		return COLOR_DAY
	
	# Normalized day progress in range [0.0, 1.0)
	var progress: float = fposmod(elapsed_seconds, day_length) / day_length
	
	if progress < 0.20:
		# 0.00 - 0.20: Dawn into Day
		var t: float = progress / 0.20
		return COLOR_DAWN.lerp(COLOR_DAY, t)
	elif progress < 0.60:
		# 0.20 - 0.60: Full Day
		return COLOR_DAY
	elif progress < 0.75:
		# 0.60 - 0.75: Day into Twilight
		var t: float = (progress - 0.60) / 0.15
		return COLOR_DAY.lerp(COLOR_TWILIGHT, t)
	elif progress < 0.85:
		# 0.75 - 0.85: Twilight into Night
		var t: float = (progress - 0.75) / 0.10
		return COLOR_TWILIGHT.lerp(COLOR_NIGHT, t)
	elif progress < 0.95:
		# 0.85 - 0.95: Deep Cozy Night
		return COLOR_NIGHT
	else:
		# 0.95 - 1.00: Night into Dawn
		var t: float = (progress - 0.95) / 0.05
		return COLOR_NIGHT.lerp(COLOR_DAWN, t)

## Updates the ambient canvas modulate color from GameTime.
func update_cycle(elapsed_game_time: float) -> void:
	color = evaluate_ambient_color(elapsed_game_time, day_length_seconds)
