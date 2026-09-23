# UNDERHALLOW

## Foundation Specification V1.0

**Project:** Underhallow  
**Document:** Foundation Specification  
**Version:** 1.0  
**Status:** Initial foundation baseline  
**Supersedes:** None  
**Parent document:** Underhallow North Star V1.0  
**Initial Platform:** Windows PC (architecture open to Linux/macOS; browser-first baseline superseded per SR-001)  
**Initial Game Mode:** Single-player-first, multiplayer-native (Godot Engine / Dedicated Server / Supabase)  
**Development Philosophy:** AI-agent-assisted, human-directed, human-QA-gated  

---

# 0. Purpose

The Foundation Specification translates the Underhallow North Star into a coherent product structure.

It answers:

> **What are the fundamental systems, boundaries, relationships and player experiences that make Underhallow Underhallow?**

It does **not** yet define every implementation detail.

For example:

**Foundation says:**

> The player owns a persistent personal island divided into unlockable areas.

**Later technical specification says:**

> How those areas are represented in the database, world data, rendering system and save system.

This distinction prevents us from prematurely locking technical decisions.

---

# 1. Foundation Principles

Every system in Underhallow must follow these principles.

## 1.1 Game first

Underhallow must be a good game before it is:

* a Web3 product
* an economic experiment
* a social platform
* a technical showcase

---

## 1.2 Player freedom

Players should be able to decide how they spend their time.

The game should not constantly tell players:

> "You should be doing X."

Instead, the world should provide reasons to pursue different activities.

---

## 1.3 Multiple valid playstyles

Farming, hunting, mining, fishing and animal husbandry are the five Core Gameplay Pillars — distinct lifestyle and livelihood paths per [CG-001 §4](../03-gameplay/CORE_GAMEPLAY_SYSTEMS_SPECIFICATION.md). Building & Construction, trading, crafting, exploration and other Core World Systems provide the shared infrastructure that connects them.

No single activity should invalidate the others.

---

## 1.4 Cozy before dark

The initial emotional experience should be:

> peaceful → comfortable → curious

before becoming:

> strange → mysterious → unsettling.

The mystery should be discovered rather than immediately announced.

---

## 1.5 Progression without coercion

Progression should reward engagement without requiring players to optimize their lives.

A player who wants to min-max should have room to do so.

A player who simply wants to farm and decorate should also have a satisfying experience.

---

## 1.6 Systems should reinforce one another

The major systems should connect.

For example:

```text
Exploration
     ↓
Resources / discoveries
     ↓
Farming / crafting / building
     ↓
Island development
     ↓
Improved capabilities
     ↓
New exploration opportunities
```

Rather than building isolated minigames, Underhallow should become a network of mutually reinforcing systems.

---

# 2. High-Level Game Architecture

At the product level:

```text
                               UNDERHALLOW
                                    │
           ┌────────────────────────┼────────────────────────┐
           │                        │                        │
      MAIN ISLAND            PERSONAL ISLAND           GUILD ISLANDS
           │                        │                        │
   Shared world space       Player-owned space      Guild-owned space
           │                        │                        │
   ┌───────┼────────┐        ┌──────┼────────┐        ┌──────┼────────┐
   │       │        │        │      │        │        │      │        │
  Town   Nature Wilderness  Home   Farm  Expansion  Guild Hall Communal Personal
   │       │        │        │      │        │        │        Farms   Plots
   └───────┼────────┘        └──────┼────────┘        └──────┼────────┘
           │                        │                        │
           └──────────────────── PLAYER ─────────────────────┘
```

The three spaces have distinct, complementary responsibilities.

### Main Island

**Discovery, society, narrative, exploration and shared-world activity.**

### Personal Island

**Ownership, progression, farming, building and player expression.**

### Guild Islands

**Cooperation, communal projects, shared farming, guild progression and group identity.**

---

# 3. Player Experience Architecture

The game should support several gameplay loops.

## 3.1 Moment-to-moment loop

The smallest gameplay loop:

```text
Move
→ Observe
→ Interact
→ Collect / act
→ Receive feedback
→ Decide what to do next
```

Movement and interaction must feel responsive enough that simply walking around the world is enjoyable.

---

# 4. Core Daily Loop

The primary player loop should be approximately:

