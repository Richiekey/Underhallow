class_name WorldSpace
extends Node2D

## Thin interface for world scenes in Underhallow.
## Holds world identity and provides spawn/arrival marker lookups.
## Keeps world scenes decoupled without introducing an overengineered world framework.

signal travel_requested(destination_world: String, arrival_marker: String)

@export var world_id: StringName = &"personal_island"
@export var display_name: String = "Personal Island"

## Finds a Marker2D by name within the world scene.
## Falls back to Vector2.ZERO if not found.
func get_marker_position(marker_name: String) -> Vector2:
	var node: Node = find_child(marker_name, true, false)
	if node is Node2D:
		return node.global_position
	return global_position

## Requests world transition to a destination scene
func request_travel(destination_scene_path: String, destination_marker_name: String) -> void:
	travel_requested.emit(destination_scene_path, destination_marker_name)
