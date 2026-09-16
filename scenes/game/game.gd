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
@onready var prompt_label: Label = $UI/InteractionPrompt
@onready var toast_label: Label = $UI/InteractionToast
@onready var hotbar_ui: HotbarUI = $UI/HotbarUI
@onready var inventory_ui: InventoryUI = $UI/InventoryUI

var player_instance: PlayerController = null
var active_world: WorldSpace = null
var active_interaction_target: Node = null
var interaction_prompt_visible: bool = false
var _is_initialized: bool = false
var _toast_timer: float = 0.0
var _banner_timer: float = 0.0

func _ready() -> void:
	if _is_initialized:
		return
	_is_initialized = true
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
	
	if not runtime.command_executed.is_connected(_on_command_executed):
		runtime.command_executed.connect(_on_command_executed)
	if not runtime.command_failed.is_connected(_on_command_failed):
		runtime.command_failed.connect(_on_command_failed)
	
	# Authoritative world creature setup for Phase 4 Vertical Slice
	if runtime.game_state != null and runtime.game_state.hunting_state != null:
		if not runtime.game_state.hunting_state.has_creature(&"hare_01"):
			runtime.game_state.hunting_state.register_creature(&"hare_01", &"hare", Vector2(60, -120))
	
	print("Underhallow: Phase 1 Technical Spine initialized and running cleanly.")

func _initialize_ui() -> void:
	if status_bar != null:
		status_bar.initialize(runtime)
	if inventory_ui != null:
		inventory_ui.initialize(runtime)
	if hotbar_ui != null:
		hotbar_ui.initialize(runtime, player_instance)
	if prompt_label != null:
		prompt_label.text = ""
		prompt_label.visible = false
	if toast_label != null:
		toast_label.text = ""
		toast_label.visible = false

func _load_initial_world() -> void:
	# Instantiate default starting world: Personal Island
	active_world = DefaultWorldScene.instantiate() as WorldSpace
	if active_world == null:
		printerr("Underhallow Error: Failed to instantiate DefaultWorldScene.")
		return
	
	world_container.add_child(active_world)
	if not active_world.travel_requested.is_connected(_on_travel_requested):
		active_world.travel_requested.connect(_on_travel_requested)
	
	_setup_world_building_display(active_world)
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
			if not player_instance.interaction_detector.interactable_focused.is_connected(_on_interactable_focused):
				player_instance.interaction_detector.interactable_focused.connect(_on_interactable_focused)
			if not player_instance.interaction_detector.interactable_unfocused.is_connected(_on_interactable_unfocused):
				player_instance.interaction_detector.interactable_unfocused.connect(_on_interactable_unfocused)
			if not player_instance.interaction_detector.interaction_executed.is_connected(_on_interaction_executed):
				player_instance.interaction_detector.interaction_executed.connect(_on_interaction_executed)
		
		if not player_instance.equipped_item_changed.is_connected(_on_player_equipped_changed):
			player_instance.equipped_item_changed.connect(_on_player_equipped_changed)
	
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
	
	if active_interaction_target != null:
		_update_interaction_prompt()

func _on_command_failed(_cmd: Command, result: CommandResult) -> void:
	if result.message != "":
		_show_toast(result.message, 2.0)

func _refresh_all_world_nodes() -> void:
	# Refreshes FarmPlot, BerryBush, and Hare visuals across active world
	if active_world != null:
		for plot: Node in active_world.find_children("*", "FarmPlot", true, false):
			if plot.has_method("update_visuals"):
				plot.update_visuals()
		for bush: Node in active_world.find_children("*", "BerryBushInteractable", true, false):
			if bush.has_method("update_visuals"):
				bush.update_visuals()
		for hare: Node in active_world.find_children("*", "HareInteractable", true, false):
			if hare.has_method("update_visuals"):
				hare.update_visuals()

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
	_setup_world_building_display(active_world)
	
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

