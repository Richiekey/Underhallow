class_name AdvanceDayDebugCommand
extends SleepCommand

## Developer-only debug command for rapid day advancement.
## Bypasses cottage proximity validation for testing purposes per PH4-001 Section 30.

func _init() -> void:
	super._init(Vector2.ZERO, Vector2.ZERO, false)
