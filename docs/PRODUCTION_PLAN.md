# UNDERHALLOW

## Production Plan & Roadmap V1.0

**Project:** Underhallow  
**Document:** Production Plan & Vertical Slice Roadmap  
**Version:** 1.0  
**Status:** Baseline Implementation Roadmap (Layer 5)  
**Parent Documents:**  
- [Underhallow North Star V1.0](file:///c:/Users/HP/Documents/Underhallow/docs/NORTH_STAR.md)  
- [Underhallow Foundation Specification V1.0](file:///c:/Users/HP/Documents/Underhallow/docs/FOUNDATION_SPECIFICATION.md)  
- [Underhallow Technical Architecture Specification V1.0](file:///c:/Users/HP/Documents/Underhallow/docs/TECHNICAL_ARCHITECTURE.md)  
- [Underhallow Agent Constitution V1.0](file:///c:/Users/HP/Documents/Underhallow/docs/AGENT_CONSTITUTION.md)  

---

# 0. Purpose & Phased Strategy

The Production Plan defines **what gets built, in what exact sequence, and how each milestone is verified** before progressing to the next.

In accordance with **Technical Architecture Section 50 & 100–103**, development proceeds vertically rather than horizontally.

---

# 1. Master Phase Roadmap

```text
PHASE 0: TOOLCHAIN & ARCHITECTURE SCAFFOLDING
  ├── Vite + TypeScript + Phaser 3 + Vitest setup
  ├── Domain directory structure (src/core/, src/world/, src/rendering/, etc.)
  └── TypeScript strict configuration & test runner
       │
       ▼
PHASE 1: RENDERING & WORLD PROTOTYPE (THE VISUAL GATE)
  ├── 2:1 Dimetric Isometric coordinate transform (world <-> screen)
  ├── Isometric tile rendering & layer system
  ├── Depth sorting engine (Y/Z depth layering for player, trees, props)
  ├── Player controller (WASD/Arrow keys, collision bounds)
  ├── Isometric camera follower & integer pixel-art scaling
  └── PROTOTYPE GATE EVALUATION (Section 101)
       │
       ▼
PHASE 2: CORE RUNTIME & STATE SIMULATION
  ├── Decoupled GameState & PlayerState (truth vs representation)
  ├── GameTime system (Day, Hour, Minute ticks)
  ├── Centralized InputManager & EventBus
  └── Spatial Interaction Raycast/Probe
       │
       ▼
PHASE 3: DUAL-WORLD & PERSONAL ISLAND
  ├── Main Island Town Square map slice
  ├── Personal Island Starter Grid & Cabin
  └── Harbor Ferry skiff scene transition
       │
       ▼
PHASE 4: FIRST VERTICAL SLICE (CORE PLAYABLE LOOP)
  ├── Farming System: Hoe tilling, watering, carrot seed planting, harvest
  ├── Inventory System: Hotbar (1-8), slot stacking, item registry
  ├── Building System: Path & fence tile-snapping placement
  ├── Narrative Slice: Clementine NPC dialogue & first objective
  └── Local Persistence: IndexedDB save & load round-trip
       │
       ▼
PHASE 5: HUMAN QA & VERTICAL SLICE SUCCESS TEST (Section 52)
```

---

# 2. Phase 0: Toolchain & Repository Scaffolding (Immediate)

### Deliverables:
1. `package.json` with dependencies:
   - `phaser` (Phaser 3.87+ for HTML5 WebGL/Canvas game runtime)
   - `typescript` (Strict type safety)
   - `vite` (Lightning-fast dev server & HMR)
   - `vitest` (High-speed unit & integration test runner)
2. `tsconfig.json` with strict mode, path aliases (`@core/*`, `@world/*`, `@rendering/*`, `@systems/*`, etc.).
3. `vite.config.ts` configured for pixel-art asset handling and game canvas packaging.
4. Clean initial directory tree conforming to **Tech Arch Section 76**.
5. Automated smoke test (`pnpm test` / `npm test`) verifying headless execution.

---

# 3. Phase 1: Rendering & World Prototype Specification (The Gate)

The goal of Phase 1 is to answer the **6 Prototype Gate Questions (Section 101)**:
1. **Visual:** Does this actually look like Underhallow?
2. **Technical:** Can the browser render the intended world at 60 FPS smoothly?
3. **Movement:** Does movement feel good and responsive in isometric space?
4. **Camera:** Does the isometric perspective feel natural?
5. **Depth:** Do buildings, trees, and characters layer correctly without clipping artifacts?
6. **Art scale:** Does the character size feel correct relative to the environment?

### Technical Components:
- **`src/rendering/iso/IsoMath.ts`**: Pure mathematical transforms:
  - `worldToScreen(x, y, z)`
  - `screenToWorld(screenX, screenY)`
  - `getTileIndex(x, y)`
- **`src/rendering/iso/DepthSort.ts`**: Depth sorting comparator:
  - `depth = (tileX + tileY) * 1000 + z * 10 + layerOffset`
- **`src/rendering/scenes/WorldScene.ts`**: Active Phaser Scene managing the tilemap, sprite groups, and render loop.
- **`src/player/movement/PlayerMovement.ts`**: 8-directional input converted to isometric movement vectors with normalized velocity.
- **Mock Environment:** Isometric grass terrain, cobblestone path, rustic cabin, oak trees, and player sprite with running/idle states.

---

# 4. Phase 2: Core Runtime & State Architecture

### Deliverables:
- **`src/core/state/GameState.ts`**: Pure serializable data model:
  - `PlayerState` (position, direction, health, energy, inventory)
  - `WorldState` (currentMapId, modifiedTiles, placedObjects)
  - `TimeState` (day, hour, minute, tickCount)
- **`src/core/time/GameClock.ts`**: Deterministic simulation clock with event dispatchers for time ticks and daily transitions.
- **`src/core/events/EventBus.ts`**: Strongly typed decoupled event bus.
- **`src/player/interaction/InteractionSystem.ts`**: Detects interactable targets facing the player.

---

# 5. Phase 3 & 4: The First Vertical Slice

Delivering the complete loop described in **Foundation Spec Section 51**:
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
Gather wild berries in the edge forest
       ↓
Ferry back to Personal Island
       ↓
Harvest mature crop & place rustic fence path
       ↓
Save Game (persist to IndexedDB)
```

---

# 6. Verification & Quality Gates

Each phase ends with a formal review:
- **Automated Verification:** `npm run build` and `npm test` pass with 0 errors.
- **Browser Profiling:** Stable 60 FPS in Chrome, Firefox, and Edge.
- **Human QA Evaluation:** Direct playtest against Section 52 criteria.
