class_name HuntingState
extends RefCounted

## Authoritative domain state container for Hunting & Combat (HU-001).
## Strictly data-only. Zero rendering dependencies, zero scene-tree nodes.

func _init() -> void:
	reset()

func reset() -> void:
	pass

func to_dictionary() -> Dictionary:
	return {}

func from_dictionary(_dict: Dictionary) -> void:
	reset()
