class_name TravelDock
extends InteractableObject

## Specialized interactable dock that requests world transition via WorldSpace.
## Implements physical travel point between Personal Island and Main Island.
## Aligned with IA-001 Section 6 & 21 and Phase 3 specifications.

@export_file("*.tscn") var destination_scene_path: String = ""
@export var destination_marker_name: String = "DockArrivalMarker"

func interact(player: Node) -> void:
	super.interact(player)
	
	# Find enclosing WorldSpace and issue travel request
	var world_space: WorldSpace = _find_parent_world_space()
	if world_space != null and not destination_scene_path.is_empty():
		world_space.request_travel(destination_scene_path, destination_marker_name)
	else:
		print("[TravelDock] Interacted with dock, destination: ", destination_scene_path)

func _find_parent_world_space() -> WorldSpace:
	var curr: Node = get_parent()
	while curr != null:
		if curr is WorldSpace:
			return curr
		curr = curr.get_parent()
	return null
