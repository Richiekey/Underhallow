extends Node2D

## Phase 0 Bootstrap verification script.
## Confirms engine initialization and validates required logical input actions.

func _ready() -> void:
	print("Underhallow: Phase 0 Project Bootstrap initialized successfully.")
	_verify_input_actions()

func _verify_input_actions() -> void:
	var required_actions: Array[String] = [
		"move_up",
		"move_down",
		"move_left",
		"move_right",
		"interact",
		"cancel"
	]
	var all_actions_valid: bool = true
	for action: String in required_actions:
		if not InputMap.has_action(action):
			printerr("Underhallow Bootstrap Warning: Missing required action '", action, "'")
			all_actions_valid = false
	if all_actions_valid:
		print("Underhallow: All baseline input actions successfully verified.")
