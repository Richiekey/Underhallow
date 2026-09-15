class_name CropState
extends RefCounted

## Authoritative domain state for a single growing crop instance.
## Data-only, zero rendering dependencies.

var crop_id: StringName = &""
var growth_stage: int = 0 # 0: Planted, 1: Growing, 2: Mature
var days_grown: int = 0
var is_mature: bool = false

func _init(p_crop_id: StringName = &"", p_stage: int = 0, p_days: int = 0, p_mature: bool = false) -> void:
	crop_id = p_crop_id
	growth_stage = maxi(0, p_stage)
	days_grown = maxi(0, p_days)
	is_mature = p_mature

func to_dictionary() -> Dictionary:
	return {
		"crop_id": str(crop_id),
		"growth_stage": growth_stage,
		"days_grown": days_grown,
		"is_mature": is_mature
	}

static func from_dictionary(dict: Dictionary) -> CropState:
	var id: StringName = StringName(str(dict.get("crop_id", "")))
	var stage: int = int(dict.get("growth_stage", 0))
	var days: int = int(dict.get("days_grown", 0))
	var mature: bool = bool(dict.get("is_mature", false))
	return CropState.new(id, stage, days, mature)
