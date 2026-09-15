class_name FarmingGrid
extends RefCounted

## Authoritative logical farming grid for Underhallow.
## Defines permissible farm plots and coordinate bounds per PH4-001 & PH4-FIX-001.
## Single authoritative source of truth for farming boundary validation.
## Completely decoupled from visual node hierarchies.

## Prototype bounds (Tier B tuning: 4 columns x 3 rows = 12 plantable cells)
const MIN_X: int = 0
const MAX_X: int = 3
const MIN_Y: int = 0
const MAX_Y: int = 2

## Returns true if and only if grid_coord is within the authoritative farming boundaries.
static func is_valid_cell(coord: Vector2i) -> bool:
	return coord.x >= MIN_X and coord.x <= MAX_X and coord.y >= MIN_Y and coord.y <= MAX_Y

## Prototype origin & spacing on Personal Island homestead clearing
const GRID_ORIGIN: Vector2 = Vector2(-130.0, 20.0)
const CELL_SPACING_X: float = 16.0
const CELL_SPACING_Y: float = 15.0

static func get_cell_world_position(coord: Vector2i) -> Vector2:
	return GRID_ORIGIN + Vector2(float(coord.x) * CELL_SPACING_X, float(coord.y) * CELL_SPACING_Y)
