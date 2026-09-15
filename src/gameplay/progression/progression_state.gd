class_name ProgressionState
extends RefCounted

## Authoritative domain state container for player skill progression.
## Tracks Farming XP and level in Phase 4 per PR-001 & PH4-001.

signal farming_xp_gained(amount: int, total_xp: int)
signal farming_leveled_up(new_level: int)

var farming_xp: int = 0
var farming_level: int = 1

func _init() -> void:
	reset()

func reset() -> void:
	farming_xp = 0
	farming_level = 1

## Adds farming XP and recalculates level. Returns true if leveled up.
func add_farming_xp(amount: int) -> bool:
	if amount <= 0:
		return false
	
	farming_xp += amount
	farming_xp_gained.emit(amount, farming_xp)
	
	var new_lvl: int = _calculate_level_for_xp(farming_xp)
	if new_lvl > farming_level:
		farming_level = new_lvl
		farming_leveled_up.emit(farming_level)
		return true
	return false

## Prototype Level Formula (Tier B Tuning)
## Level 1: 0-49 XP
## Level 2: 50-119 XP
## Level 3: 120-209 XP
## Level 4: 210+ XP
func _calculate_level_for_xp(xp: int) -> int:
	if xp >= 210:
		return 4
	elif xp >= 120:
		return 3
	elif xp >= 50:
		return 2
	return 1

func to_dictionary() -> Dictionary:
	return {
		"farming_xp": farming_xp,
		"farming_level": farming_level
	}

func from_dictionary(dict: Dictionary) -> void:
	farming_xp = maxi(0, int(dict.get("farming_xp", 0)))
	farming_level = maxi(1, int(dict.get("farming_level", 1)))
