class_name DockPier
extends Node2D

## Wrapper for DockPier environment scene.
## Forwards destination scene path and marker name to child TravelDock.

@export_file("*.tscn") var destination_scene_path: String = ""
@export var destination_marker_name: String = "DockArrivalMarker"

@onready var dock_interactable: TravelDock = $DockInteractable

func _ready() -> void:
	if dock_interactable != null:
		dock_interactable.destination_scene_path = destination_scene_path
		dock_interactable.destination_marker_name = destination_marker_name
