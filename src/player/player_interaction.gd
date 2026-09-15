class_name PlayerInteraction
extends Area2D

## Handles contextual interaction queries for the player character.
## Detects nearby interactables within range and facing cone, and executes interaction hooks.
## Aligned with IA-001 Section 6 & 21 (player_interaction.gd).

signal interactable_focused(interactable: Node)
signal interactable_unfocused()
signal interaction_executed(interactable: Node)

## Prototype tuning values (Tier B)
@export var interaction_range: float = 28.0

var current_target: Node = null
var _nearby_interactables: Array[Node] = []

func _ready() -> void:
	# Configure collision detection for interactables
	collision_layer = 0
	collision_mask = 2 # Mask 2 dedicated for Interactables
	monitoring = true
	monitorable = false
	
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_area_entered(area: Area2D) -> void:
	if _is_interactable(area) and not _nearby_interactables.has(area):
		_nearby_interactables.append(area)
		_update_best_target()

func _on_area_exited(area: Area2D) -> void:
	if _nearby_interactables.has(area):
		_nearby_interactables.erase(area)
		_update_best_target()

func _on_body_entered(body: Node2D) -> void:
	if _is_interactable(body) and not _nearby_interactables.has(body):
		_nearby_interactables.append(body)
		_update_best_target()

func _on_body_exited(body: Node2D) -> void:
	if _nearby_interactables.has(body):
		_nearby_interactables.erase(body)
		_update_best_target()

func _is_interactable(node: Node) -> bool:
	return node.is_in_group("interactable") or node.has_method("interact")

## Updates the best contextual target based on distance and player's facing direction.
func update_facing(facing_vector: Vector2) -> void:
	# Adjust the detector orientation or evaluate dot product
	_update_best_target(facing_vector)

func _update_best_target(facing_vector: Vector2 = Vector2.ZERO) -> void:
	# Clean up any freed nodes
	_nearby_interactables = _nearby_interactables.filter(func(n: Node) -> bool: return is_instance_valid(n))
	
	if _nearby_interactables.is_empty():
		if current_target != null:
			current_target = null
			interactable_unfocused.emit()
		return
	
	var best_node: Node = null
	var best_score: float = -99999.0
	var my_pos: Vector2 = global_position
	
	for candidate: Node in _nearby_interactables:
		var candidate_node2d: Node2D = candidate as Node2D
		if candidate_node2d == null:
			continue
		
		var to_candidate: Vector2 = candidate_node2d.global_position - my_pos
		var dist: float = to_candidate.length()
		if dist > interaction_range:
			continue
		
		# Score based on distance (closer is better) and facing alignment (higher dot is better)
		var score: float = -dist
		if facing_vector != Vector2.ZERO and dist > 0.001:
			var dot: float = facing_vector.dot(to_candidate.normalized())
			score += dot * 20.0 # Weight facing alignment
		
		if score > best_score:
			best_score = score
			best_node = candidate
	
	if best_node != current_target:
		current_target = best_node
		if current_target != null:
			interactable_focused.emit(current_target)
		else:
			interactable_unfocused.emit()

## Triggers interaction on the currently focused target.
## Returns true if an interaction was executed.
func trigger_interaction(player: Node) -> bool:
	_update_best_target()
	if current_target == null:
		return false
	
	if current_target.has_method("interact"):
		current_target.interact(player)
		interaction_executed.emit(current_target)
		return true
	
	return false
