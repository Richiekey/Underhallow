extends Node2D

## Game root controller for Underhallow.
## Coordinates runtime lifecycle, active world space, player spawn, camera tracking,
## dock-to-dock travel transitions, and deterministic day/night presentation.
## Integrates Phase 4 UI and command execution feedback.

const PlayerScene = preload("res://scenes/player/player.tscn")
const DefaultWorldScene = preload("res://scenes/world/personal_island.tscn")

@onready var world_container: Node2D = $World
@onready var camera: CameraController = $Camera
@onready var runtime: GameRuntime = $Systems/Runtime
@onready var day_night: DayNightCycle = $DayNight
@onready var status_bar: StatusBarUI = $UI/StatusBarUI
@onready var location_banner: Label = $UI/LocationBanner
@onready var toast_label: Label = $UI/InteractionToast
@onready var hotbar_ui: HotbarUI = $UI/HotbarUI
@onready var inventory_ui: InventoryUI = $UI/InventoryUI

var player_instance: PlayerController = null
var active_world: WorldSpace = null
var _toast_timer: float = 0.0
var _banner_timer: float = 0.0

func _ready() -> void:
	print("Underhallow: Phase 0 Project Bootstrap initialized successfully.")
	_verify_input_actions()
	_initialize_technical_spine()
	_load_initial_world()
	_initialize_ui()

