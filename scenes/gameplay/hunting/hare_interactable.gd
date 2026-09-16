class_name HareInteractable
extends InteractableObject

## Presentation and interaction adapter for a wild hare.
## Reads authoritative state strictly from GameState.hunting_state.
## Never stores or mutates authoritative state locally.

@export var creature_instance_id: StringName = &"hare_01"

@onready var visual_body: ColorRect = $VisualBody
@onready var state_label: Label = $StateLabel

var runtime: GameRuntime = null

func _ready() -> void:
	super._ready()
	interaction_name = "Forest Hare"
	prompt_text = "Observe Hare"
	_find_runtime()
	update_visuals()

func _find_runtime() -> void:
	if runtime == null:
		var root: Node = get_tree().root
		var game_node: Node = root.get_node_or_null("Game")
		if game_node != null:
			runtime = game_node.get_node_or_null("Systems/Runtime") as GameRuntime

func get_creature_state() -> CreatureState:
	_find_runtime()
	if runtime == null or runtime.game_state == null or runtime.game_state.hunting_state == null:
		return null
	return runtime.game_state.hunting_state.get_creature(creature_instance_id)

func update_prompt_for_player(_player: Node) -> void:
	var creature: CreatureState = get_creature_state()
	if creature == null:
		prompt_text = "Approach Wildlife"
	elif not creature.is_discovered:
		prompt_text = "Discover Hare"
	elif not creature.is_defeated:
		prompt_text = "Attack Hare (%d HP)" % creature.current_health
	elif not creature.is_harvested:
		prompt_text = "Harvest Hare"
	else:
		prompt_text = "Hare (Harvested)"

func interact(player: Node) -> void:
	_find_runtime()
	if runtime == null:
		printerr("HareInteractable Error: GameRuntime not found.")
		return
	
	var creature: CreatureState = get_creature_state()
	if creature == null:
		return
	
	var player_pos: Vector2 = player.global_position if player != null else global_position
	var cmd: Command = null
	
	if not creature.is_discovered:
		cmd = DiscoverCreatureCommand.new(creature_instance_id)
	elif not creature.is_defeated:
		cmd = AttackCreatureCommand.new(creature_instance_id, 5, player_pos, global_position, true)
	elif not creature.is_harvested:
		cmd = HarvestCreatureCommand.new(creature_instance_id, player_pos, global_position, true)
	
	if cmd != null:
		runtime.execute_command(cmd)
	
	update_visuals()

func update_visuals() -> void:
	var creature: CreatureState = get_creature_state()
	if creature == null:
		if visual_body != null:
			visual_body.color = Color(0.7, 0.6, 0.5, 1.0)
		if state_label != null:
			state_label.text = "Hare"
		return
	
	if creature.is_harvested:
		if visual_body != null:
			visual_body.color = Color(0.4, 0.4, 0.4, 0.4) # Faded harvested
		if state_label != null:
			state_label.text = "Harvested"
	elif creature.is_defeated:
		if visual_body != null:
			visual_body.color = Color(0.6, 0.5, 0.3, 0.8) # Subdued
		if state_label != null:
			state_label.text = "Defeated"
	else:
		if visual_body != null:
			visual_body.color = Color(0.82, 0.72, 0.58, 1.0) # Active hare
		if state_label != null:
			state_label.text = "%d HP" % creature.current_health
