class_name ProgressionState
extends RefCounted

## Authoritative domain state container for player skill progression.
## Tracks Farming XP and level in Phase 4 per PR-001 & PH4-001.
## Holds authoritative state for Clementine's introductory narrative objective.

signal farming_xp_gained(amount: int, total_xp: int)
signal farming_leveled_up(new_level: int)
signal clementine_objective_state_changed(new_state: int)

enum ClementineObjectiveState {
	INACTIVE = 0,
	ACTIVE = 1,
	COMPLETED = 2
}

var farming_xp: int = 0
var farming_level: int = 1
var clementine_objective_state: int = ClementineObjectiveState.INACTIVE
var clementine_reward_granted: bool = false

func _init() -> void:
	reset()

func reset() -> void:
	farming_xp = 0
	farming_level = 1
	clementine_objective_state = ClementineObjectiveState.INACTIVE
	clementine_reward_granted = false

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

func is_clementine_objective_active() -> bool:
	return clementine_objective_state == ClementineObjectiveState.ACTIVE

func is_clementine_objective_completed() -> bool:
	return clementine_objective_state == ClementineObjectiveState.COMPLETED

## Authoritative check for Clementine objective completion requirements:
## 1. At least 3 Wild Berries in inventory.
## 2. At least 1 Raw Hide in inventory.
## 3. If hunting state has registered creatures, at least one forest hare must be harvested.
func can_complete_clementine_objective(inventory: InventoryState, hunting: HuntingState = null) -> bool:
	if inventory == null:
		return false
	if inventory.get_quantity(&"resource_wild_berries") < 3:
		return false
	if inventory.get_quantity(&"resource_raw_hide") < 1:
		return false
	
	if hunting != null:
		var creatures: Dictionary = hunting.get_all_creatures()
		var has_hares: bool = false
		var hare_harvested: bool = false
		for c: Variant in creatures.values():
			var creature: CreatureState = c as CreatureState
			if creature != null and creature.definition_id == &"hare":
				has_hares = true
				if creature.is_harvested:
					hare_harvested = true
					break
		if has_hares and not hare_harvested:
			return false
	
	return true

func to_dictionary() -> Dictionary:
	return {
		"farming_xp": farming_xp,
		"farming_level": farming_level,
		"clementine_objective_state": clementine_objective_state,
		"clementine_reward_granted": clementine_reward_granted
	}

func from_dictionary(dict: Dictionary) -> void:
	farming_xp = maxi(0, int(dict.get("farming_xp", 0)))
	farming_level = maxi(1, int(dict.get("farming_level", 1)))
	clementine_objective_state = int(dict.get("clementine_objective_state", ClementineObjectiveState.INACTIVE))
	clementine_reward_granted = bool(dict.get("clementine_reward_granted", false))
