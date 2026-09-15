class_name FarmingState
extends RefCounted

## Authoritative domain state container for farming plots in Underhallow.
## Data-only container. Zero rendering dependencies, zero simulation controllers.

signal plot_changed(coord: Vector2i, plot: SoilPlotState)
signal farming_cleared()

# Dictionary mapping Vector2i (grid_coord) -> SoilPlotState
var _plots: Dictionary = {}

func _init() -> void:
	reset()

func reset() -> void:
	_plots.clear()
	farming_cleared.emit()

func get_plot(coord: Vector2i) -> SoilPlotState:
	return _plots.get(coord, null)

func has_plot(coord: Vector2i) -> bool:
	return _plots.has(coord)

func set_plot(coord: Vector2i, plot: SoilPlotState) -> void:
	if plot == null:
		_plots.erase(coord)
	else:
		plot.grid_coord = coord
		_plots[coord] = plot
	plot_changed.emit(coord, plot)

func get_all_plots() -> Dictionary:
	return _plots.duplicate()

func to_dictionary() -> Dictionary:
	var serialized: Dictionary = {}
	for coord: Variant in _plots.keys():
		var p: SoilPlotState = _plots[coord] as SoilPlotState
		if p != null:
			var key_str: String = "%d,%d" % [coord.x, coord.y]
			serialized[key_str] = p.to_dictionary()
	return serialized

func from_dictionary(dict: Dictionary) -> void:
	_plots.clear()
	for key_str: Variant in dict.keys():
		var parts: PackedStringArray = str(key_str).split(",")
		if parts.size() == 2:
			var coord: Vector2i = Vector2i(parts[0].to_int(), parts[1].to_int())
			var plot_dict: Dictionary = dict[key_str] as Dictionary
			if plot_dict != null:
				var plot: SoilPlotState = SoilPlotState.from_dictionary(plot_dict)
				_plots[coord] = plot
	farming_cleared.emit()
