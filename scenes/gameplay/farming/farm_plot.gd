class_name FarmPlot
extends InteractableObject

## Interactable farm plot.
## Reuses existing contextual interaction architecture per IA-001 & PH4-001.
## Connects contextual interaction directly to authoritative Command execution.

@export var grid_coord: Vector2i = Vector2i.ZERO

@onready var soil_visual: ColorRect = $SoilVisual
@onready var water_overlay: ColorRect = $WaterOverlay
@onready var crop_root: Node2D = $CropVisual
@onready var sprout_visual: Node2D = $CropVisual/Sprout
@onready var growing_visual: Node2D = $CropVisual/Growing
@onready var mature_visual: Node2D = $CropVisual/Mature

var runtime: GameRuntime = null

func _ready() -> void:
	interaction_name = "Farm Plot"
	prompt_text = "Work Soil"
	_find_runtime()
	update_visuals()

func _find_runtime() -> void:
	if runtime == null:
		var root: Node = get_tree().root
		var game_node: Node = root.get_node_or_null("Game")
		if game_node != null:
			runtime = game_node.get_node_or_null("Systems/Runtime") as GameRuntime

func get_plot_state() -> SoilPlotState:
	if runtime == null or runtime.game_state == null or runtime.game_state.farming_state == null:
		return null
	return runtime.game_state.farming_state.get_plot(grid_coord)

func update_prompt_for_player(player: Node) -> void:
	_find_runtime()
	var plot: SoilPlotState = get_plot_state()
	var equipped: StringName = &""
	if player != null and "equipped_item_id" in player:
		equipped = player.equipped_item_id
	
	if plot == null or not plot.is_tilled:
		if equipped == &"tool_hoe":
			prompt_text = "Till Soil"
		else:
			prompt_text = "Till Soil (Equip Hoe)"
	elif plot.crop == null:
		if equipped == &"seed_carrot":
			prompt_text = "Plant Carrot"
		elif equipped == &"tool_watering_can":
			if plot.is_watered:
				prompt_text = "Soil (Watered)"
			else:
				prompt_text = "Water Soil"
		else:
			prompt_text = "Tilled Soil (Equip Seed/Can)"
	else:
		# Plot has a crop
		if plot.crop.is_mature or plot.crop.growth_stage >= 2:
			prompt_text = "Harvest Carrot"
		elif not plot.is_watered and equipped == &"tool_watering_can":
			prompt_text = "Water Carrot"
		elif plot.is_watered:
			prompt_text = "Carrot (Watered)"
		else:
			prompt_text = "Carrot (Growing)"

func interact(player: Node) -> void:
	_find_runtime()
	if runtime == null:
		printerr("FarmPlot Error: GameRuntime not found.")
		return
	
	var plot: SoilPlotState = get_plot_state()
	var equipped: StringName = &""
	if player != null and "equipped_item_id" in player:
		equipped = player.equipped_item_id
	
	var player_pos: Vector2 = player.global_position if player != null else global_position
	var cmd: Command = null
	
	if plot == null or not plot.is_tilled:
		if equipped == &"tool_hoe":
			cmd = TillSoilCommand.new(grid_coord, player_pos, global_position, true)
	elif plot.crop == null:
		if equipped == &"seed_carrot":
			cmd = PlantCropCommand.new(grid_coord, &"carrot", player_pos, global_position, true)
		elif equipped == &"tool_watering_can":
			cmd = WaterCropCommand.new(grid_coord, player_pos, global_position, true)
	else:
		# Has crop
		if plot.crop.is_mature or plot.crop.growth_stage >= 2:
			cmd = HarvestCropCommand.new(grid_coord, player_pos, global_position, true)
		elif equipped == &"tool_watering_can" and not plot.is_watered:
			cmd = WaterCropCommand.new(grid_coord, player_pos, global_position, true)
	
	if cmd != null:
		runtime.execute_command(cmd)
	
	update_visuals()

func update_visuals() -> void:
	var plot: SoilPlotState = get_plot_state()
	if plot == null or not plot.is_tilled:
		if soil_visual != null:
			soil_visual.color = Color(0.38, 0.32, 0.24, 0.4) # Raw earth tint
		if water_overlay != null:
			water_overlay.visible = false
		if crop_root != null:
			crop_root.visible = false
		return
	
	# Tilled soil
	if soil_visual != null:
		soil_visual.color = Color(0.26, 0.17, 0.10, 1.0) # Rich dark tilled loam
	
	# Watered overlay
	if water_overlay != null:
		water_overlay.visible = plot.is_watered
	
	# Crop stages
	if crop_root != null:
		if plot.crop == null:
			crop_root.visible = false
		else:
			crop_root.visible = true
			if sprout_visual != null:
				sprout_visual.visible = (plot.crop.growth_stage == 0)
			if growing_visual != null:
				growing_visual.visible = (plot.crop.growth_stage == 1)
			if mature_visual != null:
				mature_visual.visible = (plot.crop.growth_stage >= 2 or plot.crop.is_mature)
