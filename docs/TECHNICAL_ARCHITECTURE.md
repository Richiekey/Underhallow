# UNDERHALLOW

## Technical Architecture Specification V1.0

**Project:** Underhallow  
**Document:** Technical Architecture Specification  
**Version:** 1.0  
**Status:** Foundation Architecture Baseline  
**Parent Documents:** Underhallow North Star V1.0, Underhallow Foundation Specification V1.0  
**Initial Platform:** Browser  
**Initial Game Mode:** Single-player  
**Architecture Goal:** Build a maintainable, data-driven, agent-friendly game foundation that can grow substantially without requiring a rewrite.  

---

# 0. Purpose

The Technical Architecture Specification defines **how Underhallow will be built**.

The Foundation Specification defines the systems Underhallow needs.

This document defines:

* Technology choices
* Runtime architecture
* Repository structure
* World representation
* Isometric rendering
* Entity architecture
* Game-state architecture
* Player architecture
* NPC architecture
* Farming architecture
* Combat architecture
* Building architecture
* Inventory architecture
* Quest architecture
* Persistence
* Asset pipeline
* UI
* Audio
* Testing
* Performance
* Security boundaries
* AI-agent development boundaries
* Future multiplayer/Web3 compatibility

The central architectural principle is:

> **Underhallow should be simple enough for AI agents to work on safely, but structured enough to survive years of expansion.**

---

# 1. Architecture Principles

## 1.1 Build for the current game, not the hypothetical final game

We will not build MMO infrastructure, blockchain infrastructure or distributed game servers before the game requires them.

The architecture should leave reasonable extension points, but unnecessary complexity is rejected.

---

## 1.2 Data-driven over hardcoded

Game content should be represented as data wherever practical.

For example, a crop should be defined by data:

```text
Crop
├── ID
├── Name
├── Growth stages
├── Growth duration
├── Seed item
├── Harvest item
├── Yield
├── Farming XP
└── Visual assets
```

rather than requiring a new custom code implementation for every crop.

The same philosophy applies to:

* Items
* NPCs
* Creatures
* Buildings
* Crops
* Quests
* Dialogue
* Recipes
* Resources
* Equipment

---

# 2. Recommended Technology Stack

## 2.1 Game Engine

### **Phaser 3**

Phaser is the recommended game runtime.

It is well suited to:

* Browser games
* 2D rendering
* Pixel art
* Sprite animation
* Tilemaps
* Input
* Cameras
* Physics
* Scene management
* Audio
* Web deployment

It also keeps the project fundamentally web-native.

---

# 2.2 Language

### **TypeScript**

Underhallow should be written in TypeScript rather than plain JavaScript.

Reasons:

* Stronger contracts between systems
* Safer refactoring
* Better agent-generated code
* Easier debugging
* Better IDE support
* Explicit data structures
* Compile-time detection of many mistakes

TypeScript strict mode should be enabled.

---

# 2.3 Build Tool

### **Vite**

Vite will handle:

* Development server
* TypeScript compilation pipeline
* Asset bundling
* Production builds
* Environment configuration

---

# 2.4 World Editor

### **Tiled**

Tiled should be the preferred world/map authoring tool.

The world should not be constructed by manually positioning thousands of objects in code.

Tiled provides a visual workflow for:

* Maps
* Layers
* Tiles
* Collision information
* Object placement
* Regions
* Spawn points
* Interactive objects
* Metadata

The exact export/loading pipeline will be established during implementation.

---

# 2.5 Pixel Art Pipeline

### **Aseprite**

Aseprite is the preferred source-authoring tool for pixel assets.

It will be used for:

* Character sprites
* Animation
* Tilesets
* Environment assets
* Objects
* Effects
* Sprite sheets

The game runtime should consume exported assets rather than Aseprite project files directly.

---

# 2.6 Backend

### **Supabase**

Supabase is the preferred backend foundation for persistent player data.

Initial responsibilities:

* Authentication
* Player accounts
* Cloud saves
* Player profile data
* Future analytics data
* Future social data

The game should **not depend on Supabase for every frame of gameplay**.

Gameplay should continue locally.

---

# 2.7 Database

### PostgreSQL through Supabase

Persistent game data will use PostgreSQL.

However:

> **The database is a persistence layer, not the game engine.**

The game simulation should not constantly query PostgreSQL.

---

# 2.8 Initial Deployment

The browser client can be deployed through a modern static/web hosting platform.

The deployment system should support:

* HTTPS
* Asset caching
* Versioned builds
* Environment variables
* Production/preview environments

The exact provider can be finalized during repository setup.

---

# 3. High-Level Runtime Architecture

Underhallow should follow this conceptual architecture:

```text
                        BROWSER
                           │
                           ▼
                    UNDERHALLOW CLIENT
                           │
        ┌──────────────────┼──────────────────┐
        │                  │                  │
        ▼                  ▼                  ▼
    Rendering           Gameplay          Interface
        │                  │                  │
        └──────────────────┼──────────────────┘
                           │
                           ▼
                     Game State
                           │
              ┌────────────┴────────────┐
              │                         │
              ▼                         ▼
        Local Persistence          Cloud Persistence
              │                         │
              └────────────┬────────────┘
                           ▼
                       Supabase
```

The game client remains the center of the initial experience.

---

# 4. Core Architectural Layers

Underhallow should be separated into logical layers.

