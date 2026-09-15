class_name SoilPlotState
extends RefCounted

## Authoritative domain state for a single farm grid plot.
## Pure data container per IA-001 Section 3.1 & 3.2.

var grid_coord: Vector2i = Vector2i.ZERO
var is_tilled: bool = false
var is_watered: bool = false
var crop: CropState = null

func _init(p_coord: Vector2i = Vector2i.ZERO, p_tilled: bool = false, p_watered: bool = false, p_crop: CropState = null) -> void:
	grid_coord = p_coord
	is_tilled = p_tilled
	is_watered = p_watered
	crop = p_crop

func to_dictionary() -> Dictionary:
	return {
		"x": grid_coord.x,
		"y": grid_coord.y,
		"is_tilled": is_tilled,
		"is_watered": is_watered,
		"crop": crop.to_dictionary() if crop != null else null
	}

static func from_dictionary(dict: Dictionary) -> SoilPlotState:
	var coord: Vector2i = Vector2i(int(dict.get("x", 0)), int(dict.get("y", 0)))
	var tilled: bool = bool(dict.get("is_tilled", false))
	var watered: bool = bool(dict.get("is_watered", false))
	var c: CropState = null
	if dict.has("crop") and dict["crop"] is Dictionary:
		c = CropState.from_dictionary(dict["crop"])
	return SoilPlotState.new(coord, tilled, watered, c)