func _verify_input_actions() -> void:
	var required_actions: Array[String] = [
		"move_up", "move_down", "move_left", "move_right",
		"interact", "cancel", "zoom_in", "zoom_out",
		"hotbar_1", "hotbar_2", "hotbar_3", "toggle_inventory", "debug_advance_day"
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
	
	runtime.command_executed.connect(_on_command_executed)
	runtime.command_failed.connect(_on_command_failed)
	print("Underhallow: Phase 1 Technical Spine initialized and running cleanly.")

func _initialize_ui() -> void:
	if status_bar != null:
		status_bar.initialize(runtime)
	if inventory_ui != null:
		inventory_ui.initialize(runtime)
	if hotbar_ui != null:
		hotbar_ui.initialize(runtime, player_instance)

func _load_initial_world() -> void:
	# Instantiate default starting world: Personal Island
	active_world = DefaultWorldScene.instantiate() as WorldSpace
	if active_world == null:
		printerr("Underhallow Error: Failed to instantiate DefaultWorldScene.")
		return
	
	world_container.add_child(active_world)
	active_world.travel_requested.connect(_on_travel_requested)
	
	_spawn_player("SpawnMarker")
	_show_location_banner(active_world.display_name)

func _spawn_player(marker_name: String) -> void:
	if PlayerScene == null:
		printerr("Underhallow Error: PlayerScene failed to preload.")
		return
	
	if player_instance == null:
		player_instance = PlayerScene.instantiate() as PlayerController
		world_container.add_child(player_instance)
		
		# Wire player domain state to authoritative GameState
		if runtime != null and runtime.game_state != null:
			player_instance.player_state = runtime.game_state.player_state
		
		# Setup interaction listeners
		if player_instance.interaction_detector != null:
			player_instance.interaction_detector.interactable_focused.connect(_on_interactable_focused)
			player_instance.interaction_detector.interactable_unfocused.connect(_on_interactable_unfocused)
			player_instance.interaction_detector.interaction_executed.connect(_on_interaction_executed)
	
	# Position player at specified world marker
	var target_pos: Vector2 = Vector2.ZERO
	if active_world != null:
		target_pos = active_world.get_marker_position(marker_name)
	
	player_instance.global_position = target_pos
	if player_instance.player_state != null:
		player_instance.player_state.position = target_pos
	
	# Bind camera to player
	if camera != null:
		camera.set_target(player_instance)
	
	print("Underhallow: Player positioned at %s %s" % [marker_name, target_pos])

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_inventory"):
		if inventory_ui != null:
			inventory_ui.toggle()
	elif event.is_action_pressed("debug_advance_day"):
		if runtime != null:
			runtime.execute_command(AdvanceDayDebugCommand.new())

func _on_command_executed(cmd: Command, result: CommandResult) -> void:
	if cmd is SleepCommand:
		if runtime != null and runtime.game_state != null and runtime.game_state.time_state != null:
			_show_location_banner("Day %d" % runtime.game_state.time_state.current_day)
		_show_toast(result.message, 3.5)
		_refresh_all_world_nodes()
	elif result.message != "":
		_show_toast(result.message, 2.0)

func _on_command_failed(_cmd: Command, result: CommandResult) -> void:
	if result.message != "":
		_show_toast(result.message, 2.0)

func _refresh_all_world_nodes() -> void:
	# Refreshes FarmPlot and BerryBush visuals across active world
	if active_world != null:
		for plot: Node in active_world.find_children("*", "FarmPlot", true, false):
			if plot.has_method("update_visuals"):
				plot.update_visuals()
		for bush: Node in active_world.find_children("*", "BerryBushInteractable", true, false):
			if bush.has_method("update_visuals"):
				bush.update_visuals()

## Handles dock-to-dock travel transition between world spaces.
func _on_travel_requested(destination_scene_path: String, arrival_marker: String) -> void:
	print("[Underhallow Travel] Transitioning to: ", destination_scene_path, " via ", arrival_marker)
	switch_world(destination_scene_path, arrival_marker)

## Seamless world space transition
func switch_world(destination_scene_path: String, arrival_marker: String) -> void:
	var next_scene_res: PackedScene = load(destination_scene_path) as PackedScene
	if next_scene_res == null:
		printerr("Underhallow Travel Error: Cannot load destination scene: ", destination_scene_path)
		return
	
	var new_world: WorldSpace = next_scene_res.instantiate() as WorldSpace
	if new_world == null:
		printerr("Underhallow Travel Error: Destination scene is not a WorldSpace: ", destination_scene_path)
		return
	
	# Remove previous world space
	if active_world != null:
		if active_world.travel_requested.is_connected(_on_travel_requested):
			active_world.travel_requested.disconnect(_on_travel_requested)
		active_world.queue_free()
	
	# Add new world space
	active_world = new_world
	world_container.add_child(active_world)
	active_world.travel_requested.connect(_on_travel_requested)
	
	# Reposition player at arrival marker
	var arrival_pos: Vector2 = active_world.get_marker_position(arrival_marker)
	if player_instance != null:
		player_instance.global_position = arrival_pos
		if player_instance.player_state != null:
			player_instance.player_state.position = arrival_pos
	
	if camera != null:
		camera.set_target(player_instance)
	
	_show_location_banner(active_world.display_name)
	_show_toast("Arrived at %s" % active_world.display_name, 3.0)

func _on_interactable_focused(target: Node) -> void:
	var prompt: String = "Inspect"
	var target_name: String = "Object"
	
	if target.has_method("update_prompt_for_player"):
		target.update_prompt_for_player(player_instance)
	
	if target is InteractableObject:
		prompt = target.prompt_text
		target_name = target.interaction_name
	
	_show_toast("Press [E] to %s" % prompt, 0.5)

func _on_interactable_unfocused() -> void:
	if _toast_timer <= 0.6:
		toast_label.text = ""

func _on_interaction_executed(target: Node) -> void:
	if target is InspectableSign:
		_show_toast(target.inspect_text, 4.0)
	elif target.name == "ArchInteractable" or (target.get_parent() != null and target.get_parent().name == "AncientArch"):
		_show_toast("Ancient Stone Arch: Warm to the touch. Faint spirals are worn into the granite.", 4.5)
	elif target is TravelDock:
		_show_toast("Boarding boat...", 1.5)

func _show_location_banner(location_name: String) -> void:
	if location_banner != null:
		location_banner.text = "— %s —" % location_name
		_banner_timer = 4.0

func _show_toast(text: String, duration: float) -> void:
	if toast_label != null:
		toast_label.text = text
		_toast_timer = duration

func _process(delta: float) -> void:
	if runtime != null and runtime.current_state == GameRuntime.LifecycleState.RUNNING:
		runtime.update_simulation(delta)
		
		# Update deterministic day/night presentation
		if day_night != null:
			day_night.update_cycle(runtime.game_time.elapsed_seconds)
	
	if _toast_timer > 0.0:
		_toast_timer -= delta
		if _toast_timer <= 0.0 and toast_label != null:
			toast_label.text = ""
			
	if _banner_timer > 0.0:
		_banner_timer -= delta
		if _banner_timer <= 0.0 and location_banner != null:
			location_banner.text = ""

func _exit_tree() -> void:
	if runtime != null:
		runtime.shutdown_runtime()