```text
┌────────────────────────────────────┐
│              UI Layer              │
├────────────────────────────────────┤
│          Presentation Layer        │
│       Phaser / Rendering / Audio   │
├────────────────────────────────────┤
│          Gameplay Systems          │
│ Farming / Combat / Building / etc.│
├────────────────────────────────────┤
│          Domain / Game State       │
│ Player / World / Items / Quests    │
├────────────────────────────────────┤
│          Persistence Layer         │
│ Local Save / Cloud Save / Sync     │
├────────────────────────────────────┤
│          Infrastructure            │
│ Browser / Supabase / Networking    │
└────────────────────────────────────┘
```

A major goal is to prevent rendering code from becoming the source of truth for gameplay.

---

# 5. Source of Truth Principle

The Phaser scene should **not** be the authoritative representation of important game state.

For example:

Bad:

```text
Sprite position = player's saved position
Sprite health = player's actual health
```

Better:

```text
PlayerState
    ↓
Gameplay systems
    ↓
Presentation
    ↓
Phaser sprite
```

The sprite represents the player.

It does not *define* the player.

This distinction becomes extremely important as the game grows.

---

# 6. Domain State

The core game state should be represented independently from the renderer.

Conceptually:

```text
GameState
│
├── PlayerState
├── WorldState
├── IslandState
├── InventoryState
├── QuestState
├── NPCState
├── FarmingState
├── BuildingState
├── CombatState
├── ProgressionState
└── SessionState
```

Individual systems operate on the appropriate portions of this state.

---

# 7. Game Session

The runtime should have a clear concept of a game session.

```text
Boot
 ↓
Load assets
 ↓
Load game data
 ↓
Load save
 ↓
Initialize world
 ↓
Start session
 ↓
Gameplay
 ↓
Save
 ↓
Exit / suspend
```

This prevents initialization logic from being scattered across dozens of scenes.

---

# 8. Phaser Scene Architecture

Phaser Scenes should represent **major presentation/game contexts**, not every gameplay mechanic.

Initial conceptual scenes:

```text
BootScene
    ↓
PreloadScene
    ↓
MainMenuScene
    ↓
WorldScene
    ↓
Pause/UI overlays
```

The exact scene structure may evolve.

We should avoid creating a separate Phaser Scene for every system.

For example:

> Farming should be a gameplay system inside the world, not `FarmingScene`.

---

# 9. World Architecture

The world consists of:

```text
World
│
├── Main Island
│   ├── Town
│   ├── Wilderness
│   ├── Forest
│   ├── Coast
│   └── Other regions
│
└── Personal Island
    ├── House
    ├── Farm
    ├── Buildings
    ├── Grids
    └── Decorations
```

Each world space should be represented through structured world data.

---

# 10. World Data vs Runtime Objects

We distinguish:

### World Definition

Static information:

* Terrain
* Map layout
* Spawn points
* NPC locations
* Object definitions
* Regions

from:

### World Runtime State

Dynamic information:

* Crop growth
* Open/closed state
* Player modifications
* NPC state
* Discovered locations
* Temporary events

This distinction is mandatory.

---

# 11. Map Architecture

Maps should be authored externally and loaded into the game.

A map may contain:

```text
Terrain Layer
Collision Layer
Decoration Layer
Object Layer
Region Layer
Interaction Layer
Spawn Layer
Metadata
```

The exact Tiled layer naming convention will be established as part of the implementation contract.

---

# 12. Isometric Coordinate System

Underhallow uses an isometric presentation.

We must therefore maintain a strict distinction between:

### World coordinates

The logical position of an object.

```text
worldX
worldY
```

and:

### Screen coordinates

Where the object appears on screen.

```text
screenX
screenY
```

The renderer performs the conversion.

Conceptually:

```text
World Position
      ↓
Isometric Projection
      ↓
Screen Position
      ↓
Camera Transform
      ↓
Rendered Position
```

Gameplay systems should generally operate in world coordinates.

---

# 13. Isometric Grid

The world should use a logical grid even when visual assets appear more complex.

The grid provides:

* Consistent placement
* Collision
* Farming areas
* Building placement
* Pathfinding
* Object positioning
* Map editing

The exact tile dimensions remain an implementation decision to be validated during the first rendering prototype.

---

# 14. Depth Sorting

Isometric environments require depth ordering.

Objects should be sorted according to their world-space depth rather than simply their creation order.

Potential objects affected include:

* Player
* NPCs
* Trees
* Buildings
* Walls
* Props
* Crops
* Creatures

The architecture must provide a centralized depth-sorting mechanism.

Individual systems should not manually manipulate render depth.

---

# 15. Layers

The renderer should conceptually separate:

```text
Ground
Ground Details
Interactive Objects
Characters
Structures
Foreground
Effects
UI
```

The actual Phaser implementation can differ, but the visual hierarchy must remain explicit.

---

# 16. Player Architecture

The player consists of multiple concerns:

```text
Player
│
├── Identity
├── Position
├── Movement
├── Interaction
├── Health
├── Skills
├── Level
├── Inventory
├── Equipment
├── Quest state
├── Animation state
└── Progression
```

These should not become one giant player class.

---

# 17. Player Controller

The player controller handles:

* Input
* Movement intent
* Movement execution
* Collision
* Interaction requests

It should **not** directly implement:

* Farming
* Dialogue
* Quest progression
* Inventory persistence
* Building logic

Those belong to their respective systems.

---

# 18. Input Architecture

Input should be centralized.

Conceptually:

```text
Keyboard / Mouse / Controller
             ↓
        Input Manager
             ↓
       Input Commands
             ↓
        Game Systems
```

This prevents individual systems from directly binding arbitrary keyboard events.

It also makes future controller/mobile support easier.

---

# 19. Interaction Architecture

Interaction should be centralized.

Conceptually:

```text
Player
  ↓
Interaction Range
  ↓
Interactable Target
  ↓
Interaction System
  ↓
Target-specific action
```