```text
Wake / begin session
        ↓
Check personal island
        ↓
Farm / build / manage
        ↓
Travel to Main Island
        ↓
Explore / interact / quest
        ↓
Gather / hunt / discover
        ↓
Return home
        ↓
Use resources / progress
        ↓
Develop island
        ↓
Continue exploring or end session
```

This is not intended to force a literal daily schedule.

It represents the relationship between systems.

Players should be able to break this pattern whenever they want.

---

# 5. Long-Term Loop

Over longer play:

```text
Explore
   ↓
Discover
   ↓
Acquire resources / knowledge
   ↓
Improve character
   ↓
Improve home
   ↓
Expand island
   ↓
Unlock new possibilities
   ↓
Explore further
   ↓
Discover more of Underhallow
```

The narrative sits across this loop.

The player gradually becomes more capable while simultaneously understanding more about the world.

---

# 6. Player Character

The player character is a new resident entering the world.

The character is persistent.

The player controls:

* Movement
* Interaction
* Farming
* Hunting
* Building
* Exploration
* Inventory
* Equipment
* Social interaction
* Progression decisions

The character should not be permanently locked into a class.

---

# 7. Character Progression

The initial foundation recognizes several progression dimensions.

### Core

* Character level
* Farming skill
* Hunting skill
* Building skill

### Property

* House progression
* Island progression
* Buildings
* Land expansion

### Economic

* Wealth
* Trading capability

### Future

* Exploration/discovery
* Crafting
* NPC relationships
* Reputation
* Collections
* Other professions

The exact formulas, XP curves and unlock trees are deferred.

---

# 8. Skills

Skills should represent what the player actually does.

For example:

```text
Farm frequently
     ↓
Farming progression
     ↓
Better farming capabilities
     ↓
More sophisticated farming opportunities
```

Likewise:

```text
Hunt
 ↓
Hunting progression
 ↓
Improved hunting capabilities
 ↓
Access to more challenging opportunities
```

And:

```text
Build
 ↓
Building progression
 ↓
More building possibilities
 ↓
Greater island expression
```

Skills should **enable playstyles**, not trap players inside them.

---

# 9. Main Island Foundation

The Main Island is the primary external world.

It should contain a mixture of:

### Civilization

* Town
* Shops
* NPC homes
* Public buildings
* Market areas
* Social spaces

### Nature

* Forest
* Fields
* Water
* Wilderness
* Resource areas

### Adventure

* Hidden locations
* Hunting areas
* Secrets
* Rare resources
* Story locations

### Narrative

* Character locations
* Story landmarks
* Quest locations
* Mystery locations

The Main Island should eventually feel like a connected geographic environment.

---

# 10. Main Island Spatial Philosophy

The Main Island should be:

**Medium-sized.**

Large enough that:

* exploration matters
* distant areas feel different
* players can discover things organically

But not so large that:

* walking becomes tedious
* the world feels empty
* development becomes unnecessarily enormous

Density is more important than raw map size.

---

# 11. Town Foundation

The Town is the primary civilization hub.

It should eventually contain:

* Town Square
* NPCs
* Shops
* Services
* Quest/story locations
* Public spaces
* Market
* Event spaces

The Town Square should be one of the most visually memorable locations in Underhallow.

It is where the player should naturally encounter:

> people, stories, rumors, opportunities and clues.

---

# 12. Personal Island Foundation

Every player receives a personal island.

Initial state:

> **Common starting template.**

Players then progressively transform it.

The island consists conceptually of:

```text
Island
│
├── Starting Area
│     ├── House
│     └── Initial usable land
│
├── Expansion Grid
│     ├── Locked
│     ├── Unlockable
│     └── Developed
│
└── Future Expansion
```

---

# 13. Island Grid System

The island is divided into unlockable grids.

A grid is a **territorial unit**, not necessarily a single gameplay tile.

The grid system exists to provide:

* Controlled expansion
* Meaningful land progression
* Spatial planning
* Player customization
* Long-term island development

### Still unresolved

We have deliberately not locked:

* Physical grid dimensions
* Number of grids
* Unlock order
* Cost
* Maximum island size
* Whether grids have terrain types
* Whether grids can be purchased
* Whether special grids exist

These belong to later specifications.

---

# 14. Island Building

The player should eventually be able to place and develop structures within appropriate areas.

Potential categories:

### Residential

* House
* Extensions
* Decorative structures

### Agricultural

* Fields
* Storage
* Farming structures

### Production

* Processing buildings
* Workshops
* Other future production structures

### Utility

* Storage
* Infrastructure
* Functional buildings

