class_name CreatureDefinition
extends Resource

## Data definition for huntable and ambient creatures in Underhallow.
## Data-driven content authoring per HU-001 & Invariant 8.

@export var id: StringName = &""
@export var display_name: String = ""
@export var max_health: int = 10
@export var harvest_item_id: StringName = &"resource_raw_hide"
@export var harvest_item_count: int = 1
@export var description: String = ""
