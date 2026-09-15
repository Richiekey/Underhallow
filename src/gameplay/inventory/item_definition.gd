class_name ItemDefinition
extends Resource

## Data definition for items in Underhallow.
## Data-driven content authoring per IA-001 Section 3.5 & Invariant 8.

enum ItemCategory {
	TOOL,
	SEED,
	CROP,
	RESOURCE
}

@export var id: StringName = &""
@export var display_name: String = ""
@export var category: ItemCategory = ItemCategory.RESOURCE
@export var max_stack: int = 99
@export var description: String = ""
