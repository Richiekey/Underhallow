class_name InteractableObject
extends Area2D

## Base interactable area for interactive world objects.
## Aligned with IA-001 Section 5 (src/gameplay/interaction/).

signal interacted(by_player: Node)

@export var prompt_text: String = "Inspect"
@export var interaction_name: String = "Sign"

func _ready() -> void:
	add_to_group("interactable")
	# Collision Layer 2 is dedicated for interactable detection
	collision_layer = 2
	collision_mask = 0
	monitoring = false
	monitorable = true

func interact(player: Node) -> void:
	interacted.emit(player)
