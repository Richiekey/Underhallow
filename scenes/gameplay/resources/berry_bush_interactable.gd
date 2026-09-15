class_name BerryBushInteractable
extends InteractableObject

## Interactable wild berry bush resource node.
## Contextual gathering hook executing GatherResourceCommand per IA-001 & PH4-001.

@export var node_id: StringName = &"wild_berry_bush_1"
@export var resource_id: StringName = &"resource_wild_berries"
@export var yield_count: int = 3

@onready var berries_visual: Node2D = $Visual/Berries

var runtime: GameRuntime = null

func _ready() -> void:
	interaction_name = "Wild Berry Bush"
	prompt_text = "Gather Berries"
	_find_runtime()
	update_visuals()

func _find_runtime() -> void:
	if runtime == null:
		var root: Node = get_tree().root
		var game_node: Node = root.get_node_or_null("Game")
		if game_node != null:
			runtime = game_node.get_node_or_null("Systems/Runtime") as GameRuntime

func is_depleted() -> bool:
	_find_runtime()
	if runtime == null or runtime.game_state == null or runtime.game_state.world_state == null:
		return false
	return runtime.game_state.world_state.is_gathered(node_id)

func update_prompt_for_player(_player: Node) -> void:
	if is_depleted():
		prompt_text = "Bush (Depleted)"
	else:
		prompt_text = "Gather Wild Berries"

func interact(player: Node) -> void:
	_find_runtime()
	if runtime == null:
		return
	
	if is_depleted():
		return
	
	var player_pos: Vector2 = player.global_position if player != null else global_position
	var cmd: GatherResourceCommand = GatherResourceCommand.new(
		node_id, resource_id, yield_count, player_pos, global_position, true
	)
	runtime.execute_command(cmd)
	update_visuals()

func update_visuals() -> void:
	var depleted: bool = is_depleted()
	if berries_visual != null:
		berries_visual.visible = not depleted
