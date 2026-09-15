class_name CottageDoorInteractable
extends InteractableObject

## Interactable cottage door / bed for sleeping and day advancement.
## Contextual sleep hook executing SleepCommand per PH4-001 Section 28.

var runtime: GameRuntime = null

func _ready() -> void:
	interaction_name = "Cottage Door"
	prompt_text = "Sleep until Morning"
	_find_runtime()

func _find_runtime() -> void:
	if runtime == null:
		var root: Node = get_tree().root
		var game_node: Node = root.get_node_or_null("Game")
		if game_node != null:
			runtime = game_node.get_node_or_null("Systems/Runtime") as GameRuntime

func interact(player: Node) -> void:
	_find_runtime()
	if runtime == null:
		return
	
	var player_pos: Vector2 = player.global_position if player != null else global_position
	var cmd: SleepCommand = SleepCommand.new(player_pos, global_position, true)
	runtime.execute_command(cmd)
