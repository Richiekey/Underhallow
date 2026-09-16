class_name HotbarUI
extends Control

## Minimal tool hotbar UI component.
## Subordinate to gameplay loop per PH4-001. Displays 3 quick-select slots with count badge.

@onready var slot1_panel: PanelContainer = get_node_or_null("HBox/Slot1") as PanelContainer
@onready var slot2_panel: PanelContainer = get_node_or_null("HBox/Slot2") as PanelContainer
@onready var slot3_panel: PanelContainer = get_node_or_null("HBox/Slot3") as PanelContainer
@onready var slot4_panel: PanelContainer = get_node_or_null("HBox/Slot4") as PanelContainer
@onready var slot5_panel: PanelContainer = get_node_or_null("HBox/Slot5") as PanelContainer

@onready var slot3_count_label: Label = get_node_or_null("HBox/Slot3/Margin/VBox/CountLabel") as Label
@onready var slot4_count_label: Label = get_node_or_null("HBox/Slot4/Margin/VBox/CountLabel") as Label
@onready var slot5_count_label: Label = get_node_or_null("HBox/Slot5/Margin/VBox/CountLabel") as Label

var active_slot_index: int = 0
var runtime: GameRuntime = null
var player: PlayerController = null

func initialize(p_runtime: GameRuntime, p_player: PlayerController) -> void:
	runtime = p_runtime
	player = p_player
	
	if player != null:
		player.equipped_item_changed.connect(_on_player_equipped_changed)
	
	if runtime != null and runtime.game_state != null and runtime.game_state.inventory_state != null:
		runtime.game_state.inventory_state.item_changed.connect(_on_inventory_item_changed)
		runtime.game_state.inventory_state.inventory_cleared.connect(update_display)
	
	update_display()

func _on_player_equipped_changed(item_id: StringName) -> void:
	match item_id:
		&"tool_hoe":
			active_slot_index = 0
		&"tool_watering_can":
			active_slot_index = 1
		&"seed_carrot":
			active_slot_index = 2
		&"rustic_fence":
			active_slot_index = 3
		&"stone_path":
			active_slot_index = 4
	update_display()

func _on_inventory_item_changed(item_id: StringName, _new_qty: int) -> void:
	if item_id == &"seed_carrot" or item_id == &"resource_wood" or item_id == &"resource_stone":
		update_display()

func update_display() -> void:
	var seed_count: int = 0
	var wood_count: int = 0
	var stone_count: int = 0
	if runtime != null and runtime.game_state != null and runtime.game_state.inventory_state != null:
		seed_count = runtime.game_state.inventory_state.get_quantity(&"seed_carrot")
		wood_count = runtime.game_state.inventory_state.get_quantity(&"resource_wood")
		stone_count = runtime.game_state.inventory_state.get_quantity(&"resource_stone")
	
	if slot3_count_label != null:
		slot3_count_label.text = "x%d" % seed_count
	if slot4_count_label != null:
		slot4_count_label.text = "x%d" % wood_count
	if slot5_count_label != null:
		slot5_count_label.text = "x%d" % stone_count
	
	# Update visual selection outline
	_set_slot_highlight(slot1_panel, active_slot_index == 0)
	_set_slot_highlight(slot2_panel, active_slot_index == 1)
	_set_slot_highlight(slot3_panel, active_slot_index == 2)
	_set_slot_highlight(slot4_panel, active_slot_index == 3)
	_set_slot_highlight(slot5_panel, active_slot_index == 4)

func _set_slot_highlight(panel: PanelContainer, is_selected: bool) -> void:
	if panel == null:
		return
	if is_selected:
		panel.modulate = Color(1.2, 1.1, 0.6, 1.0)
	else:
		panel.modulate = Color(0.8, 0.8, 0.8, 0.8)