### Decorative

* Trees
* Benches
* Paths
* Fences
* Gardens
* Lighting
* Other decorations

The exact building catalogue is not yet locked.

---

# 15. Island Customization

The personal island is a major player-expression system.

Players should be able to influence:

* Land usage
* Farming layout
* Buildings
* Vegetation
* Paths
* Decorations
* Functional zones

The system should eventually support islands that look substantially different from one another.

---

# 16. Farming Foundation

Farming is one of five Core Gameplay Pillars per [CG-001 §4.1.1](../03-gameplay/CORE_GAMEPLAY_SYSTEMS_SPECIFICATION.md).

The basic farming loop is:

```text
Prepare land
    ↓
Plant
    ↓
Care
    ↓
Grow
    ↓
Harvest
    ↓
Use / sell / process
    ↓
Improve farming capability
```

The system should eventually account for:

* Crops
* Seeds
* Soil/land
* Growth
* Harvesting
* Resources
* Storage
* Economic value

However, **specific crop formulas and economic values do not belong in this Foundation Specification.**

---

# 17. Hunting Foundation

Hunting provides an alternative major gameplay path.

The basic loop:

```text
Explore
 ↓
Find creature / resource
 ↓
Engage
 ↓
Combat
 ↓
Defeat / collect
 ↓
Acquire resources
 ↓
Return / use resources
 ↓
Improve hunting capability
```

Combat should initially be:

* Simple
* Responsive
* Understandable
* Accessible
* Supporting exploration

It should not dominate the game.

---

# 18. Combat Foundation

The first combat implementation should focus on the smallest useful system.

At minimum:

* Player attack
* Target detection
* Enemy health
* Damage
* Enemy response
* Player damage/health
* Defeat state
* Loot/resource result

Complex combat mechanics should only be added after the basic interaction feels good.

---

# 19. Exploration Foundation

Exploration should operate on three layers.

### Physical discovery

Finding:

* Areas
* Paths
* Resources
* Hidden locations

### Gameplay discovery

Finding:

* Items
* NPCs
* Quests
* Creatures
* Opportunities

### Narrative discovery

Finding:

* Clues
* Lore
* Secrets
* Strange events
* Connections between characters/events

The third layer becomes increasingly important as the story develops.

---

# 20. Interaction System

A unified interaction system should eventually allow the player to interact with:

* NPCs
* Objects
* Crops
* Resources
* Doors
* Buildings
* Containers
* Environmental objects
* Quest objects
* World mechanisms

The interaction system should avoid every gameplay system inventing its own incompatible interaction method.

---

# 21. NPC Foundation

NPCs are core to the narrative.

An NPC should conceptually have:

```text
Identity
Personality
Location
Routine
Relationships
Dialogue
Quests
Progression
Story relevance
```

NPCs should not merely exist to provide rewards.

They should help make the world feel alive.

---

# 22. NPC Routine System

Eventually NPCs should behave according to routines.

For example:

```text
Morning
 ↓
Home
 ↓
Work
 ↓
Town
 ↓
Social activity
 ↓
Home
```

The exact schedules are future implementation details.

The foundational requirement is:

> NPCs should appear to live in the world independently of the player.

---

# 23. Quest Foundation

Quests will primarily serve three functions:

### Character

Help the player understand NPCs.

### Adventure

Give the player reasons to explore.

### Narrative

Move the broader story forward.

Quests should not become the only reason to explore.

The world itself must contain discoverable content.

---

# 24. Quest Types

The foundation supports:

* Character quests
* Main story quests
* Exploration quests
* Collection quests
* Farming objectives
* Hunting objectives
* Building objectives
* Discovery objectives
* Event objectives

The final quest taxonomy can be expanded later.

---

# 25. Narrative Architecture

The story should be layered.

```text
Layer 1
Cozy everyday life
       ↓
Layer 2
Character stories
       ↓
Layer 3
Strange observations
       ↓
Layer 4
Connected mysteries
       ↓
Layer 5
Major revelations
       ↓
Layer 6
Underlying truth
```

The player should not receive the complete explanation immediately.

---

# 26. Narrative Pacing

The mystery must coexist with ordinary gameplay.

We should avoid:

> Mystery → mystery → mystery → mystery.

Instead:

```text
Cozy activity
 ↓
Normal story
 ↓
Small strange detail
 ↓
Return to normal life
 ↓
Another clue
 ↓
Major character event
 ↓
Larger mystery
```