Objects expose what interactions they support.

Examples:

```text
NPC
→ Talk

Crop
→ Harvest

Door
→ Enter

Chest
→ Open

Resource
→ Gather
```

This prevents every object from implementing unrelated interaction mechanics.

---

# 20. Entity Architecture

We will use a **lightweight entity/system architecture**, not a full ECS framework unless future requirements prove one necessary.

An entity can conceptually be:

```text
Entity
├── ID
├── Transform
├── Components / State
└── Tags
```

Systems operate on relevant entities.

We should avoid adopting a complex ECS purely because it sounds architecturally sophisticated.

---

# 21. Gameplay Systems

Gameplay systems should be modular.

Initial systems include:

```text
MovementSystem
InteractionSystem
FarmingSystem
InventorySystem
BuildingSystem
CombatSystem
NPCSystem
QuestSystem
DialogueSystem
ProgressionSystem
TimeSystem
SaveSystem
```

Systems should communicate through defined state changes and events where useful.

---

# 22. Event Architecture

A lightweight internal event system should allow systems to react to important game events.

Examples:

```text
PLAYER_MOVED
ITEM_COLLECTED
CROP_PLANTED
CROP_HARVESTED
NPC_TALKED
QUEST_COMPLETED
BUILDING_PLACED
ENEMY_DEFEATED
LEVEL_UP
GRID_UNLOCKED
```

Events should be used where they improve decoupling.

They should not replace ordinary function calls everywhere.

---

# 23. Farming Architecture

Farming should be data-driven.

Conceptually:

```text
Farm Plot
│
├── Soil state
├── Crop ID
├── Growth stage
├── Plant timestamp / game time
├── Water state
└── Harvest state
```

Crop definitions exist separately.

```text
Crop Definition
│
├── ID
├── Seed
├── Growth stages
├── Growth requirements
├── Harvest result
└── XP
```

This allows new crops to be added largely through data.

---

# 24. Farming Simulation

Crop progression should use **game time**, not real-time frame counting.

Bad:

```text
Every frame:
    cropTimer += delta
```

Better:

```text
Crop planted at GameTime X

Current GameTime - X
        ↓
Growth stage
```

This makes saving, loading and offline progression substantially easier.

---

# 25. Building Architecture

Building is divided into:

### Placement

Where can an object be placed?

### Validation

Is the placement legal?

### Construction

What resources/time are required?

### Persistence

How is the building saved?

### Presentation

How is the building rendered?

The building system should not be responsible for all five concerns inside one class.

---

# 26. Building Placement

The system should validate:

* Grid occupancy
* Terrain compatibility
* Collision
* Required resources
* Player permissions
* Building constraints

before committing a placement.

---

# 27. Personal Island Architecture

The personal island should be represented as persistent world state.

Conceptually:

```text
PersonalIsland
│
├── Island identity
├── Grid state
├── Terrain modifications
├── Buildings
├── Crops
├── Objects
├── Decorations
└── Player-specific state
```

The renderer creates the visual island from this state.

---

# 28. Island Grid Architecture

Each grid should have a stable identifier.

```text
Grid
├── ID
├── Coordinates
├── Unlock state
├── Terrain metadata
└── Contents
```

This gives us flexibility later to introduce:

* Different grid sizes
* Different terrain
* Special areas
* Unlock costs
* Economic mechanics

without changing the fundamental island architecture.

---

# 29. Inventory Architecture

Inventory is a core shared system.

It must support:

* Stackable items
* Non-stackable items
* Quantity
* Item metadata
* Equipment
* Quest items
* Future economic items

Conceptually:

```text
Inventory
├── Slot
│   ├── Item ID
│   ├── Quantity
│   └── Metadata
└── Capacity
```

---

# 30. Item Architecture

Items are data-defined.

A conceptual definition:

```text
ItemDefinition
├── ID
├── Name
├── Category
├── Description
├── Stackability
├── Base value
├── Icon
├── World representation
└── Usage rules
```

Runtime inventory entries should reference item definitions rather than duplicating the entire definition.

---

# 31. Equipment

Equipment should reference item definitions.

The initial architecture should support slots such as:

```text
Tool
Weapon
Utility
Future equipment categories
```

The exact equipment system is intentionally not fully specified yet.

---

# 32. Combat Architecture

Combat should remain simple.

The initial system consists conceptually of:

```text
Combatant
├── Health
├── Damage capability
├── Defense
├── Attack state
├── Targeting
└── Combat behavior
```

Combat should interact with the shared:

* Health system
* Inventory
* Items
* Progression
* Creature definitions

rather than implementing separate parallel systems.

---

# 33. Creature Architecture

Creatures should be data-driven.

```text
CreatureDefinition
├── ID
├── Name
├── Stats
├── Behavior
├── Movement
├── Drops
├── Habitat
└── Visual assets
```

This allows additional creatures to be introduced without creating bespoke architecture.

---

# 34. AI/Behavior Architecture

Creature and NPC behavior should use a lightweight behavior model initially.

Possible states:

```text
Idle
Roam
Work
Interact
Flee
Attack
Return
Sleep
```

The initial system should avoid sophisticated machine learning or LLM-controlled NPC behavior.

Traditional deterministic game AI is more appropriate.

---

# 35. NPC Architecture

NPC state should be separated from presentation.

Conceptually:

```text
NPC Definition
       +
NPC Runtime State
       ↓
NPC Simulation
       ↓
NPC Presentation
```

An NPC can therefore continue having a logical state independent of the visual sprite.

---

# 36. NPC Schedules

NPC schedules should be represented as data.

Example:

