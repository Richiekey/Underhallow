# Underhallow Implementation Architecture Specification V1

**Document ID:** IA-001  
**Status:** DRAFT  
**Authority Level:** Level 4 — Implementation Specification  
**Parent Specifications:**
* [North Star V1.0 (NS-001)](file:///c:/Users/HP/Documents/Underhallow/docs/NORTH_STAR.md)
* [Foundation Specification V1.0 (FS-001)](file:///c:/Users/HP/Documents/Underhallow/docs/FOUNDATION_SPECIFICATION.md)
* [Engine & Technical Architecture Specification V1 (ETA-001)](file:///c:/Users/HP/Documents/Underhallow/docs/ENGINE_TECHNICAL_ARCHITECTURE_SPECIFICATION.md)
* [Core Gameplay Systems Specification V1.0 (CG-001)](file:///c:/Users/HP/Documents/Underhallow/docs/CORE_GAMEPLAY_SYSTEMS_SPECIFICATION.md)
* [Player Control, Movement & Interaction Specification V1.0 (PC-001)](file:///c:/Users/HP/Documents/Underhallow/docs/PLAYER_CONTROL_MOVEMENT_INTERACTION_SPECIFICATION.md)
* [World & Map Architecture Specification V1.0 (WM-001)](file:///c:/Users/HP/Documents/Underhallow/docs/WORLD_MAP_ARCHITECTURE_SPECIFICATION.md)
* [Player Progression Specification V1.0 (PR-001)](file:///c:/Users/HP/Documents/Underhallow/docs/PLAYER_PROGRESSION_SPECIFICATION.md)
* [Farming System Specification V1.0 (FB-001)](file:///c:/Users/HP/Documents/Underhallow/docs/FARMING_SYSTEM_SPECIFICATION.md)
* [Hunting & Combat System Specification V1.0 (HU-001)](file:///c:/Users/HP/Documents/Underhallow/docs/HUNTING_COMBAT_SYSTEM_SPECIFICATION.md)
* [Multiplayer & Social Systems Specification V1.0 (MS-001)](file:///c:/Users/HP/Documents/Underhallow/docs/MULTIPLAYER_SOCIAL_SYSTEMS_SPECIFICATION.md)

**Engine:** Godot  
**Language:** GDScript  
**Primary Platform:** Windows PC  
**Architecture:** Single-player-first, multiplayer-native  
**Implementation Philosophy:** Specify enough → prototype → learn → refine → lock → build  

---

## 1. Purpose

This specification defines the minimum technical implementation architecture required to begin building Underhallow.

It establishes:

* project structure
* state ownership
* gameplay-system boundaries
* scene architecture
* data architecture
* global services
* input architecture
* world implementation
* camera architecture
* simulation time
* persistence
* networking boundaries
* testing expectations
* AI-agent development boundaries
* asset organization
* first implementation milestone

This document does **not** replace the higher-level gameplay specifications.

Where this document conflicts with a higher-authority specification, the higher-authority specification takes precedence and this document must be reconciled.

---

# 2. Architectural Principles

## 2.1 The game state is the truth

The renderer is a representation of game state.

Gameplay systems must not depend on visual nodes being the authoritative source of gameplay truth.

For example:

* an item exists because inventory state says it exists
* a crop is growing because farming state says it is growing
* a creature is alive because hunting/world state says it is alive
* a player owns an object because ownership state says they do

Visual nodes may represent that state but must not become the permanent authority over it.

---

## 2.2 Domain ownership

Underhallow will use multiple focused domain-state objects rather than one enormous mutable global state object.

The conceptual structure is:

```text
GameState
├── PlayerState
├── WorldState
├── InventoryState
├── FarmingState
├── HuntingState
├── BuildingState
└── Other Domain State
```

The exact domain list may expand as implementation progresses.

Each state domain owns the data necessary for its domain and exposes controlled mutation pathways.

---

## 2.3 Command → Validation → Mutation → Event

Gameplay mutations should generally follow:

```text
Input / Request
      ↓
Command
      ↓
Validation
      ↓
State Mutation
      ↓
Event
      ↓
Presentation / UI / Secondary Systems
```

This architecture provides a clean path toward multiplayer authority without requiring multiplayer implementation in the first prototype.

It also prevents visual code, UI code, and arbitrary gameplay scripts from directly mutating authoritative state.

---

## 2.4 Composition over deep inheritance

Systems should prefer:

* small focused classes
* composition
* explicit interfaces
* signals/events
* data-driven definitions

Deep inheritance hierarchies should be avoided unless they provide a clear architectural benefit.

---

## 2.5 Data-driven content

Content definitions should be represented as data rather than hardcoded gameplay classes wherever practical.

Examples include:

```text
ItemDefinition
CropDefinition
CreatureDefinition
BuildingDefinition
RecipeDefinition
```

This allows content to evolve without requiring changes to core engine architecture.

---

# 3. Project Structure

The project will use a hybrid organization combining domain-oriented code with Godot's scene/resource conventions.

Initial structure:

```text
/
├── project.godot
│
├── src/
│   ├── core/
│   ├── gameplay/
│   ├── world/
│   ├── player/
│   └── networking/
│
├── presentation/
│
├── assets/
│   ├── characters/
│   ├── environment/
│   ├── items/
│   ├── creatures/
│   ├── buildings/
│   ├── ui/
│   └── effects/
│
├── data/
│
├── scenes/
│
├── tests/
│
└── docs/
```

The exact internal structure may evolve during prototyping.

The architecture must remain domain-oriented rather than becoming a single undifferentiated `scripts/` directory.

---

# 4. Core Architecture

The `src/core/` domain contains architecture-sensitive systems shared across gameplay domains.

Potential responsibilities include:

```text
src/core/
├── state/
├── commands/
├── events/
├── time/
├── persistence/
├── definitions/
└── utilities/
```

The exact files are implementation details and should be introduced only when required.

### Core restriction

`src/core/state/` is architecture-sensitive.

Agents must not modify global state structures or shared persistence schemas without an approved Architecture Plan or explicit task authorization.

---

# 5. Gameplay Architecture

Gameplay systems should be separated by domain.

Conceptually:

```text
src/gameplay/
├── farming/
├── hunting/
├── inventory/
├── crafting/
├── building/
├── interaction/
├── progression/
└── economy/
```

Not every directory needs to exist immediately.

A domain should be introduced when the prototype actually requires it.

Each gameplay system should:

1. own its domain logic
2. validate domain actions
3. mutate appropriate state through controlled pathways
4. emit meaningful events
5. avoid direct dependence on presentation code

---

# 6. Player Architecture

The player implementation will be separated into:

```text
src/player/
├── player_controller.gd
├── player_state.gd
├── player_interaction.gd
└── ...
```

The exact implementation may evolve.

The player should not become the owner of unrelated global gameplay systems.

For example, farming logic does not belong inside the player controller.

---

# 7. Scene Architecture

The initial scene architecture will be modular.

Rather than creating one giant `Main.tscn`, the project should conceptually separate:

```text
Game
├── World
├── Player
├── Systems
├── UI
└── Camera
```

The exact scene hierarchy may change during prototyping.

Scenes should represent runtime composition and presentation.

They should not become the sole source of persistent gameplay state.

---

# 8. Reusable Scene Policy

Reusable scenes should be created when genuine reuse exists.

Underhallow will not aggressively componentize every object from the beginning.

The guiding rule is:

> Abstract repeated behavior when repetition becomes real, not because abstraction appears theoretically elegant.

Examples of likely reusable scenes include:

* player
* creature
* tree/resource node
* crop
* item pickup
* building
* interaction marker

But these should be introduced progressively.

---

# 9. Content Data Architecture

Godot Resources will be the primary content-definition mechanism.

The architecture will use a hybrid approach where appropriate:

```text
Godot Resources
        ↓
runtime systems
        ↓
persistent state
        ↓
server/cloud persistence
```

Godot Resources are preferred for authored game definitions because they integrate naturally with the engine and provide typed data structures.

Examples:

```text
ItemDefinition
CropDefinition
CreatureDefinition
BuildingDefinition
RecipeDefinition
```

Runtime state must remain separate from immutable/content definition data.

For example:

```text
CropDefinition
    ├── crop name
    ├── growth duration
    ├── required conditions
    └── visual references

CropState
    ├── planted time
    ├── current growth state
    ├── owner
    └── world location
```

---

# 10. Autoload Architecture

Autoloads will be kept deliberately small.

Only genuinely global services should become autoloads.

Potential global services include:

```text
Game
GameTime
SaveManager
InputManager
AudioManager
```

Not every gameplay system should become a singleton.

Gameplay-domain systems should generally be instantiated and owned by the appropriate game/world composition.

This prevents global state from becoming difficult to reason about or test.

---

# 11. Input Architecture

Input will use logical actions rather than hardcoded physical keys.

Initial action examples:

```text
move_up
move_down
move_left
move_right

interact

primary_action
secondary_action

inventory
map
menu
```

Godot's Input Map will define the physical bindings.

The gameplay layer should consume logical actions.

This allows controller support to be introduced later without rewriting gameplay systems.

---

# 12. Player Movement

The initial player movement architecture will use `CharacterBody2D`.

Movement will be continuous/free rather than tile-stepped.

The architecture must support:

* keyboard movement
* mouse interaction
* future controller input
* collision
* animation direction
* authoritative multiplayer movement later

Navigation/click-to-move may be added later without replacing the underlying player-control architecture.

---

# 13. World Architecture

Underhallow's world will use a hybrid implementation.

### Terrain

Terrain and grid-aligned world structure will primarily use Godot's tile/grid systems.

### Objects and entities

Interactive objects and entities will generally be represented as scenes/nodes or runtime entities.

Conceptually:

```text
World
├── Terrain
├── Static Objects
├── Interactive Objects
├── Creatures
├── Players
└── Runtime Systems
```

This avoids forcing every world element into either a pure tile system or a fully independent sprite system.

---

# 14. World Authoring

The primary world will be authored rather than generated entirely procedurally.

Procedural systems may be layered on top where useful.

Examples may include:

* resource distribution
* wildlife spawning
* environmental variation
* repeatable world-state systems

The core geography and important locations should remain intentionally designed.

The prototype should prioritize believable authored spaces over procedural complexity.

---

# 15. Camera Architecture

The camera will be a dedicated `CameraController`, separate from the player controller.

Responsibilities include:

* following the player
* zoom
* camera bounds
* smoothing if appropriate
* future multiplayer presentation considerations

V1 camera behavior:

* fixed isometric orientation
* zoomable
* no player-controlled rotation

Camera rotation is not part of the V1 implementation.

---

# 16. Simulation Time

Underhallow will use a dedicated `GameTime` abstraction rather than allowing gameplay systems to accumulate real-time frame deltas independently.

The simulation should support configurable time progression.

Conceptually:

```text
Real Time
    ↓
GameTime
    ↓
Gameplay Systems
```

Systems such as:

* crops
* production
* crafting
* construction
* world schedules

should derive their progression from game time.

This is required for deterministic offline progression and future server authority.

---

# 17. Day/Night

Day/night progression will exist in the first prototype.

The initial implementation may remain visually simple.

The prototype should establish:

* game time progression
* day progression
* basic lighting/environment changes
* systems reacting to time

It does not need a complete weather/calendar ecosystem at this stage.

---

# 18. Persistence Architecture

The first implementation will use a hybrid persistence strategy.

### Prototype phase

Local persistence will be used first.

A local structured representation such as JSON is appropriate for early development.

### Later production architecture

Persistence can evolve toward:

```text
Local Runtime State
        ↓
Persistence Layer
        ↓
Supabase / Server Persistence
```

Gameplay code should not directly depend on a specific database implementation.

The persistence layer should provide an abstraction between runtime state and storage.

---

# 19. Save Versioning

Save data will be versioned from the beginning.

Conceptually:

```text
SaveData
├── version
├── player
├── world
├── inventory
└── ...
```

Future migrations must be possible without requiring players to lose existing progress.

Even the earliest prototype should establish the basic versioning mechanism.

---

# 20. Networking Architecture

Multiplayer gameplay will not be implemented in the first prototype.

However, the architecture must avoid decisions that make authoritative multiplayer unnecessarily difficult later.

The prototype will therefore establish networking boundaries/interfaces without implementing the complete multiplayer stack.

The desired future flow is:

```text
Client Request
      ↓
Authoritative Game Server
      ↓
Validation
      ↓
State Mutation
      ↓
State/Event Replication
      ↓
Clients
```

The client must not be treated as authoritative for persistent competitive or shared gameplay state.

---

# 21. Client and Dedicated Server

The client and dedicated server should use the same Godot project where practical.

Shared domain logic should be reusable between:

```text
Client
Server
```

while presentation-specific code remains client-side.

Conceptually:

```text
Shared
├── State
├── Definitions
├── Commands
├── Validation
└── Simulation Logic

Client
├── Rendering
├── Input
├── UI
├── Audio
└── Presentation

Server
├── Authority
├── Persistence
├── Validation
├── Simulation
└── Networking
```

This structure reduces duplicated gameplay logic.

---

# 22. Testing Strategy

Testing will use selective unit and integration testing.

Tests should prioritize deterministic systems and architecture-sensitive logic.

High-value test targets include:

* inventory mutations
* item definitions
* crop growth
* combat calculations
* GameTime
* save/load
* save migrations
* ownership rules
* permission rules
* command validation
* state transitions

Visual presentation does not require exhaustive automated testing during the prototype phase.

---

# 23. AI-Agent Development Boundaries

AI coding agents may implement normal gameplay tasks within their assigned domain.

Architecture-sensitive changes require additional discipline.

An implementation plan is required before modifying areas such as:

```text
src/core/state/
save schemas
networking architecture
shared client/server interfaces
autoload architecture
persistence contracts
```

Agents must not silently redesign foundational architecture while implementing an unrelated feature.

If implementation reveals a genuine architectural deficiency, the agent should report it rather than silently expanding scope.

---

# 24. Domain Whitelisting

Agents must work within explicitly assigned domains.

For example:

```text
Player Task
→ src/player/
→ relevant player scenes
→ relevant player tests

Farming Task
→ src/gameplay/farming/
→ relevant farming data
→ relevant farming scenes/tests
```

Agents must not modify unrelated systems merely because they encounter them during implementation.

Cross-domain changes require explicit authorization.

---

# 25. Asset Organization

Assets will primarily be organized by asset category:

```text
assets/
├── characters/
├── environment/
├── items/
├── creatures/
├── buildings/
├── ui/
└── effects/
```

Gameplay ownership should be expressed through data and references rather than duplicating assets into every system directory.

The asset architecture may evolve once the visual pipeline becomes established.

---

# 26. Pixel-Art Resolution

The final base sprite resolution will **not** be locked before visual prototyping.

The prototype should evaluate the visual language using practical candidates, including different sprite scales where useful.

The decision should be based on:

* readability
* isometric composition
* character proportions
* environment density
* animation requirements
* UI scale
* visual identity
* production feasibility

The visual prototype determines the appropriate resolution rather than an arbitrary early technical commitment.

---

# 27. First Implementation Milestone

## Vertical Slice V0.1 — The First Day

The first playable implementation should demonstrate a complete miniature Underhallow experience.

### Player journey

```text
Start
 ↓
Personal Island
 ↓
Walk
 ↓
Interact
 ↓
Plant
 ↓
Explore nearby world
 ↓
Gather / Hunt
 ↓
Return Home
 ↓
Time Progresses
 ↓
Save
 ↓
Reload
```

### Required systems

V0.1 should establish:

* Godot project
* project structure
* player movement
* fixed isometric camera
* basic world
* personal island
* nearby wilderness
* interaction system
* basic farming
* basic gathering
* minimal hunting
* GameTime
* day/night presentation
* inventory
* local persistence
* save/load
* basic UI
* basic authored environment
* initial Underhallow visual language

### Explicitly excluded

The first slice does **not** need:

* marketplace
* player economy
* guilds
* guild islands
* multiplayer gameplay
* voice chat
* global chat
* complex progression
* large quest system
* full crafting ecosystem
* monetization
* blockchain/wallet systems
* extensive content
* complete production UI
* advanced procedural generation

The goal is not breadth.

The goal is to answer:

> **Does Underhallow already feel like a believable, enjoyable world to inhabit?**

---

# 28. Vertical Slice Success Criteria

V0.1 succeeds if a player can:

1. launch the game
2. enter the world
3. understand where they are
4. move naturally
5. interact with the environment
6. perform a simple farming action
7. explore beyond their home
8. gather resources
9. hunt a simple creature
10. return home
11. observe time progression
12. save
13. close the game
14. reload
15. retain meaningful progress

Additionally:

* the architecture remains understandable
* state is separated from presentation
* save/load is deterministic enough for the prototype
* no stamina system is introduced
* no architectural shortcut blocks future multiplayer
* the visual language begins to feel distinctly like Underhallow

---

# 29. Prototype Rule

The vertical slice is an experiment, not a commitment to every implementation detail.

The development loop is:

```text
Build
 ↓
Play
 ↓
Observe
 ↓
Identify Problems
 ↓
Refine Architecture
 ↓
Update Specification
 ↓
Lock Proven Decisions
 ↓
Continue
```

No implementation decision should be considered permanently locked merely because it exists in the first prototype.

---

# 30. Definition of Done

Implementation Architecture V1 is considered successfully established when:

* the Godot project exists
* the agreed directory structure exists
* the project launches
* core architecture boundaries are established
* logical input actions are configured
* basic state architecture exists
* GameTime exists
* persistence abstraction exists
* test infrastructure exists
* client/server boundaries are represented
* AI-agent domain boundaries are documented
* V0.1 implementation can begin without architectural ambiguity

---

# 31. Architectural Decision Summary

| Area                   | Decision                                 |
| ---------------------- | ---------------------------------------- |
| Project structure      | Hybrid domain/Godot structure            |
| State                  | Multiple domain state objects            |
| Mutation               | Command → validation → mutation → event  |
| Scenes                 | Modular                                  |
| Reuse                  | Introduce when genuinely needed          |
| Content data           | Hybrid, primarily Godot Resources        |
| Autoloads              | Small controlled set                     |
| Input                  | Logical Input Map actions                |
| Movement               | CharacterBody2D                          |
| World                  | Hybrid tile/grid + scene entities        |
| World authoring        | Authored primary, procedural layers      |
| Camera                 | Dedicated CameraController               |
| Camera rotation        | None in V1                               |
| Time                   | Configurable GameTime                    |
| Day/night              | Yes, prototype                           |
| Persistence            | Local first, cloud/server later          |
| Save versioning        | Required from beginning                  |
| Multiplayer            | Architecture first, implementation later |
| Client/server          | Same Godot project                       |
| Testing                | Unit + selective integration             |
| AI architecture plans  | Required for core architecture           |
| Agent domain whitelist | Required                                 |
| Assets                 | Category-oriented hybrid                 |
| Pixel resolution       | Determined through visual prototype      |
| First milestone        | Vertical Slice V0.1 — The First Day      |

---

# 32. Relationship to Existing Specifications

IA-001 is an implementation-level document.

It must remain subordinate to:

```text
NS-001
    ↓
Foundation Specifications
    ↓
System Specifications
    ↓
IA-001
    ↓
Implementation Tasks
```

If implementation discovers that a higher-level specification is impractical, the specification must be deliberately revised through the project's reconciliation/governance process.

Agents must not silently reinterpret higher-level design decisions.

---

# 33. Current Status

**IA-001: DRAFT**

This document becomes the implementation baseline after review and approval.

The next stage is not to write more architecture documentation indefinitely.

The next stage is to create the actual Godot project and begin **Vertical Slice V0.1 — The First Day**.