This contrast is fundamental to Underhallow's identity.

---

# 27. Story Progression

The game should support:

### Main narrative

The broader Underhallow mystery.

### Character arcs

Individual NPC stories.

### World discoveries

Optional lore and secrets.

### Milestones

Major events that permanently advance the player's understanding or capabilities.

Story progression should not prevent the player from continuing normal gameplay.

---

# 28. Time & World Simulation

Underhallow should eventually operate as a persistent simulated world.

Potential simulation dimensions include:

* Time
* Day/night
* NPC schedules
* Crop growth
* Resource availability
* Events
* World-state changes

The exact calendar/season system is not yet locked.

The principle is:

> **The world should feel alive even when the player isn't directly interacting with every system.**

---

# 29. Inventory Foundation

The player needs a persistent inventory capable of representing:

* Crops
* Seeds
* Resources
* Tools
* Weapons
* Building materials
* Quest items
* Collectibles
* Future economic assets

Inventory should be designed as a shared foundational service rather than independently recreated by farming, hunting and other systems.

---

# 30. Items

Items should have a unified conceptual identity.

An item may contain:

```text
Item ID
Name
Category
Description
Stack rules
Value
Source
Usage
Visual representation
```

More advanced properties can be introduced later.

The important foundation decision is:

> **Items are data-driven.**

We should avoid hardcoding every item as a separate custom implementation.

---

# 31. Tools & Equipment

The player should eventually have equipment appropriate to their chosen activities.

Potential categories:

* Farming tools
* Hunting equipment
* Building tools
* Exploration equipment
* Utility items

Equipment progression should support the game's skill progression.

---

# 32. Resource System

Resources are a connective tissue between gameplay systems.

For example:

```text
Explore
 ↓
Resource
 ↓
Inventory
 ↓
Craft / Build / Sell / Use
 ↓
Progression
```

Resources should have meaningful relationships with the world.

The resource system should not become an arbitrary item-generation machine.

---

# 33. Crafting

Crafting is **not yet a locked primary pillar**.

However, the foundation should leave room for crafting because it naturally connects:

* Farming
* Hunting
* Exploration
* Gathering
* Building
* Economy

Crafting will receive its own specification before implementation.

---

# 34. Economy Boundary

The Foundation Specification deliberately establishes only the following:

### The economy must:

* Have meaningful player participation
* Support wealth creation
* Allow different strategies
* Not be mandatory
* Support future expansion
* Work without blockchain

### The economy must NOT yet define:

* Currency
* Token
* Token supply
* Exchange rate
* Marketplace mechanics
* Real-world conversion
* Blockchain network
* NFT architecture
* Yield
* Monetary policy

Those require a dedicated **Underhallow Economy Specification**.

---

# 35. Web3 Boundary

Blockchain is outside the initial foundation implementation.

The architecture should avoid unnecessary assumptions such as:

> "Every item must be an NFT."

or:

> "Every player needs a wallet."

The initial game must remain playable using conventional game-state persistence.

---

# 36. Competition Boundary

Competition is optional.

The foundation should support future competitive systems without making them mandatory.

Potential categories:

* Records
* Challenges
* Rankings
* Seasonal events
* Building contests
* Farming achievements
* Hunting achievements

But competition must never become the primary definition of player success.

---

# 37. Social & Cooperative Dimension

Underhallow is single-player-first, multiplayer-native. While solo play is completely self-contained and uncompromised, social systems natively support shared play:

Core social systems:

* In-game chat channels (proximity, party, guild, whisper)
* Guilds (~50 members) and persistent Guild Islands
* Island visits and cooperative permissions
* Direct peer-to-peer trading and marketplace
* Cooperative farming and shared hunting expeditions
* Seasonal community events

Solo players are never penalized or gated, but systems naturally scale when players choose to play together. Detailed rules are defined in `MS-001`.

---

# 38. Multiplayer Architecture Boundary

Underhallow is single-player-first, multiplayer-native.

Systems maintain clean, decoupled state boundaries so that core gameplay functions identically in solo play and real-time cooperative multiplayer:

```text
Player
World
Island
NPC
Inventory
Items
Progression
```

State mutations are evaluated through authoritative dedicated servers, with Supabase providing persistent identity, guild, property, and economy storage. Detailed network architecture and synchronization protocols are governed by `ETA-001` and `MS-001`.

---

# 39. Save & Persistence Foundation