```text
Schedule
├── Time range
├── Location
├── Activity
└── Priority
```

The NPC simulation evaluates the schedule against game time.

This allows designers to change NPC routines without rewriting behavior code.

---

# 37. Dialogue Architecture

Dialogue should be data-driven.

Dialogue content should not be embedded throughout TypeScript files.

Conceptually:

```text
Dialogue
├── ID
├── Speaker
├── Conditions
├── Lines
├── Choices
├── Consequences
└── Next dialogue
```

This enables narrative agents to work on content without modifying gameplay code.

---

# 38. Quest Architecture

Quests should have structured definitions.

```text
Quest
├── ID
├── Type
├── Requirements
├── Objectives
├── Conditions
├── Rewards
├── Dialogue references
└── Completion effects
```

Quest state is stored separately from the definition.

---

# 39. Quest State

For example:

```text
QuestState
├── NotStarted
├── Active
├── Completed
└── Failed / Abandoned
```

Individual objectives should maintain their own progress.

---

# 40. Narrative State

The game should maintain a separate narrative state.

This can include:

* Story milestones
* Character relationships
* Discovered secrets
* Completed character arcs
* World-state flags

This becomes critical for the mystery.

For example:

```text
mystery_clue_01 = discovered
npc_relationship_07 = 3
story_arc_02 = active
location_secret_04 = unlocked
```

The exact schema will be defined later.

---

# 41. Time System

Underhallow should have a centralized game-time system.

Conceptually:

```text
Game Clock
│
├── Day
├── Time
├── Week / calendar
└── Future seasonal state
```

Other systems subscribe to game time.

For example:

```text
TimeSystem
 ↓
Farming
NPC schedules
World events
Creature behavior
Narrative events
```

No individual system should maintain its own incompatible clock.

---

# 42. Save Architecture

The save system should have three conceptual layers:

```text
Runtime State
      ↓
Serializable Game State
      ↓
Persistence Adapter
      ↓
Local / Cloud Storage
```

This makes the persistence mechanism replaceable.

---

# 43. Local Save

The browser should maintain a local save capability.

The exact technology should be validated during implementation, but **IndexedDB** is the preferred direction over simple localStorage because the game will eventually have substantially more state.

Local saves provide:

* Fast loading
* Offline capability
* Resilience
* Reduced backend dependency

---

# 44. Cloud Save

Cloud saves will eventually allow the player to persist progress across browsers/devices.

Supabase will provide the initial cloud persistence layer.

The architecture should not make cloud connectivity mandatory for every gameplay action.

---

# 45. Save Synchronization

Initial synchronization philosophy:

```text
Local Game State
      ↓
Save Serializer
      ↓
Local Save
      │
      └──── optional ────→ Cloud Save
```

Cloud synchronization should be explicit and robust.

We should avoid trying to merge arbitrary conflicting saves automatically until the conflict model is properly designed.

---

# 46. Save Versioning

Every persisted save should have a version.

Example:

```text
saveVersion: 1
```

Future versions can migrate:

```text
v1
 ↓
Migration
 ↓
v2
```

This is mandatory for a long-lived game.

Without save migrations, future updates can easily invalidate old player worlds.

---

# 47. Data Schema Versioning

Game definitions should also have versioning where appropriate.

The architecture must distinguish:

> **Game code version**

from:

> **Save data version**

from:

> **Content/data version**

This allows us to update Underhallow without unnecessarily invalidating existing worlds.

---

# 48. Asset Architecture

Assets should be organized by domain.

Conceptually:

```text
assets/
├── characters/
├── creatures/
├── environment/
├── tilesets/
├── buildings/
├── items/
├── crops/
├── effects/
├── ui/
├── audio/
└── fonts/
```

The actual repository structure may refine this.

---

# 49. Asset Naming

Asset naming must be deterministic.

Avoid:

```text
tree-final-final2.png
newTree.png
treeAIgenerated.png
```

Prefer:

```text
tree_oak_large.png
tree_oak_small.png
```

Names should communicate what the asset represents.

---

# 50. Sprite Sheets

Characters and animated objects should use standardized sprite-sheet conventions.

The exact dimensions are **not yet locked**.

We first need to validate the visual resolution and character scale through the rendering prototype.

Once selected, it becomes an art-pipeline invariant.

---

# 51. Pixel Rendering Rules

The browser renderer must preserve pixel-art integrity.

Important requirements:

* No unintended smoothing
* Correct texture filtering
* Consistent scaling
* Integer-friendly rendering where practical
* Stable sprite sampling

The game should never accidentally make carefully authored pixel art look blurry.

---

# 52. Resolution Strategy

The game should not immediately lock itself to a specific native pixel resolution.

Instead:

1. Establish visual scale.
2. Establish tile dimensions.
3. Establish character dimensions.
4. Establish camera scale.
5. Test browser rendering.
6. Lock the production resolution.

This is a deliberate prototype decision.

---

# 53. UI Architecture

UI should be separated from world rendering.

Conceptually:

```text
Game World
     │
     ├── Phaser world rendering
     │
     └── UI Layer
           ├── HUD
           ├── Inventory
           ├── Dialogue
           ├── Menus
           └── Progression
```

UI should not manipulate game state directly without going through appropriate gameplay/domain APIs.

---

# 54. UI State

UI should have its own state where necessary.

For example:

```text
InventoryOpen
DialogueActive
BuildModeActive
Paused
QuestPanelOpen
```

The game should understand these states rather than relying on random DOM visibility flags.

---

# 55. Audio Architecture

Audio should have centralized control.

Conceptually:

```text
AudioManager
├── Music
├── Ambient
├── SFX
├── UI
└── Future narrative audio
```

