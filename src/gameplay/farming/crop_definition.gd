class_name CropDefinition
extends Resource

## Data definition for crops in Underhallow.
## Data-driven crop lifecycle authoring per FB-001 & Invariant 8.

@export var id: StringName = &""
@export var display_name: String = ""
@export var seed_item_id: StringName = &""
@export var harvest_item_id: StringName = &""
@export var growth_stages: int = 3 # 0: Planted, 1: Growing, 2: Mature
@export var days_to_mature: int = 2 # Prototype tuning: 2 days of watered growth
@export var harvest_yield_min: int = 1
@export var harvest_yield_max: int = 2
@export var xp_reward_plant: int = 5
@export var xp_reward_harvest: int = 20