The player must have persistent progression.

At the conceptual level, persistent state includes:

### Character

* Level
* Skills
* Inventory
* Equipment
* Progression

### Island

* Unlocked grids
* Buildings
* Crops
* Decorations
* World modifications

### Narrative

* Quest progress
* Story state
* NPC relationships
* Discoveries

### Economy

* Wealth
* Transactions/progression where applicable

The implementation technology is not yet specified.

---

# 40. World State

We need to distinguish:

### Static world data

Things defined by the game:

* Terrain
* Buildings
* NPC definitions
* Item definitions
* Map layout

from:

### Dynamic player/world state

Things that change:

* Crops
* Player buildings
* Quest progress
* NPC relationships
* Player inventory
* Island development
* discovered locations

This separation is foundational.

---

# 41. Isometric World Foundation

Underhallow's world will be represented visually as an isometric/3⁄4 pixel-art environment.

The world system must support:

* Tile/terrain representation
* Height/depth relationships
* Layering
* Walkable areas
* Obstacles
* Buildings
* Props
* Characters
* Interactions
* Object placement

The exact projection mathematics and tile dimensions are technical decisions for the architecture phase.

---

# 42. Movement Foundation

The player must have:

* Directional movement
* Collision
* Walkable/non-walkable areas
* Interaction range
* World boundaries

Movement should feel appropriate for an isometric simulation/adventure game.

Movement responsiveness is a **core quality requirement**, not a minor implementation detail.

---

# 43. Camera Foundation

Current creative requirement:

> Standard isometric/3⁄4 presentation.

The exact camera behavior remains open.

Possible technical decisions include:

* Fixed orientation
* Zoom
* Camera following
* Boundaries
* Dynamic framing

We should prototype the camera before locking its final behavior.

---

# 44. Rendering & Layering

Because Underhallow uses dense isometric environments, the rendering foundation must correctly handle depth.

Conceptually:

```text
Terrain
 ↓
Ground objects
 ↓
Buildings / structures
 ↓
Characters
 ↓
Foreground elements
```

Objects must appear visually in the correct depth order.

This is especially important for:

* Trees
* Buildings
* Roofs
* Characters
* Furniture
* Market stalls
* Walls
* Props

---

# 45. Art Asset Foundation

All art assets should be treated as part of a unified visual language.

Asset categories include:

### Characters

* Player
* NPCs
* Creatures

### Environment

* Terrain
* Buildings
* Trees
* Vegetation
* Water

### Props

* Furniture
* Market objects
* Tools
* Decorations

### Effects

* Weather
* Particles
* Combat effects
* Environmental effects

### UI

* Icons
* Panels
* Buttons
* Inventory elements
* Dialogue elements

The exact pixel dimensions and sprite-sheet standards belong in the Art Direction Specification.

---

# 46. Art Consistency Rule

No individual asset should be approved solely because it looks good in isolation.

It must also answer:

> **Does this look like it belongs in Underhallow?**

This becomes particularly important because AI agents will eventually be producing and modifying assets.

---

# 47. UI Foundation

The UI should support the world rather than dominate it.

Initial foundational UI systems include:

* HUD
* Inventory
* Character/progression
* Interaction prompts
* Dialogue
* Quest information
* Menus
* Settings
* Save/loading state where applicable

The visual UI language should match the cozy pixel-art world.

---

# 48. Audio Foundation

Audio is not fully specified yet, but the foundation requires three emotional layers.

### Cozy

* Ambient environmental sound
* Gentle music
* Town ambience
* Nature

### Gameplay

* Farming sounds
* Gathering
* Building
* Combat
* UI feedback

### Mystery

* Subtle tonal changes
* Environmental sounds
* Musical tension
* Unusual audio cues

The audio system should eventually allow the game's emotional state to shift without destroying the cozy atmosphere.

---

# 49. World Events

The Main Island should eventually support events.

Potential event categories:

* Seasonal
* Community
* Character
* Story
* Exploration
* Competitive

Events should make the world feel dynamic.

However, the first prototype does not require a complete event system.

---

# 50. Day-One Technical Philosophy

The initial implementation should be **vertical, not horizontal**.

Bad approach:

> Build 30 systems at 10% completion.

Preferred approach:

> Build a small slice of the actual game at meaningful quality.

For example:

```text
Player
 +
Main Island
 +
Town
 +
NPC
 +
Exploration
 +
Personal Island
 +
Farming
 +
Basic Building
```

