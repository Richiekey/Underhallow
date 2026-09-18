class_name ClementineInteractable
extends InteractableObject

## Presentation and interaction adapter for Clementine (General Store NPC).
## Reads authoritative state strictly from GameState.progression_state.
## Dispatches AcceptObjectiveCommand and CompleteObjectiveCommand through GameRuntime.
## Never stores or mutates authoritative state locally.

const CONTENT_ID: StringName = &"clementine"
const OBJECTIVE_ID: StringName = &"clementine_intro"

const INTRO_DIALOGUE: String = "Hello there! You must be the newcomer who took over the old homestead across the water. I'm Clementine — I run the General Store here on the Reach. If you're looking to get settled, I could use some help stocking essentials: bring me 3 Wild Berries and 1 Raw Hide from a forest hare. Come see me once you have both!"
const ACTIVE_DIALOGUE: String = "Still gathering? I need 3 Wild Berries from woodland bushes and 1 Raw Hide from a forest hare. Let me know once you have both!"
const COMPLETE_DIALOGUE: String = "Wonderful work! These wild berries and raw hide are just what the store needed. Here's a bit of practical know-how to help you get your homestead growing."
const POST_COMPLETE_DIALOGUE: String = "Thanks again for your help stocking the shop! You're already making yourself right at home on the island."

@onready var state_label: Label = $StateLabel
@onready var visual_body: ColorRect = $VisualBody

var runtime: GameRuntime = null
var current_dialogue: String = ""

func _ready() -> void:
	super._ready()
	interaction_name = "Clementine"
	prompt_text = "Talk to Clementine"
	_find_runtime()
	update_visuals()

func bind_runtime(p_runtime: GameRuntime) -> void:
	runtime = p_runtime
	update_visuals()

func _find_runtime() -> void:
	if runtime == null and get_tree() != null:
		var root: Node = get_tree().root
		if root != null:
			var game_node: Node = root.get_node_or_null("Game")
			if game_node != null:
				runtime = game_node.get_node_or_null("Systems/Runtime") as GameRuntime

func get_progression_state() -> ProgressionState:
	_find_runtime()
	if runtime == null or runtime.game_state == null:
		return null
	return runtime.game_state.progression_state

func get_dialogue_state() -> String:
	var prog: ProgressionState = get_progression_state()
	if prog == null:
		return "intro"
	match prog.clementine_objective_state:
		ProgressionState.ClementineObjectiveState.INACTIVE:
			return "intro"
		ProgressionState.ClementineObjectiveState.ACTIVE:
			return "active"
		ProgressionState.ClementineObjectiveState.COMPLETED:
			return "complete"
		_:
			return "intro"

func get_current_dialogue() -> String:
	return current_dialogue

func update_prompt_for_player(_player: Node) -> void:
	var prog: ProgressionState = get_progression_state()
	if prog == null:
		prompt_text = "Talk to Clementine"
		return
	
	if prog.clementine_objective_state == ProgressionState.ClementineObjectiveState.ACTIVE:
		var inv: InventoryState = runtime.game_state.inventory_state if runtime and runtime.game_state else null
		var hunting: HuntingState = runtime.game_state.hunting_state if runtime and runtime.game_state else null
		if prog.can_complete_clementine_objective(inv, hunting):
			prompt_text = "Deliver Supplies to Clementine"
		else:
			prompt_text = "Talk to Clementine"
	else:
		prompt_text = "Talk to Clementine"

func interact(player: Node) -> void:
	_find_runtime()
	if runtime == null:
		printerr("ClementineInteractable Error: GameRuntime not found.")
		return
	
	var prog: ProgressionState = get_progression_state()
	if prog == null:
		return
	
	var player_pos: Vector2 = player.global_position if player != null else global_position
	
	match prog.clementine_objective_state:
		ProgressionState.ClementineObjectiveState.INACTIVE:
			var cmd: AcceptObjectiveCommand = AcceptObjectiveCommand.new(OBJECTIVE_ID)
			var res: CommandResult = runtime.execute_command(cmd)
			if res.success:
				current_dialogue = INTRO_DIALOGUE
			else:
				current_dialogue = res.message
		
		ProgressionState.ClementineObjectiveState.ACTIVE:
			var inv: InventoryState = runtime.game_state.inventory_state
			var hunting: HuntingState = runtime.game_state.hunting_state
			if prog.can_complete_clementine_objective(inv, hunting):
				var cmd: CompleteObjectiveCommand = CompleteObjectiveCommand.new(OBJECTIVE_ID, player_pos, global_position, true)
				var res: CommandResult = runtime.execute_command(cmd)
				if res.success:
					current_dialogue = COMPLETE_DIALOGUE
				else:
					current_dialogue = res.message
			else:
				var berries: int = inv.get_quantity(&"resource_wild_berries") if inv != null else 0
				var hide: int = inv.get_quantity(&"resource_raw_hide") if inv != null else 0
				current_dialogue = ACTIVE_DIALOGUE + "\n(Wild Berries: %d/3 | Raw Hide: %d/1)" % [berries, hide]
		
		ProgressionState.ClementineObjectiveState.COMPLETED:
			current_dialogue = POST_COMPLETE_DIALOGUE
	
	update_visuals()

func update_visuals() -> void:
	var prog: ProgressionState = get_progression_state()
	if state_label != null:
		if prog == null or prog.clementine_objective_state == ProgressionState.ClementineObjectiveState.INACTIVE:
			state_label.text = "Clementine\nGeneral Store"
		elif prog.clementine_objective_state == ProgressionState.ClementineObjectiveState.ACTIVE:
			state_label.text = "Clementine\n(Needs Supplies)"
		elif prog.clementine_objective_state == ProgressionState.ClementineObjectiveState.COMPLETED:
			state_label.text = "Clementine\nGeneral Store"
