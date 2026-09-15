class_name InventoryUI
extends Control

## Minimal inventory UI panel.
## Toggled via [I] key. Renders authoritative InventoryState items per PH4-001.

@onready var items_container: VBoxContainer = $Panel/Margin/VBox/Scroll/ItemsList

var runtime: GameRuntime = null

func initialize(p_runtime: GameRuntime) -> void:
	runtime = p_runtime
	visible = false
	
	if runtime != null and runtime.game_state != null and runtime.game_state.inventory_state != null:
		runtime.game_state.inventory_state.item_changed.connect(func(_id, _qty): refresh())
		runtime.game_state.inventory_state.inventory_cleared.connect(refresh)

func toggle() -> void:
	visible = not visible
	if visible:
		refresh()

func refresh() -> void:
	if items_container == null:
		return
	
	# Clear old list items
	for child: Node in items_container.get_children():
		child.queue_free()
	
	if runtime == null or runtime.game_state == null or runtime.game_state.inventory_state == null:
		return
	
	var items: Dictionary = runtime.game_state.inventory_state.get_all_items()
	if items.is_empty():
		var empty_lbl: Label = Label.new()
		empty_lbl.text = "Inventory is empty."
		empty_lbl.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		items_container.add_child(empty_lbl)
		return
	
	for item_id: Variant in items.keys():
		var count: int = items[item_id]
		var item_def: ItemDefinition = ItemDatabase.get_definition(item_id)
		var display_name: String = item_def.display_name if item_def != null else str(item_id)
		
		var row: HBoxContainer = HBoxContainer.new()
		var name_lbl: Label = Label.new()
		name_lbl.text = display_name
		name_lbl.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		
		var qty_lbl: Label = Label.new()
		qty_lbl.text = "x%d" % count
		
		row.add_child(name_lbl)
		row.add_child(qty_lbl)
		items_container.add_child(row)