Gameplay systems request sounds.

They should not individually configure global audio settings.

---

# 56. Audio State

Audio should respond to world state.

Examples:

```text
Town
→ Town ambience

Forest
→ Forest ambience

Night
→ Night ambience

Mystery event
→ Altered atmosphere
```

This will eventually help create the contrast between Underhallow's cozy surface and hidden mystery.

---

# 57. Service Boundaries

External services should be accessed through adapters.

Bad:

```text
FarmingSystem → Supabase directly
```

Better:

```text
FarmingSystem
      ↓
Game State
      ↓
Save Service
      ↓
Persistence Adapter
      ↓
Supabase
```

This reduces vendor lock-in and makes testing easier.

---

# 58. Authentication

Authentication is not part of the core gameplay loop.

The architecture should allow:

```text
Anonymous/local session
        ↓
Optional account
        ↓
Cloud persistence
```

The exact authentication UX can be decided later.

The game should not greet a new player with a complicated account setup unless necessary.

---

# 59. Backend Security

Client-side game state must not automatically be treated as trustworthy once valuable economies or social systems exist.

For the initial single-player game, the client can own most gameplay simulation.

As soon as systems involve:

* Real economic value
* Trading
* Player-to-player transfers
* Competitive rankings
* Valuable assets

those systems require stronger server validation.

This is a future architectural boundary.

---

# 60. Future Multiplayer Boundary

We are **not implementing multiplayer now**.

However, the architecture should avoid assumptions such as:

```text
global singleton = only player
```

or:

```text
world state = hardcoded to one specific user
```

Instead:

```text
Player ID
World ID
Island ID
Entity ID
```

should be conceptually distinct.

This gives future multiplayer systems a cleaner migration path.

---

# 61. Future Multiplayer Authority

If multiplayer is introduced later, the architecture should be capable of evolving toward:

```text
                    GAME SERVER
                        │
              Authoritative State
                        │
             ┌──────────┴──────────┐
             ↓                     ↓
          Player A              Player B
             │                     │
             └─────────┬───────────┘
                       ↓
                    Clients
```

But this is **future architecture**, not a reason to build a dedicated authoritative server today.

---

# 62. Future Web3 Boundary

The core game must not depend on blockchain APIs.

Future architecture should look conceptually like:

```text
Game
 │
 ├── Traditional Game Economy
 │
 └── Optional Economic Integration
             │
             └── Blockchain Adapter
```

Blockchain should therefore be an adapter/integration boundary rather than the foundation of the gameplay engine.

---

# 63. Economy Architecture Boundary

The eventual economy will require stronger separation.

Potential future layers:

```text
Gameplay Economy
      ↓
Economic Rules
      ↓
Transaction Service
      ↓
Persistence
      ↓
Optional External Economy
```

This prevents the game's internal logic from becoming inseparable from financial infrastructure.

---

# 64. Analytics

Analytics should eventually measure:

* Player retention
* Session length
* Feature usage
* Progression
* Drop-off points
* Bugs
* Performance

However:

> Analytics must never become a gameplay dependency.

The game should remain playable if analytics services fail.

---

# 65. Error Handling

Game systems should fail gracefully.

For example:

If cloud save fails:

```text
Cloud save failed
       ↓
Preserve local save
       ↓
Notify player appropriately
       ↓
Retry later
```

We must never allow a temporary external service failure to destroy local player progress.

---

# 66. Logging

Development builds should provide structured logs.

Logs should identify:

* System
* Event
* Entity/player where relevant
* Severity
* Error details

Production logging should be controlled to avoid excessive browser overhead.

---

# 67. Testing Architecture

Testing will occur at multiple levels.

### Unit tests

For deterministic logic:

* Farming calculations
* Inventory
* Progression
* Quest conditions
* Grid validation
* Item operations

### Integration tests

For systems interacting:

* Farming + inventory
* Quest + NPC
* Building + inventory
* Save + game state

### End-to-end tests

For major player flows:

```text
Start game
→ Move
→ Interact
→ Farm
→ Harvest
→ Save
→ Reload
```

### Human QA

For:

* Feel
* Fun
* Visual quality
* Audio
* Pacing
* UX
* Narrative experience

---

# 68. Deterministic Systems

Where possible, gameplay calculations should be deterministic.

For example:

```text
Same inputs
+
Same game state
=
Same result
```

This makes bugs significantly easier to reproduce.

Randomness should use controlled game RNG rather than arbitrary calls scattered throughout the codebase.

---

# 69. Random Number Generation

A centralized random utility should eventually support:

* Seeded randomness
* Reproducible testing
* Controlled procedural behavior

This will be useful for:

* Loot
* Creature behavior
* Resource generation
* World events
* Future procedural systems

---

# 70. Performance Architecture

Browser performance is a first-class requirement.

The game should avoid:

* Thousands of unnecessary active objects
* Constant database requests
* Unbounded particle effects
* Excessive texture duplication
* Per-frame expensive calculations
* Unnecessary DOM manipulation

---

# 71. World Streaming

The initial world is medium-sized.

We should **not automatically build complex world streaming** unless profiling shows it is necessary.

However, world regions should have enough separation that streaming/culling can be introduced later.

Possible progression:

```text
Initial
→ Entire relevant map loaded

Later
→ Region-based loading/culling

Much later
→ Advanced streaming if necessary
```

---

# 72. Object Lifecycle

World objects should have controlled lifecycles.

```text
Create
 ↓
Active
 ↓
Inactive / pooled
 ↓
Destroyed
```

This is particularly important for:

* Creatures
* Particles
* Effects
* Temporary objects

We should avoid constantly creating and destroying large numbers of objects unnecessarily.