func _setup_world_building_display(world: WorldSpace) -> void:
	if world == null:
		return
	var building_display: BuildingDisplay = world.get_node_or_null("BuildingDisplay") as BuildingDisplay
	if building_display == null:
		building_display = BuildingDisplay.new()
		building_display.name = "BuildingDisplay"
		world.add_child(building_display)
	if runtime != null and runtime.game_state != null:
		building_display.initialize_from_state(runtime.game_state.building_state)

func _on_interactable_focused(target: Node) -> void:
	active_interaction_target = target
	_update_interaction_prompt()

func _on_interactable_unfocused() -> void:
	_hide_interaction_prompt()

func _on_interaction_executed(target: Node) -> void:
	if target is InspectableSign:
		_show_toast(target.inspect_text, 4.0)
	elif target.name == "ArchInteractable" or (target.get_parent() != null and target.get_parent().name == "AncientArch"):
		_show_toast("Ancient Stone Arch: Warm to the touch. Faint spirals are worn into the granite.", 4.5)
	elif target is TravelDock:
		_show_toast("Boarding boat...", 1.5)
	
	if active_interaction_target != null:
		_update_interaction_prompt()

func _on_player_equipped_changed(_item_id: StringName) -> void:
	if active_interaction_target != null:
		_update_interaction_prompt()

func _update_interaction_prompt() -> void:
	if active_interaction_target == null or not is_instance_valid(active_interaction_target):
		_hide_interaction_prompt()
		return
	
	if active_interaction_target.has_method("update_prompt_for_player"):
		active_interaction_target.update_prompt_for_player(player_instance)
	
	var prompt: String = "Inspect"
	if active_interaction_target is InteractableObject:
		prompt = active_interaction_target.prompt_text
	elif "prompt_text" in active_interaction_target:
		prompt = active_interaction_target.prompt_text
	
	_show_interaction_prompt("Press [E] to %s" % prompt)

func get_prompt_label() -> Label:
	if prompt_label == null and has_node("UI/InteractionPrompt"):
		prompt_label = get_node("UI/InteractionPrompt") as Label
	return prompt_label

func get_toast_label() -> Label:
	if toast_label == null and has_node("UI/InteractionToast"):
		toast_label = get_node("UI/InteractionToast") as Label
	return toast_label

func _show_interaction_prompt(text: String) -> void:
	interaction_prompt_visible = true
	var label: Label = get_prompt_label()
	if label == null:
		label = get_toast_label()
	if label != null:
		label.text = text
		label.visible = true

func _hide_interaction_prompt() -> void:
	active_interaction_target = null
	interaction_prompt_visible = false
	var label: Label = get_prompt_label()
	if label == null:
		label = get_toast_label()
	if label != null:
		label.text = ""
		label.visible = false

func _show_location_banner(location_name: String) -> void:
	if location_banner != null:
		location_banner.text = "— %s —" % location_name
		_banner_timer = 4.0

func _show_toast(text: String, duration: float) -> void:
	var label: Label = get_toast_label()
	if label != null:
		label.text = text
		label.visible = true
		_toast_timer = duration

func _process(delta: float) -> void:
	if runtime != null and runtime.current_state == GameRuntime.LifecycleState.RUNNING:
		runtime.update_simulation(delta)
		
		# Update deterministic day/night presentation
		if day_night != null:
			day_night.update_cycle(runtime.game_time.elapsed_seconds)
	
	if _toast_timer > 0.0:
		_toast_timer -= delta
		if _toast_timer <= 0.0:
			var label: Label = get_toast_label()
			if label != null:
				label.text = ""
				label.visible = false
			
	if _banner_timer > 0.0:
		_banner_timer -= delta
		if _banner_timer <= 0.0 and location_banner != null:
			location_banner.text = ""

func _exit_tree() -> void:
	if runtime != null:
		runtime.shutdown_runtime()

