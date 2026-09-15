extends Node2D

## Game root controller.
## Orchestrates high-level runtime lifecycle without implementing gameplay mechanics.

@onready var runtime: GameRuntime = $Systems/Runtime
@onready var dev_label: Label = $UI/DevLabel

func _ready() -> void:
	print("Underhallow: Phase 0 Project Bootstrap initialized successfully.")
	_verify_input_actions()
	_initialize_technical_spine()

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

func _initialize_technical_spine() -> void:
	if runtime == null:
		printerr("Underhallow Error: GameRuntime node not found under Systems/Runtime.")
		return
	
	runtime.initialize_runtime()
	runtime.start_runtime()
	print("Underhallow: Phase 1 Technical Spine initialized and running cleanly.")

func _process(delta: float) -> void:
	if runtime != null and runtime.current_state == GameRuntime.LifecycleState.RUNNING:
		runtime.update_simulation(delta)

func _exit_tree() -> void:
	if runtime != null:
		runtime.shutdown_runtime()