---

# 73. Collision Architecture

Collision should be data-driven.

Map data should define:

* Walkable areas
* Obstacles
* Building boundaries
* Terrain restrictions

Gameplay systems should query collision information rather than individually hardcoding every obstacle.

---

# 74. Pathfinding

Pathfinding should initially be introduced only where required.

Potential uses:

* NPC movement
* Creatures
* Future companions

A grid-based pathfinding implementation is likely sufficient for the initial game.

We should not build sophisticated navigation meshes before the world requires them.

---

# 75. World Coordinates and Pathfinding

Pathfinding operates in logical world/grid coordinates.

The rendering layer converts those positions into isometric screen coordinates.

This separation is important:

```text
Pathfinding
    ↓
World coordinate
    ↓
Isometric projection
    ↓
Screen position
```

---

# 76. Repository Architecture

The repository should be organized around **domains**, not random technical categories.

Recommended structure:

```text
underhallow/
│
├── src/
│   ├── core/
│   │   ├── game/
│   │   ├── state/
│   │   ├── events/
│   │   ├── time/
│   │   └── random/
│   │
│   ├── world/
│   │   ├── maps/
│   │   ├── entities/
│   │   ├── collision/
│   │   └── rendering/
│   │
│   ├── player/
│   │   ├── controller/
│   │   ├── movement/
│   │   ├── progression/
│   │   └── interaction/
│   │
│   ├── systems/
│   │   ├── farming/
│   │   ├── hunting/
│   │   ├── combat/
│   │   ├── building/
│   │   ├── inventory/
│   │   ├── quests/
│   │   ├── dialogue/
│   │   └── npc/
│   │
│   ├── content/
│   │   ├── items/
│   │   ├── crops/
│   │   ├── creatures/
│   │   ├── buildings/
│   │   ├── npcs/
│   │   ├── quests/
│   │   └── dialogue/
│   │
│   ├── rendering/
│   │   ├── scenes/
│   │   ├── sprites/
│   │   ├── camera/
│   │   └── iso/
│   │
│   ├── ui/
│   │   ├── hud/
│   │   ├── inventory/
│   │   ├── dialogue/
│   │   └── menus/
│   │
│   ├── audio/
│   │
│   ├── persistence/
│   │   ├── local/
│   │   ├── cloud/
│   │   └── serialization/
│   │
│   └── infrastructure/
│       ├── supabase/
│       └── analytics/
│
├── assets/
│   ├── art/
│   ├── audio/
│   └── fonts/
│
├── maps/
│
├── data/
│
├── tests/
│
├── docs/
│
└── scripts/
```

This is the **recommended baseline**, not a commandment that every folder must exist on day one.

---

# 77. Domain Ownership

Each major system should have a clear owner.

| Domain         | Primary responsibility |
| -------------- | ---------------------- |
| Core           | Game lifecycle/state   |
| World          | World representation   |
| Player         | Player behavior        |
| Farming        | Farming mechanics      |
| Hunting        | Hunting mechanics      |
| Combat         | Combat mechanics       |
| Building       | Construction           |
| Inventory      | Items/storage          |
| NPC            | NPC simulation         |
| Quest          | Objectives/progression |
| Dialogue       | Conversation           |
| Content        | Game definitions       |
| Rendering      | Visual presentation    |
| UI             | Interface              |
| Persistence    | Saves                  |
| Infrastructure | External services      |

No domain should casually modify another domain's internal state.

---

# 78. Dependency Rule

Dependencies should generally flow inward toward core/domain logic.

Preferred:

```text
UI
 ↓
Gameplay
 ↓
Domain
 ↓
Persistence/Infrastructure
```

Avoid:

```text
Database
 ↓
Farming
 ↓
UI
 ↓
NPC
 ↓
Rendering
```

where everything depends directly on everything else.

---

# 79. Content vs Code

A key architectural principle:

> **Designers/narrative agents should be able to modify content without rewriting engine code.**

Examples:

Adding an NPC should primarily involve:

```text
NPC definition
+
Dialogue
+
Schedule
+
Assets
```

not:

```text
Create new NPC class
Create new scene
Modify 15 systems
```

The same should apply to crops, items, quests and creatures.

---

# 80. Agent-Safe Architecture

Underhallow is being built with multiple AI agents.

Therefore the architecture must actively reduce agent interference.

Each agent should have clearly defined domain boundaries.

For example:

```text
World Agent
    owns world/map systems

Farming Agent
    owns farming

Narrative Agent
    owns dialogue/quests/story content

Art Agent
    owns visual assets

UI Agent
    owns interface

Infrastructure Agent
    owns persistence/external services
```

Agents should not casually edit unrelated domains.

---

# 81. Agent Contract

Every significant agent task should identify:

```text
Objective
Scope
Files/domains allowed
Dependencies
Constraints
Acceptance criteria
Tests required
Out-of-scope items
```

This is essential for AI-assisted development.

---

# 82. Shared Core Protection

The following areas should have heightened protection:

* Game state
* Save serialization
* World coordinates
* Entity IDs
* Event system
* Time system
* Item identity
* Persistence contracts

Agents should not casually modify these foundations.

Changes require architectural review.

---

# 83. API Contracts Between Systems

Systems should communicate through explicit interfaces.

For example:

```text
InventoryService
    addItem()
    removeItem()
    hasItem()
    getItemCount()
```

Farming should request inventory operations through that interface rather than manipulating inventory arrays directly.

This makes systems easier to test and prevents state corruption.

---

# 84. No God Object

We explicitly prohibit an architecture where everything eventually ends up inside:

```text
GameManager
```

or:

