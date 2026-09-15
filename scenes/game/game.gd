extends Node2D

## Game root controller.
## Orchestrates high-level runtime lifecycle, player spawn, and camera binding.
## Adheres to single source of truth: binds spawned PlayerController to GameRuntime.game_state.player_state.

const PlayerScene = preload("res://scenes/player/player.tscn")

@onready var world: Node2D = $World
@onready var spawn_marker: Marker2D = $World/SpawnMarker
@onready var camera: CameraController = $Camera
@onready var runtime: GameRuntime = $Systems/Runtime
@onready var dev_label: Label = $UI/DevLabel
@onready var toast_label: Label = $UI/InteractionToast
@onready var dev_sign: InteractableObject = $World/Interactables/DevSign

var player_instance: PlayerController = null
var _toast_timer: float = 0.0

func _ready() -> void:
	print("Underhallow: Phase 0 Project Bootstrap initialized successfully.")
	_verify_input_actions()
	_initialize_technical_spine()
	_spawn_player()
	_setup_interaction_hooks()

func _verify_input_actions() -> void:
	var required_actions: Array[String] = [
		"move_up",
		"move_down",
		"move_left",
		"move_right",
		"interact",
		"cancel",
		"zoom_in",
		"zoom_out"
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

func _spawn_player() -> void:
	if PlayerScene == null:
		printerr("Underhallow Error: PlayerScene failed to preload.")
		return
	
	player_instance = PlayerScene.instantiate() as PlayerController
	if player_instance == null:
		printerr("Underhallow Error: Failed to instantiate PlayerController.")
		return
	
	# Wire player domain state to the authoritative GameState
	if runtime != null and runtime.game_state != null:
		player_instance.player_state = runtime.game_state.player_state
	
	# Place player at spawn marker
	var spawn_pos: Vector2 = spawn_marker.global_position if spawn_marker != null else Vector2.ZERO
	player_instance.global_position = spawn_pos
	if player_instance.player_state != null:
		player_instance.player_state.position = spawn_pos
	
	world.add_child(player_instance)
	
	# Bind camera target to player
	if camera != null:
		camera.set_target(player_instance)
	
	print("Underhallow: Player spawned at ", spawn_pos, "; camera tracking initialized.")

func _setup_interaction_hooks() -> void:
	if dev_sign != null:
		dev_sign.interacted.connect(_on_sign_interacted)
	
	if player_instance != null and player_instance.interaction_detector != null:
		player_instance.interaction_detector.interactable_focused.connect(_on_interactable_focused)
		player_instance.interaction_detector.interactable_unfocused.connect(_on_interactable_unfocused)

func _on_sign_interacted(_by_player: Node) -> void:
	var msg: String = "Sanctuary Sign: \"Welcome to Underhallow. The island is quiet, but deep.\""
	print("[Underhallow Interaction] ", msg)
	_show_toast(msg, 4.0)

func _on_interactable_focused(target: Node) -> void:
	var prompt: String = "Inspect"
	var target_name: String = "Object"
	if target is InteractableObject:
		prompt = target.prompt_text
		target_name = target.interaction_name
	_show_toast("Press [E] to %s %s" % [prompt, target_name], 0.5)

func _on_interactable_unfocused() -> void:
	if _toast_timer <= 0.6:
		toast_label.text = ""

func _show_toast(text: String, duration: float) -> void:
	if toast_label != null:
		toast_label.text = text
		_toast_timer = duration

func _process(delta: float) -> void:
	if runtime != null and runtime.current_state == GameRuntime.LifecycleState.RUNNING:
		runtime.update_simulation(delta)
	
	if _toast_timer > 0.0:
		_toast_timer -= delta
		if _toast_timer <= 0.0 and toast_label != null:
			toast_label.text = ""

func _exit_tree() -> void:
	if runtime != null:
		runtime.shutdown_runtime()