should exist together before we expand into dozens of additional systems.

---

# 51. The First Vertical Slice

The first serious playable slice should contain:

### Main Island

* Basic environment
* Town
* Town Square
* Basic exploration
* At least one NPC

### Player

* Movement
* Camera
* Interaction
* Inventory

### Narrative

* Introduction
* First character interaction
* First objective

### Exploration

* Basic resource gathering
* At least one discoverable element

### Personal Island

* Travel to island
* House
* Initial land
* Farming
* Harvesting
* Basic building/customization

### Persistence

* Player progression survives leaving/re-entering the game

This slice proves the fundamental Underhallow fantasy.

---

# 52. Vertical Slice Success Test

The prototype should answer five questions.

### 1. Is movement enjoyable?

### 2. Does the world visually feel like Underhallow?

### 3. Is farming satisfying?

### 4. Does exploration create curiosity?

### 5. Do I want to keep playing?

If the answer to the fifth question is **no**, we do not solve the problem by adding more features.

We improve the existing loop.

---

# 53. What We Build Later

After the vertical slice proves itself, expansion can proceed into:

```text
Core Loop
    ↓
More farming
    ↓
More hunting
    ↓
More building
    ↓
More exploration
    ↓
NPC relationships
    ↓
Story expansion
    ↓
Crafting
    ↓
Economy
    ↓
Competition
    ↓
Social systems
    ↓
Multiplayer
    ↓
Optional Web3 layer
```

This is intentionally progressive.

---

# 54. System Dependency Map

A rough dependency hierarchy:

```text
                 WORLD FOUNDATION
                       │
        ┌──────────────┼──────────────┐
        ↓              ↓              ↓
    PLAYER          OBJECTS         NPCs
        │              │              │
        └──────────────┼──────────────┘
                       ↓
                  INTERACTION
                       │
        ┌──────────────┼──────────────┐
        ↓              ↓              ↓
     FARMING        HUNTING       EXPLORATION
        │              │              │
        └──────────────┼──────────────┘
                       ↓
                  INVENTORY
                       │
                       ↓
                PROGRESSION
                       │
          ┌────────────┴────────────┐
          ↓                         ↓
       BUILDING                  ECONOMY
          │
          ↓
   PERSONAL ISLAND
          │
          ↓
   LONG-TERM EXPRESSION
```

Narrative runs through the entire system rather than sitting at the end.

---

# 55. Foundation-Level Non-Goals

We are explicitly **not** solving these yet:

* Final token economy
* Blockchain architecture
* Multiplayer networking
* Guild architecture
* Full monetization
* Complete crafting tree
* Final combat depth
* Complete seasonal system
* Final progression formulas
* Final camera behavior
* Exact tile dimensions
* Final pixel resolution
* Complete world map
* Complete NPC roster
* Complete narrative
* Full asset catalogue

This is deliberate scope control.

---

# 56. Design Invariants

These are rules that should remain true unless the North Star changes.

### Invariant 1

**Underhallow must be playable without blockchain.**

### Invariant 2

**Underhallow must be enjoyable without competition.**

### Invariant 3

**No player class permanently prevents experimentation with other playstyles.**

### Invariant 4

**The Personal Island is a major player-expression space.**

### Invariant 5

**The Main Island exists primarily for world exploration, society and narrative.**

### Invariant 6

**Farming, hunting, mining, fishing and animal husbandry are the five Core Gameplay Pillars. Building & Construction is a foundational Core World System.**

### Invariant 7

**Exploration must contain meaningful discovery.**

### Invariant 8

**The cozy surface and darker underlying mystery must coexist.**

### Invariant 9

**AI agents cannot silently change foundational game decisions.**

### Invariant 10

**Feature quantity must never be prioritized over gameplay quality.**

---

# 57. Foundation Definition of Done

We consider the Foundation Specification complete enough to begin technical architecture when we can clearly answer:

### World

* What spaces exist?
* What does each space accomplish?
* How do players move between them?

### Player

* What can the player do?
* How do they progress?
* How can they express themselves?

### Gameplay

* What are the primary loops?
* How do the five Core Gameplay Pillars (farming, hunting, mining, fishing, animal husbandry) and Core World Systems interact?
* How does exploration feed those loops?

### Narrative

* Who is the player?
* What role do NPCs play?
* How does the mystery unfold?

### Persistence

* What player/world state must survive?