```text
PlayerManager
```

or:

```text
WorldManager
```

with thousands of lines of unrelated responsibilities.

Managers may coordinate.

They should not become dumping grounds.

---

# 85. Configuration

Environment-specific configuration should be separated from game content.

Examples:

```text
Development
Production
Testing
```

Secrets must never be committed to the repository.

---

# 86. Secrets

The browser must never contain privileged backend secrets.

Client-side configuration may contain public identifiers where appropriate.

Server/service-role credentials must remain server-side.

This becomes especially important once economic or social systems are introduced.

---

# 87. Database Boundary

The game client should not have unrestricted access to database tables.

Supabase Row Level Security should eventually enforce:

> A player can only access data they are authorized to access.

Even in a single-player game, this creates the correct foundation for future player-owned state.

---

# 88. Security Philosophy

Security requirements should increase with economic value.

Initial:

> Protect accounts and player saves.

Later:

> Protect trading.

Later:

> Protect competitive rankings.

Eventually:

> Protect real-world economic value.

The architecture should not pretend these are equivalent security problems.

---

# 89. Browser Resilience

The game should gracefully handle:

* Temporary network loss
* Slow network
* Failed cloud save
* Browser refresh
* Tab closure
* Asset loading errors
* Corrupted local state where recoverable

A network outage should not automatically mean:

> "Your game is over."

---

# 90. Loading Strategy

The game should show a deliberate loading experience.

Conceptually:

```text
Boot
 ↓
Load essential runtime
 ↓
Load initial assets
 ↓
Initialize state
 ↓
Enter world
 ↓
Lazy-load noncritical content
```

The first playable experience should not wait for the entire eventual game universe.

---

# 91. Asset Loading

Assets should be grouped by world/feature where practical.

For example:

```text
Core Assets
Town Assets
Forest Assets
Personal Island Assets
Combat Assets
```

This allows future optimization.

---

# 92. Testing Data

The repository should contain deterministic test fixtures.

Examples:

```text
Test Player
Test Island
Test Crop
Test NPC
Test Quest
Test Inventory
```

Agents should be able to reproduce common states without manually playing the game for ten minutes.

This is particularly valuable for AI-assisted development.

---

# 93. Debug Tools

Development builds should eventually have a debug layer capable of:

* Teleporting player
* Changing game time
* Adding items
* Setting skills
* Completing quests
* Unlocking grids
* Spawning creatures
* Inspecting entities

These tools should never be exposed in production.

They will dramatically accelerate development and QA.

---

# 94. Development Environments

At minimum:

```text
Development
Preview/Test
Production
```

The environments should have separate configuration.

Production player data must never be casually modified by development tools.

---

# 95. Version Control

Git is the source-of-truth version control system.

Development should use:

* Small commits
* Descriptive commit messages
* Feature branches where appropriate
* Reviewable changes
* No committed secrets
* No generated build artifacts unless intentionally required

AI agents should not make enormous unrelated commits.

---

# 96. Change Management

Changes should be classified:

### Type A — Local

Example:

> Fix crop growth calculation.

Agent can implement and test.

### Type B — Cross-system

Example:

> Change how inventory items are represented.

Requires broader review.

### Type C — Architectural

Example:

> Replace the entity model.

Requires explicit architectural approval.

### Type D — North Star/Foundation

Example:

> Change Underhallow from single-player-first to multiplayer-first.

Founder decision required.

---

# 97. Observability

Development should make it possible to answer:

> What happened?

when something goes wrong.

For example:

```text
Quest failed to complete
 ↓
Which objective?
 ↓
Which event?
 ↓
Which state?
 ↓
Which system?
```

The architecture should make these chains inspectable.

---

# 98. Migration Philosophy

Never assume the initial implementation will remain unchanged forever.

Instead:

> **Design boundaries so individual systems can be replaced.**

For example:

```text
Local Save Adapter
       ↓
Cloud Save Adapter
       ↓
Future persistence implementation
```

The game should not need to know which storage provider is behind the interface.

---

# 99. Architecture Decision Record System

Major architectural choices should eventually be recorded as ADRs.

Examples:

```text
ADR-001: Phaser selected as game runtime
ADR-002: TypeScript selected as primary language
ADR-003: Tiled selected for map authoring
ADR-004: Supabase selected for persistence
ADR-005: Single-player client simulation
```

If we later reverse a decision, the reasoning should remain documented.

---

# 100. First Technical Prototype

Before building the actual game systems, we should create a **Rendering & World Prototype**.

Its only job is to prove:

### Isometric rendering

* Tile rendering
* Camera
* Depth sorting

### Player

* Sprite
* Animation
* Movement
* Collision

### World

* Basic terrain
* Buildings
* Trees
* Props

### Browser

* Performance
* Scaling
* Pixel fidelity

This prototype is the technical equivalent of the game's visual foundation.

---

# 101. Prototype Gate

We should not begin building the full game until the prototype answers:

### Visual

> Does this actually look like Underhallow?

### Technical

> Can the browser render the intended world comfortably?

### Movement

> Does movement feel good?

### Camera

> Does the isometric perspective feel right?

### Depth

> Do buildings, trees and characters layer correctly?

### Art scale

> Does the character size feel correct relative to the environment?

If any answer is no, we fix the foundation **before content production**.

---

# 102. First Production Vertical Slice

After the rendering prototype:

```text
Prototype
    ↓
Player
    ↓
Main Island
    ↓
Town
    ↓
NPC
    ↓
Interaction
    ↓
Personal Island
    ↓
Farming
    ↓
Building
    ↓
Inventory
    ↓
Save
```

This becomes our first real playable Underhallow build.

---

