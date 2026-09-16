class_name BuildingDefinition
extends Resource

## Data definition for constructible structures, fences, and paths in Underhallow.
## Data-driven content authoring per BI-001 & Invariant 8.

@export var id: StringName = &""
@export var display_name: String = ""
@export var category: String = "Structure"
@export var material_requirements: Dictionary = {}
@export var footprint: Vector2i = Vector2i(1, 1)
@export var description: String = ""