### Future boundaries

* What is deliberately postponed?
* What must the architecture leave room for?

Underhallow now has answers to these at the product level.

---

# 58. Foundation → Technical Architecture Boundary

This is the critical handoff.

The Foundation Specification says:

> **What must exist.**

The Technical Architecture Specification will say:

> **How we build it.**

For example:

| Foundation       | Technical Architecture                |
| ---------------- | ------------------------------------- |
| Isometric world  | Rendering engine / projection         |
| Player movement  | Movement controller                   |
| Personal island  | World-state architecture              |
| Unlockable grids | Data model + persistence              |
| Farming          | Crop/state system                     |
| NPC routines     | Simulation architecture               |
| Inventory        | Data structures/storage               |
| Story state      | Quest/narrative state machine         |
| Persistence      | Database/save architecture            |
| Windows PC game (Godot) | Runtime/build/deployment architecture |

We should **not skip this boundary**.

---

# 59. Agent Development Implication

When we eventually give this to agents, an agent should understand:

> "You are implementing a system inside an existing game architecture. You are not designing the entire game."

For example, a Farming Agent should not decide:

> "Actually, Underhallow should be a farming-only game."

A World Agent should not decide:

> "Let's eliminate the Personal Island."

An Economy Agent should not decide:

> "Every item should be a token."

A Multiplayer Agent should not decide:

> "We need MMO infrastructure now."

The Foundation and North Star constrain them.

---

# 60. The Underhallow Development Hierarchy

Our documentation hierarchy should become:

```text
                    UNDERHALLOW
                    NORTH STAR
                         │
                         ▼
               FOUNDATION SPECIFICATION
                         │
            ┌────────────┼────────────┐
            ↓            ↓            ↓
       GAME SYSTEMS   WORLD DESIGN   NARRATIVE
            │            │            │
            └────────────┼────────────┘
                         ↓
                TECHNICAL ARCHITECTURE
                         │
                         ↓
                  AGENT CONSTITUTION
                         │
                         ↓
                  IMPLEMENTATION PLAN
                         │
                         ↓
                      AGENTS
                         │
                         ↓
                       CODE
                         │
                         ↓
                    AUTOMATED QA
                         │
                         ↓
                     HUMAN QA
```

This is the structure I want us to maintain throughout the rebuild.

---

# 61. Foundation V1.0 Decision Register

### 🔒 Locked

* Game name: **Underhallow**
* Isometric pixel-art direction
* Cozy/nostalgic visual identity
* Dark underlying mystery
* Main Island (shared + instanced)
* Personal Island (player-owned persistent property)
* Guild Islands (guild-owned persistent islands)
* Single-player-first, multiplayer-native experience
* Windows PC initial platform (Godot Engine)
* Authoritative dedicated game servers + Supabase persistence
* Farming
* Hunting
* Building
* Exploration
* Character-driven narrative
* Player customization
* Unlockable personal-island grids
* Major milestones rather than forced ending
* Optional competition
* Native real-time cooperative multiplayer, parties, and guilds
* Fixed isometric camera with zoom (no V1 rotation)
* Optional Web3
* Game must function without Web3
* Medium-sized polished scope
* Vertical-slice-first development
* Specialized AI agents
* Controlled agent autonomy
* Human QA
* North Star cannot be silently changed by agents

### 🟡 Defined but not fully specified

* Character progression (PR-001)
* Skill progression (PR-001)
* Farming system (FB-001)
* Hunting & combat system (HU-001)
* Building & personal island system (BI-001)
* Multiplayer & social systems (MS-001)
* NPC routines (NQ-001)
* Quest architecture (NQ-001)
* Exploration system (EX-001)
* Inventory, items & crafting (II-001)
* World simulation & time (TS-001)
* Save state & persistence (SV-001)
* Island expansion

### ⚪ Explicitly deferred

* Exact economy & marketplace formulas
* Blockchain
* Token
* Real-world economic mechanics
* Exact island grid dimensions
* Pixel resolution
* Tile dimensions
* Complete crafting recipes
* Advanced combat VFX/animations
* Monetization

---

# 62. The First Development Principle

There is one principle I want sitting at the top of every future agent brief:

> ## **Do not build Underhallow as a collection of features. Build it as a world.**

The player should not experience:

> Farming System + Inventory System + Quest System + Building System.

They should experience:

> **"I'm a person living in this strange little world."**

That's the standard the architecture needs to support.