# 103. Implementation Order

The recommended high-level order is:

### Phase 0 — Architecture

* Repository
* Toolchain
* Core conventions
* Testing
* Agent boundaries

### Phase 1 — Rendering Prototype

* Isometric projection
* Tiles
* Camera
* Player
* Collision
* Depth sorting

### Phase 2 — Core Runtime

* Game state
* Entity system
* Input
* Interaction
* Time
* Events

### Phase 3 — World

* Main Island
* Town
* Personal Island
* World transitions

### Phase 4 — Core Gameplay

* Inventory
* Farming
* Building
* Basic exploration
* Basic hunting/combat

### Phase 5 — Persistence

* Save serialization
* Local save
* Cloud save
* Migration/versioning

### Phase 6 — Narrative

* NPCs
* Dialogue
* Quests
* Character progression
* Mystery framework

### Phase 7 — Polish

* Art
* Animation
* Audio
* UX
* Performance
* Human QA

---

# 104. What We Deliberately Do Not Build Yet

The architecture does **not** authorize implementation of:

* Blockchain
* Token economy
* Real-world trading
* Multiplayer
* Guilds
* Player-to-player economy
* Complex crafting
* Advanced combat
* Large-scale procedural generation
* Full seasonal simulation
* Complex social systems

These require separate specifications.

---

# 105. Technical Invariants

These are now architectural rules.

### Invariant 1

**Gameplay state is separate from rendering state.**

### Invariant 2

**Game content is data-driven wherever practical.**

### Invariant 3

**The browser client does not depend on a network connection for every gameplay action.**

### Invariant 4

**Persistent saves are versioned.**

### Invariant 5

**External services are accessed through boundaries/adapters.**

### Invariant 6

**The game does not require blockchain.**

### Invariant 7

**Multiplayer is not part of the initial runtime architecture.**

### Invariant 8

**AI agents operate within explicit domain boundaries.**

### Invariant 9

**Core game-state contracts are protected from casual modification.**

### Invariant 10

**No single manager/class becomes the dumping ground for unrelated systems.**

### Invariant 11

**The game must be testable without requiring a human to perform every setup step manually.**

### Invariant 12

**Technical complexity must earn its place through an actual game requirement.**

---

# 106. Architecture Decision Register

| Decision                               | Status                          |
| -------------------------------------- | ------------------------------- |
| Phaser 3                               | 🔒 Recommended / Baseline       |
| TypeScript                             | 🔒 Locked                       |
| Vite                                   | 🔒 Baseline                     |
| Tiled                                  | 🔒 Recommended                  |
| Aseprite                               | 🔒 Recommended                  |
| Supabase                               | 🔒 Initial backend baseline     |
| PostgreSQL                             | 🔒 Initial persistence database |
| Isometric projection                   | 🔒 Locked                       |
| Data-driven content                    | 🔒 Locked                       |
| Separate domain/presentation state     | 🔒 Locked                       |
| Lightweight entity/system architecture | 🔒 Locked                       |
| Client-side initial simulation         | 🔒 Locked                       |
| Local persistence                      | 🔒 Required                     |
| Cloud persistence                      | 🔒 Planned architecture         |
| Save versioning                        | 🔒 Locked                       |
| Single-player first                    | 🔒 Locked                       |
| Multiplayer server                     | 🟡 Future                       |
| Blockchain adapter                     | 🟡 Future                       |
| Full economy backend                   | 🟡 Future                       |
| Exact tile size                        | 🟡 Prototype                    |
| Exact pixel resolution                 | 🟡 Prototype                    |
| Exact camera behavior                  | 🟡 Prototype                    |
| Exact sprite dimensions                | 🟡 Prototype                    |
| Full world streaming                   | 🟡 Only if required             |
| Full ECS framework                     | ⚪ Not currently justified       |

---

# 107. Architecture Definition of Done

The Technical Architecture is considered sufficiently defined when the implementation team/agents can answer:

> **Where does this code belong?**

> **What state does it own?**

> **What other systems may it communicate with?**

> **How is that state persisted?**

> **How do we test it?**

> **What happens if the system fails?**

> **What happens when the game gets 10× larger?**

> **Can another agent modify this domain without accidentally breaking five others?**

If an agent cannot answer those questions, the architecture is not sufficiently explicit.

---

# 108. The Critical Architectural Rule

There is one rule I want to emphasize above everything else:

> ## **The game state is the truth. The renderer is the representation.**

If we maintain that distinction from day one, Underhallow can evolve from a small browser game into a much larger world without the codebase becoming an unmaintainable pile of Phaser objects and AI-generated patches.

---

# 109. Architecture → Agent Constitution

We now have three layers:

```text
UNDERHALLOW NORTH STAR
        ↓
"What are we trying to make?"

FOUNDATION SPECIFICATION
        ↓
"What fundamentally exists?"

TECHNICAL ARCHITECTURE
        ↓
"How is it built?"
```

The **next document should be the Agent Constitution**.

That document is particularly important for Underhallow because we're not building this traditionally with one developer writing everything manually.

It should define:

* Agent hierarchy
* Agent roles
* What each agent owns
* What agents may modify
* What agents may never modify
* How agents communicate
* How agents hand work off
* Research requirements
* Planning requirements
* Coding standards
* Testing requirements
* Git/commit rules
* Conflict resolution
* Architectural change procedures
* When an agent can act autonomously
* When it must stop and ask
* How multiple agents work concurrently
* How the lead/orchestrator agent coordinates everything
* Human approval gates
* Definition of done for agent work

**That is the document that turns this from "we have an architecture" into "we have a controlled AI development organization capable of actually building Underhallow."**
