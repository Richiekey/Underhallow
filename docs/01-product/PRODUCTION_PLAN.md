# UNDERHALLOW

## Production Plan & Roadmap V1.0

**Project:** Underhallow  
**Document:** Production Plan & Vertical Slice Roadmap  
**Version:** 1.0  
**Status:** Baseline Implementation Roadmap (Layer 5)  
**Parent Documents:**  
- [Underhallow North Star V1.0 (NS-001)](file:///c:/Users/HP/Documents/Underhallow/docs/01-product/NORTH_STAR.md)  
- [Underhallow Foundation Specification V1.0 (FS-001)](file:///c:/Users/HP/Documents/Underhallow/docs/01-product/FOUNDATION_SPECIFICATION.md)  
- [Specification Reconciliation V1.0 (SR-001)](file:///c:/Users/HP/Documents/Underhallow/docs/00-governance/SPECIFICATION_RECONCILIATION.md)  
- [Engine & Technical Architecture Specification V1 (ETA-001)](file:///c:/Users/HP/Documents/Underhallow/docs/02-architecture/ENGINE_TECHNICAL_ARCHITECTURE_SPECIFICATION.md)  
- [Multiplayer & Social Systems Specification V1.0 (MS-001)](file:///c:/Users/HP/Documents/Underhallow/docs/07-multiplayer/MULTIPLAYER_SOCIAL_SYSTEMS_SPECIFICATION.md)  
- [Underhallow Agent Constitution V1.0 (AC-001)](file:///c:/Users/HP/Documents/Underhallow/docs/00-governance/AGENT_CONSTITUTION.md)  

---

# 0. Purpose & Phased Strategy

The Production Plan defines **what gets built, in what exact sequence, and how each milestone is verified** before progressing to the next.

In accordance with **ETA-001** and **Foundation Spec Section 51**, development proceeds vertically rather than horizontally, using Godot on Windows PC as the primary engine.

---

# 1. Master Phase Roadmap

```text
PHASE 0: TOOLCHAIN & GODOT SCAFFOLDING
  ├── Godot 4.x project configuration (project.godot, .editorconfig, .gitignore)
  ├── Domain directory structure (src/core/, src/world/, src/rendering/, src/network/, etc.)
  └── GUT (Godot Unit Test) framework & CI headless test runner
       │
       ▼
PHASE 1: RENDERING & WORLD PROTOTYPE (THE VISUAL GATE)
  ├── 2:1 Dimetric Isometric coordinate transform (world <-> screen)
  ├── Godot TileMapLayer system (isometric tile rendering & layer management)
  ├── Y-sort depth engine (Y/Z depth layering for player, trees, buildings, props)
  ├── Player controller (WASD/Arrow keys, continuous movement, collision boundaries)
  ├── Fixed isometric camera with smooth zoom & integer pixel-art scaling
  └── PROTOTYPE GATE EVALUATION (ETA-001 Section 45)
       │
       ▼
PHASE 2: CORE RUNTIME & STATE SIMULATION
  ├── Decoupled GameState & PlayerState (truth vs representation)
  ├── Deterministic GameTime simulation clock (Day, Hour, Minute ticks)
  ├── Centralized InputManager & Event Signals
  └── Spatial Interaction Raycast/Probe (E key contextual interaction)
       │
       ▼
PHASE 3: DUAL-WORLD & PERSONAL ISLAND
  ├── Main Island Town Square map slice
  ├── Personal Island Starter Grid & Cabin
  ├── Guild Island persistent template & harbor
  └── Harbor Ferry skiff scene transition
       │
       ▼
PHASE 4: FIRST VERTICAL SLICE (CORE PLAYABLE LOOP)
  ├── Farming System: Hoe tilling, watering, seed planting, growth stages, harvest
  ├── Hunting System: Creature tracking, ranged/melee attacks, non-lethal defeat, harvest
  ├── Inventory System: Hotbar (1-8), slot stacking, item data registry (no stamina meter)
  ├── Building System: Path & fence tile-snapping placement, structure ghosting
  ├── Multiplayer Foundation: Dedicated server loop, 2-player co-op test, party formation
  ├── Narrative Slice: Clementine NPC dialogue & first objective
  └── Persistence: Local save & Supabase cloud state round-trip
       │
       ▼
PHASE 5: HUMAN QA & VERTICAL SLICE SUCCESS TEST
```

---

# 2. Phase 0: Toolchain & Repository Scaffolding (Immediate)

### Deliverables:
1. `project.godot` configured for Windows PC target per [ETA-001](file:///c:/Users/HP/Documents/Underhallow/docs/02-architecture/ENGINE_TECHNICAL_ARCHITECTURE_SPECIFICATION.md):
   - Pixel-art display settings with integer scaling per [ETA-001](file:///c:/Users/HP/Documents/Underhallow/docs/02-architecture/ENGINE_TECHNICAL_ARCHITECTURE_SPECIFICATION.md).
   - Default input action bindings (`move_up`, `move_down`, `move_left`, `move_right`, `interact`, `use_tool`, `cancel`) per [PC-001](file:///c:/Users/HP/Documents/Underhallow/docs/03-gameplay/PLAYER_CONTROL_MOVEMENT_INTERACTION_SPECIFICATION.md).
2. GUT (Godot Unit Testing) addon installed in `addons/gut/` for automated unit/integration test suites.
3. Directory tree conforming to **ETA-001 Section 17**:
   - `src/core/` (GameTime, state, signals)
   - `src/world/` (tilemaps, islands, regions)
   - `src/player/` (controller, camera, interaction)
   - `src/systems/` (farming, hunting, building, inventory)
   - `src/network/` (dedicated server, client RPCs, party, trade)
   - `src/data/` (resource definitions for items, crops, creatures)
4. Headless automated smoke test (`godot --headless -s addons/gut/gut_cmdln.gd`) verifying clean boot.

---

# 3. Phase 1: Rendering & World Prototype (The Visual Gate)

The goal of Phase 1 is to answer the **6 Prototype Gate Questions**:
1. **Visual:** Does this actually look and feel like Underhallow?
2. **Technical:** Does the Godot renderer achieve a solid, stable 60 FPS with integer pixel-art scaling?
3. **Movement:** Does continuous 8-directional movement feel responsive, fluid, and comfortable?
4. **Camera:** Does the fixed isometric perspective feel natural with zoom controls (rotation disabled)?
5. **Depth:** Do buildings, trees, and characters sort cleanly via Y-sort without visual clipping?
6. **Art scale:** Does the character size feel harmonious relative to the environment and structures?

### Technical Components:
- Coordinate conversions between world, tile, and screen coordinates per [ETA-001](file:///c:/Users/HP/Documents/Underhallow/docs/02-architecture/ENGINE_TECHNICAL_ARCHITECTURE_SPECIFICATION.md).
- TileMapLayer management for terrain, paths, foliage, and structures.
- Continuous isometric movement controller with collision detection per [PC-001](file:///c:/Users/HP/Documents/Underhallow/docs/03-gameplay/PLAYER_CONTROL_MOVEMENT_INTERACTION_SPECIFICATION.md).
- Camera2D with fixed isometric angle, smooth tracking, and clamped zoom tiers (camera rotation disabled per [SR-001](file:///c:/Users/HP/Documents/Underhallow/docs/00-governance/SPECIFICATION_RECONCILIATION.md)).
- Mock Environment: Isometric grass terrain, cobblestone path, rustic cabin, oak trees, and animated player sprite.

---

# 4. Phase 2: Core Runtime & State Architecture

### Deliverables:
- Authoritative serializable state models per [ETA-001](file:///c:/Users/HP/Documents/Underhallow/docs/02-architecture/ENGINE_TECHNICAL_ARCHITECTURE_SPECIFICATION.md):
  - `PlayerState` (position, direction, health, inventory, progression — strictly no stamina meter).
  - `WorldState` (current_island_id, modified_tiles, placed_objects).
  - `TimeState` (day, hour, minute, tick_count).
- Deterministic simulation clock dispatching minute/hour/day signals per [ETA-001](file:///c:/Users/HP/Documents/Underhallow/docs/02-architecture/ENGINE_TECHNICAL_ARCHITECTURE_SPECIFICATION.md).
- Strongly typed global event bus for system decoupling.
- Spatial interaction detector for contextual interactable entities in front of the player (E key) per [PC-001](file:///c:/Users/HP/Documents/Underhallow/docs/03-gameplay/PLAYER_CONTROL_MOVEMENT_INTERACTION_SPECIFICATION.md).

---

# 5. Phase 3 & 4: The First Vertical Slice

Delivering the complete gameplay loop described in **Foundation Spec Section 51**:
```text
Wake up at Personal Island Homestead
       ↓
Check farm plot (till, plant carrot seed, water)
       ↓
Walk to Pier & take Barnaby's Skiff to Main Island
       ↓
Arrive at Town Square
       ↓
Talk to Clementine at General Store
       ↓
Gather wild berries in the edge forest & track a forest hare
       ↓
Ferry back to Personal Island
       ↓
Harvest mature crop & place rustic fence path
       ↓
Save Game (persist locally and sync to Supabase)
```

---

# 6. Verification & Quality Gates

Each phase ends with a formal review:
- **Automated Verification:** Headless GUT test suite executes with 0 failures (`--headless`).
- **Engine Performance Profiling:** Stable 60 FPS on target Windows PC hardware.
- **Human QA Evaluation:** Direct playtest against Foundation Spec Section 52 acceptance criteria.
