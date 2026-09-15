class_name SignpostController
extends StaticBody2D

## Controller for Signpost scene.
## Forwards inspection text and prompt to child InspectableSign.

@export_multiline var inspect_text: String = "A weathered wooden signpost."
@export var prompt_text: String = "Read"
@export var interaction_name: String = "Signpost"

@onready var sign_interactable: InspectableSign = $SignInteractable

func _ready() -> void:
	if sign_interactable != null:
		sign_interactable.inspect_text = inspect_text
		sign_interactable.prompt_text = prompt_text
		sign_interactable.interaction_name = interaction_name
