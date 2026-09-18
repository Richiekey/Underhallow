# Underhallow

## Engine & Technical Architecture Specification V1

**Document ID:** ETA-001  
**Document Status:** Approved Foundation  
**Version:** V1.0  
**Project:** Underhallow  
**Authority Level:** Level 1 — Foundation Specification  
**Architecture Philosophy:** Single-player-first, multiplayer-native  
**Primary Platform:** Windows PC  
**Engine:** Godot  
**Backend:** Supabase + Dedicated Underhallow Game Servers  
**Parent Specifications:**
* [North Star V1.0 (NS-001)](file:///c:/Users/HP/Documents/Underhallow/docs/01-product/NORTH_STAR.md)
* [Foundation Specification V1.0 (FS-001)](file:///c:/Users/HP/Documents/Underhallow/docs/01-product/FOUNDATION_SPECIFICATION.md)
* [Master Specification Index & Build Governance V1.0 (MSI-001)](file:///c:/Users/HP/Documents/Underhallow/docs/00-governance/MASTER_SPECIFICATION_INDEX.md)

---

# 1. Purpose

This document defines the technical architecture for Underhallow.

It translates the game's established gameplay, world, multiplayer, guild, property, economy, and interaction requirements into a technical foundation capable of supporting:

* Single-player gameplay
* Real-time cooperative multiplayer
* Parties
* Guilds
* Personal properties
* Guild-owned islands
* Shared farming
* Cooperative hunting
* Gathering and exploration
* Trading
* Persistent progression
* Offline progression
* Player-driven economy
* Server-authoritative gameplay
* Future content expansion

The architecture must allow Underhallow to begin as a manageable PC game while retaining the technical foundation necessary for a substantially larger multiplayer world.

---

# 2. Core Architecture Principle

Underhallow is:

> **A single-player-first, persistent online-capable cooperative RPG/life-sim with shared-world features.**

Multiplayer is not a separate game mode.

Instead, gameplay systems are designed according to the principle:

> **Every system should work alone where appropriate and become group-capable where the gameplay naturally supports cooperation.**

Examples:

| System      |               Solo |                   Multiplayer |
| ----------- | -----------------: | ----------------------------: |
| Farming     |                Yes |                           Yes |
| Gathering   |                Yes |                           Yes |
| Hunting     |                Yes |                           Yes |
| Exploration |                Yes |                           Yes |
| Crafting    |                Yes | Cooperative where appropriate |
| Building    |           Personal |               Shared projects |
| Quests      |                Yes |                  Group quests |
| Trading     |         NPC/market |                Player trading |
| Property    |           Personal |                Guild property |
| Chat        |                N/A |                           Yes |
| Guilds      |                N/A |                           Yes |
| Events      | Solo participation |           Group participation |

The architecture must therefore avoid creating a separate "multiplayer version" of gameplay.

---

# 3. Technology Stack

## 3.1 Game Engine

Underhallow will use **Godot** as its primary game engine.

Godot is responsible for:

* Rendering
* Game scenes
* Input
* Animation
* Physics
* Navigation
* Gameplay logic
* UI
* Audio
* Client networking
* Dedicated server runtime
* Game-state simulation

The project should remain as engine-native as possible rather than introducing unnecessary external frameworks.

---

# 4. Programming Model

The primary gameplay language will be **GDScript**.

Architecture should favor:

* Small focused systems
* Composition over deep inheritance
* Data-driven configuration
* Signals/events where appropriate
* Explicit ownership
* Server/client separation
* Deterministic validation where practical

Gameplay systems should not directly depend on UI.

For example:

```text
FarmingSystem
     ↓
Game State
     ↓
UI observes state
```

rather than:

```text
FarmButton
     ↓
Directly modifies database
```

This separation is essential for multiplayer.

---

# 5. High-Level Architecture

The complete system is divided into three major layers.

```text
┌───────────────────────────────────────┐
│           UNDERHALLOW CLIENT          │
│                                       │
│ Rendering                             │
│ Input                                 │
│ UI                                    │
│ Local presentation                   │
│ Prediction                            │
│ Client-side effects                   │
└───────────────────┬───────────────────┘
                    │
                    │ Network
                    ▼
┌───────────────────────────────────────┐
│       UNDERHALLOW GAME SERVER         │
│                                       │
│ World simulation                      │
│ Player state                          │
│ Movement validation                   │
│ Combat                                │
│ Farming                               │
│ Gathering                             │
│ Inventory transactions                │
│ Party state                           │
│ Guild activity                        │
│ Instance management                   │
│ Anti-cheat validation                 │
└───────────────────┬───────────────────┘
                    │
                    │ Persistence/API
                    ▼
┌───────────────────────────────────────┐
│             SUPABASE                  │
│                                       │
│ Authentication                        │
│ Player profiles                       │
│ Persistent inventory                  │
│ Guild data                            │
│ Property ownership                    │
│ Economy records                       │
│ Transactions                          │
│ Social data                           │
│ Cloud saves                           │
│ Analytics/supporting data             │
└───────────────────────────────────────┘
```

The client is responsible for **presentation and input**.

The game server is responsible for **truth**.

Supabase is responsible for **persistent application data**.

---

# 6. Client Architecture

The Godot client handles:

### Presentation

* Rendering
* Animation
* Particles
* Audio
* Camera
* UI
* Visual effects

### Input

* Keyboard
* Mouse
* Future controller
* Remappable actions

### Local state

The client may temporarily maintain:

* Input state
* Predicted movement
* Visual animation state
* Cached world information
* UI state
* Non-authoritative effects

The client must not be trusted with valuable gameplay state.

---

# 7. Server Architecture

The Underhallow game server is authoritative.

The server owns the actual game state.

It validates:

* Movement
* Interaction
* Combat
* Gathering
* Farming actions
* Crafting
* Item creation
* Item destruction
* Trading
* Currency
* Quest rewards
* Property permissions
* Guild permissions
* Marketplace transactions
* Other economically meaningful actions

The server must never blindly accept:

```text
Client → "I obtained item X"
```

Instead:

```text
Client → "I performed action X"

Server:
    Validate action
    Validate player state
    Validate world state
    Calculate result
    Apply result
    Persist important changes
    Replicate result
```

---

# 8. Dedicated Server Model

Underhallow will use dedicated authoritative game servers rather than peer-to-peer multiplayer.

A dedicated server may run without graphical rendering.

This allows the same Godot project to support:

```text
Godot Client
Godot Dedicated Server
```

using shared gameplay code where appropriate.

The server should be capable of:

* Hosting world regions
* Managing connected players
* Processing player input
* Simulating entities
* Validating actions
* Broadcasting state
* Handling disconnects
* Saving important state

---

# 9. Server and Client Code Separation

The project must clearly distinguish:

### Shared

Code that can safely exist on both client and server.

Examples:

* Item definitions
* Stat calculations
* Data structures
* Configuration
* Basic game rules
* Serialization

### Server-only

Examples:

* Authoritative inventory changes
* Economy
* Rewards
* Ownership
* Secure random outcomes
* Anti-cheat validation
* Database writes
* Administrative functions

### Client-only

Examples:

* Rendering
* UI
* Camera
* Local visual effects
* Audio presentation
* Input handling

The architecture must prevent accidental use of server-only logic from the client.

---

# 10. World Architecture

Underhallow will not initially attempt to simulate one enormous seamless MMO world.

Instead, the world consists of connected regions.

Example:

```text
World
├── Village
├── Forest
├── Mountains
├── Swamp
├── Mines
├── Wilderness
├── Personal Properties
└── Guild Islands
```

Players perceive these as locations within the same world.

Technically, each region may be represented by an individual game instance.

---

# 11. Region Instances

A region instance is a running server-side simulation of a particular world location.

For example:

```text
Forest Instance #01
Forest Instance #02
Forest Instance #03
```

Players entering the forest can be assigned to an appropriate instance.

The player should not necessarily know that instances exist.

The transition should feel like normal travel.

---

# 12. Instance Selection

The server may consider:

* Party members
* Guild members
* Region population
* Player location
* Activity
* Event state
* Server capacity

When possible, party members travelling together should be placed into the same instance.

---

# 13. Initial Population Targets

Initial target:

* Personal property: 1–small group
* Party: approximately 4–6 players
* Public region: approximately 16–32 concurrent players
* Large events: expandable later
* Guild island: persistent and guild-controlled, with active population constrained by server capacity

These values are initial engineering targets, not permanent game-design limits.

---

# 14. World Persistence

The world must distinguish between:

### Persistent state

Examples:

* Player ownership
* Buildings
* Guild progression
* Guild island upgrades
* Crops
* Inventory
* Storage
* Economy
* Quest progression
* Character progression

### Runtime state

Examples:

* Current player movement
* Temporary enemy position
* Current combat state
* Temporary visual effects
* Active network session

Runtime state can disappear when an instance shuts down.

Persistent state must survive.

---

# 15. Offline Progression

Underhallow supports offline progression for appropriate systems.

Examples:

* Crop growth
* Animal production
* Crafting timers
* Construction timers
* Certain guild projects
* Other deterministic progression systems

The server should not simulate every world event continuously while no player is present.

Instead, systems should use timestamps or deterministic progression calculations where appropriate.

Example:

```text
crop.planted_at
crop.growth_duration
current_time
```

The server calculates the crop's current state when necessary.

This reduces infrastructure requirements while maintaining the feeling of a persistent world.

---

# 16. Personal Properties

Every player may own a personal property/farm.

Personal properties are persistent.

They contain:

* Buildings
* Crops
* Animals
* Storage
* Decorations
* Crafting stations
* Player-owned structures
* Other progression objects

The property remains owned by the player even when the player is offline.

---

# 17. Guild Islands

Guild islands are formal guild-owned properties.

A guild island is technically an instance but conceptually part of the world.

A typical flow:

```text
Main World
     ↓
Guild Island Gateway
     ↓
Guild Island Instance
```

The guild owns the island.

The guild leader does not personally own it.

Therefore the island remains available when the leader is offline.

---

# 18. Guild Island Permissions

Guild islands use permission-controlled access.

Permissions determine whether a member can:

* Build
* Destroy
* Modify structures
* Access storage
* Withdraw valuable resources
* Start projects
* Manage certain facilities
* Perform administrative actions

This integrates with the hierarchical guild-rank system.

---

# 19. Personal Plots on Guild Islands

Guild islands may contain limited personal plots.

A guild member may therefore have:

```text
Guild Island
├── Shared Guild Area
├── Guild Buildings
├── Guild Storage
├── Guild Farms
├── Member Plot A
├── Member Plot B
└── Member Plot C
```

Personal plots remain individually owned.

Shared guild infrastructure remains guild-owned.

---

# 20. Movement Architecture

Underhallow uses:

* Tile-based world structure
* Continuous/free character movement
* Isometric presentation
* Fixed camera orientation
* Zoom support

The world grid is primarily a structural and gameplay system.

Player movement should not be artificially constrained to discrete tile-by-tile movement.

---

# 21. Multiplayer Movement

Movement follows an authoritative model.

Basic flow:

```text
Player Input
      ↓
Client
      ↓
Server
      ↓
Validation
      ↓
Authoritative Position
      ↓
Replication
      ↓
Other Clients
```

Client-side prediction may be used to make movement feel responsive.

However, the server remains authoritative over the actual position.

---

# 22. Interaction Architecture

Interactions should follow:

```text
Player Input
      ↓
Interaction Request
      ↓
Server Validation
      ↓
Gameplay System
      ↓
State Change
      ↓
Persistence if necessary
      ↓
Replication
```

Examples:

### Harvesting

```text
Player interacts with crop
        ↓
Server verifies ownership/access
        ↓
Server verifies crop state
        ↓
Crop harvested
        ↓
Item awarded
        ↓
Crop state updated
```

### Gathering

```text
Player interacts with tree
        ↓
Server validates
        ↓
Resource generated
        ↓
Tree state updated
        ↓
Player inventory updated
```

---

# 23. Combat

Combat must be server-authoritative.

The client may provide:

* Input
* Animation
* Visual prediction

The server determines:

* Whether the attack occurred
* Whether it hit
* Valid range
* Target
* Damage
* Loot
* Resource effects
* Death/defeat

This prevents clients from simply modifying combat outcomes.

---

# 24. Farming

Farming is designed to function in both solo and multiplayer environments.

The server controls:

* Crop ownership
* Planting
* Growth
* Watering
* Harvesting
* Crop state
* Yield
* Resource rewards

Shared farming is supported.

Ownership remains meaningful.

Example:

```text
Alice plants crop
Bob waters crop
Alice owns resulting crop
```

The server records the relevant ownership/state information.

---

# 25. Trading

Underhallow supports:

### Direct player trading

Players must be physically present or otherwise satisfy the game's proximity/session rules.

The server controls the transaction.

### Marketplace

Players can list and purchase eligible items through a persistent marketplace.

All marketplace transactions are server-authoritative.

---

# 26. Economy Integrity

Economic transactions must be treated as sensitive operations.

Important operations should be:

* Validated
* Atomic where necessary
* Logged
* Idempotent where applicable

Examples:

```text
Item creation
Item destruction
Currency transfer
Marketplace purchase
Guild bank withdrawal
Trade completion
Reward distribution
```

The client must never be able to directly create currency or valuable items.

---

# 27. Inventory Architecture

Inventory state belongs to the authoritative player state.

The client receives a representation of inventory.

The server controls changes.

Every meaningful inventory mutation should have a clear cause.

Example:

```text
Harvest
→ Crop consumed
→ Item generated
→ Inventory increased
→ Event recorded
```

This creates an auditable chain of state changes.

---

# 28. Guild Architecture

Guilds are persistent multiplayer organizations.

A guild contains:

* Identity
* Members
* Ranks
* Permissions
* Reputation/renown
* Level
* Guild storage
* Guild island
* Guild progression
* Guild quests
* Guild projects
* Activity history

Guild membership must be persistent independently of active sessions.

---

# 29. Guild Permissions

Guild ranks use hierarchical permissions.

Potential permission categories include:

* Invite members
* Remove members
* Promote/demote
* Access storage
* Withdraw resources
* Build
* Modify buildings
* Manage guild projects
* Manage island
* Manage guild settings

Permissions should be data-driven rather than hard-coded exclusively around rank names.

---

# 30. Guild Bank

Guild storage is shared.

However, access is permission-controlled.

Example:

```text
Common materials → broad access
Rare resources → officer access
High-value assets → restricted access
Administrative assets → leader/authorized ranks
```

Guild transactions should be logged.

---

# 31. Party Architecture

Parties are temporary cooperative groups.

A party can contain players:

* From the same guild
* From different guilds
* With no guild affiliation

Target party size:

**4–6 players.**

Parties support:

* Shared activities
* Group quests
* Hunting
* Exploration
* Boss encounters
* Cooperative gathering
* Appropriate reward distribution

Party membership does not replace guild membership.

---

# 32. Disconnect and Reconnection

The server must handle unreliable connections gracefully.

When a player disconnects:

1. Server detects disconnect.
2. Character enters a short protected/reconnect state.
3. Important state is preserved.
4. Player can reconnect to the active session.
5. If reconnection fails, the character exits safely.
6. Persistent state is finalized.

Target reconnect window:

**Approximately 2–5 minutes.**

Exact timing may be tuned during testing.

---

# 33. Combat Disconnect Protection

Players must not be able to exploit disconnections to avoid consequences indefinitely.

During combat:

* The server retains control of the player's state.
* A short protection/grace period may apply.
* The character cannot simply disappear instantly to invalidate an ongoing combat outcome.

The exact combat-disconnect rules should be tuned during gameplay testing.

---

# 34. Chat Architecture

V1 supports:

* Local/proximity chat
* Party chat
* Guild chat
* Direct/private messages

Global chat is not a core V1 requirement.

Voice chat is deferred.

Chat should be implemented as a multiplayer service rather than tightly coupling communication to gameplay systems.

---

# 35. Authentication

Online functionality requires authenticated accounts.

The architecture should support:

### Initial

* Email authentication
* Google authentication

### Future

* Steam authentication
* Additional providers

Wallet authentication is **not required** for core gameplay.

A wallet should never be required simply to play Underhallow.

---

# 36. Account vs Character

The architecture should distinguish between:

### Account

Represents the player identity.

Contains:

* Authentication
* Account-level settings
* Social identity
* Online permissions

### Character

Represents the in-game identity.

Contains:

* Appearance
* Progression
* Inventory
* Property
* Relationships
* Quests
* Gameplay state

This allows future expansion to multiple characters if desired.

---

# 37. Save Architecture

Underhallow supports:

### Local save

Useful for:

* Offline gameplay
* Local progression
* Development
* Offline-compatible systems

### Cloud/persistent save

Used for authenticated online players.

Persistent online state must ultimately be authoritative on the server/backend.

Multiple save slots/worlds may be supported.

---

# 38. Supabase Responsibilities

Supabase is the persistent application backend.

It is responsible for appropriate data such as:

* Authentication
* Player profiles
* Character persistence
* Guild persistence
* Property ownership
* Inventory persistence
* Marketplace records
* Economy records
* Transactions
* Social relationships
* Cloud saves
* Supporting analytics

Supabase should not become the primary real-time simulation engine.

---

# 39. Database Architecture

Persistent data should be organized around clear domains.

Conceptually:

```text
Accounts
Characters
Properties
Guilds
Guild Members
Guild Islands
Inventory
Items
Transactions
Marketplace
Quests
Progression
Social
```

Database schemas should favor clear ownership relationships and strong constraints.

Security-sensitive mutations should not rely solely on client-side database access.

---

# 40. Server-to-Database Architecture

The game server should mediate sensitive game-state persistence.

Preferred flow:

```text
Game Client
    ↓
Game Server
    ↓
Validation
    ↓
Game State
    ↓
Persistent Backend
```

Not:

```text
Game Client
    ↓
Directly modify valuable game state
```

This distinction is fundamental to Underhallow's security model.

---

# 41. Transaction Safety

Important economic operations should be designed to avoid duplication or partial completion.

For example:

```text
Trade:
Player A item -1
Player B item -1
Player A item +1
Player B item +1
```

The entire transaction must either complete correctly or fail safely.

The system must protect against:

* Double submission
* Network retries
* Duplicate requests
* Disconnects
* Race conditions
* Client manipulation

---

# 42. Anti-Cheat Architecture

Underhallow's primary anti-cheat mechanism is server authority.

The server validates:

* Movement
* Action frequency
* Interaction range
* Resource gathering
* Combat
* Inventory
* Currency
* Trading
* Marketplace
* Quest rewards

Suspicious behavior may be logged for later analysis.

V1 does not require kernel-level anti-cheat.

---

# 43. Client Trust Boundary

The client should be treated as potentially compromised.

Therefore:

> **Never trust the client with authoritative economic or gameplay state.**

The client may request:

```text
Attack
Move
Harvest
Trade
Craft
Interact
```

The server decides whether those actions are valid.

---

# 44. Input Architecture

Underhallow uses action-based input.

Instead of gameplay code directly depending on:

```text
W
A
S
D
```

systems should use actions such as:

```text
move_up
move_down
move_left
move_right
interact
attack
inventory
map
```

This allows:

* Keyboard
* Mouse
* Controller
* Remapping
* Future accessibility features

without rewriting gameplay systems.

---

# 45. Controller Support

Controller support is not a primary V1 implementation requirement.

However, the architecture must remain controller-ready.

This avoids building the game around keyboard-only assumptions.

---

# 46. Camera Architecture

V1 camera:

* Isometric
* Fixed orientation
* Follow player
* Zoomable
* Region-aware boundaries

Camera rotation is excluded from V1.

This simplifies:

* Tile rendering
* Building orientation
* Sprite production
* World design
* Navigation
* Visual consistency

---

# 47. Performance Target

Primary target:

**60 FPS**

on the intended low-to-mid-range PC target.

The architecture should prioritize:

* Efficient scene management
* Object lifecycle management
* Instance unloading
* Network relevance
* Entity visibility
* Asset optimization
* Avoiding unnecessary simulation

Performance should be measured on realistic target hardware rather than development PCs alone.

---

# 48. Network Relevance

The server should not broadcast every piece of world state to every player.

For example:

A player in Village A does not need continuous updates for:

* every entity in a distant mine
* every player in another guild island
* every animal on a distant farm

The server should replicate relevant state based on:

* Region
* Distance
* Activity
* Party
* Guild
* Interaction
* Visibility

This becomes increasingly important as world populations grow.

---

# 49. Region Loading

Client-side world loading should be asynchronous where practical.

The game should avoid freezing during region transitions.

Potential flow:

```text
Player approaches transition
        ↓
Load required assets
        ↓
Request region/session
        ↓
Connect/transfer
        ↓
Spawn player
        ↓
Begin gameplay
```

---

# 50. Asset Architecture

Game assets should be organized by domain.

Conceptually:

```text
assets/
├── characters/
├── creatures/
├── environment/
├── buildings/
├── items/
├── crops/
├── weapons/
├── UI/
├── effects/
├── audio/
└── world/
```

Gameplay code should reference assets through controlled definitions rather than scattering file paths throughout scripts.

---

# 51. Data-Driven Content

Where practical, content should be data-driven.

Examples:

### Item definition

```text
Item ID
Name
Category
Stack size
Value
Tradable
Giftable
Guild-only
Bound
Icon
World representation
```

### Crop definition

```text
Crop ID
Growth duration
Seed item
Harvest item
Yield
Growth stages
Season/environment rules
```

This allows content expansion without rewriting core systems.

---

# 52. Entity Architecture

Major world entities should have clear identity and ownership.

Examples:

* Player
* NPC
* Animal
* Enemy
* Crop
* Resource node
* Building
* Item container
* Guild structure

Each entity should have an appropriate authoritative state.

Persistent entities require persistent identifiers.

Temporary entities may exist only within a server instance.

---

# 53. World Object Lifecycle

A world object may exist in three broad states:

```text
Persistent definition
       ↓
Runtime instance
       ↓
Destroyed/despawned
```

Example:

A tree definition exists in the world.

A runtime tree exists in a forest instance.

When chopped, its runtime state changes.

Its persistent regeneration state can be stored without requiring the actual tree object to remain active while nobody is present.

---

# 54. Time Architecture

Underhallow enforces a **single authoritative simulation-clock model** (codified in Architecture Audit A-001). All game systems, world processes, and derived calendar states flow strictly from one canonical source of truth.

### 54.1 Authoritative Simulation Contract

The runtime time architecture operates under a strict, unidirectional data flow:

```text
GameTime.elapsed_seconds (Sole Authoritative Simulation Clock)
        │
        ▼
GameState.game_time_elapsed (Synchronized State / Persistence Mirror)
        │
        ▼
TimeState (Derived Calendar State)
        │
        ├── current_day
        ├── day progress
        └── calendar-derived state
                │
                ▼
Simulation Consumers (Farming, Day/Night, Schedules, Wildlife, Environment)
```

### 54.2 Core Time Distinctions

The architecture cleanly separates three distinct operational concepts of time without introducing competing clocks:

1. **Deterministic Simulation Time (`GameTime.elapsed_seconds`):**
   * **Sole Authority:** `GameTime.elapsed_seconds` is the single authoritative simulation clock for all runtime gameplay and world simulation.
   * **Scope:** Governs active movement, combat, AI, interaction loops, crop growth, day/night cycles, NPC schedules, and environmental systems.
   * **Determinism:** Advances via deterministic simulation ticks (`advance_time(delta)`), never raw unscaled frame delta accumulation.

2. **Synchronized State Mirror (`GameState.game_time_elapsed`):**
   * `GameState.game_time_elapsed` is a synchronized state and persistence mirror, not an independent or secondary clock.
   * It provides a clean, serializable representation of simulation time for state snapshots, netcode synchronization, and save persistence.

3. **Derived Calendar & World State (`TimeState`):**
   * `TimeState` is a projection of simulation time into game calendar concepts (`current_day`, day progress ratio, hour, minute, and ticks).
   * It is derived strictly from `GameTime.elapsed_seconds` and the configured day duration.
   * **Invariant:** `TimeState` must never independently advance simulation time. Any direct mutation of `TimeState` is neutralized; all time advancement flows down from `GameTime`.

4. **Real-World / Wall-Clock Time (Wall-Clock Timestamps):**
   * Real-world UTC timestamps are metadata and input parameters used solely for calculating elapsed offline time during login/island load catch-up routines.
   * Real-world time is never authoritative simulation state and cannot directly mutate active simulation time.

### 54.3 Persistence Restoration Flow

Persistence serializes and restores canonical simulation time strictly through `GameTime`:

```text
SaveData.game_time_elapsed
        ↓
    GameTime
        ↓
    TimeState
```

1. **Save:** `GameState.game_time_elapsed` (mirrored from `GameTime.elapsed_seconds`) is serialized into `SaveData.game_time_elapsed`.
2. **Load:** The persistence boundary restores `GameTime.elapsed_seconds` directly from `SaveData.game_time_elapsed`.
3. **Propagation:** `GameTime` updates `GameState` and derives `TimeState`, ensuring full mathematical parity and eliminating time divergence across save/load cycles.

### 54.4 Deliberate Time Advancement & Sleep

* Sleep (e.g., player sleeping in a cottage bed) and deliberate time advancement operations advance `GameTime.elapsed_seconds` directly via commands (e.g., `SleepCommand` executing with `GameTime` context).
* `TimeState` updates as a downstream reaction to `GameTime` advancement.
* `TimeState` is prohibited from skipping days or modifying calendar progress independently of `GameTime`.

### 54.5 Offline Progression & Catch-Up Mechanics

```text
Wall-clock timestamp (Logout / Login Delta)
        ↓
Metadata / Offline Elapsed-Time Input
        ↓
Never Authoritative Simulation State
        ↓
Server / Local Catch-Up Calculation
        ↓
Advance GameTime (Authoritative)
```

When an island or player session is unloaded:
* Active tick accumulation pauses.
* Upon reconnect or island load, real-world timestamps provide the elapsed duration metadata.
* The system evaluates offline progression (e.g., crop maturation, water absorption) by calculating the equivalent simulated time and advancing `GameTime` deterministically, maintaining authoritative simulation integrity without running 24/7 background processes.

---

# 55. AI Architecture

NPC and creature AI should primarily run on the server when their behavior has gameplay consequences.

Clients receive the resulting state.

Examples:

```text
Animal moves
Enemy attacks
NPC changes position
Creature flees
```

Client may interpolate the movement visually.

The server remains authoritative.

---

# 56. Persistence Frequency

Not every state change should immediately result in a database write.

High-frequency runtime state should remain in memory.

Persistent changes should be written at appropriate checkpoints.

Examples of persistence-worthy events:

* Inventory mutation
* Ownership change
* Completed transaction
* Property modification
* Guild modification
* Quest progression
* Important character progression

This reduces database load.

---

# 57. Graceful Failure

The architecture must assume failures occur.

Potential failures:

* Client disconnect
* Server crash
* Database timeout
* Duplicate request
* Network packet loss
* Region shutdown
* Backend outage

Critical operations must fail safely.

The design principle is:

> **A failure should not create free items, duplicate currency, corrupt ownership, or permanently destroy valid progression.**

---

# 58. Development Environment

During development, developers should be able to run:

```text
Godot Client
+
Local Dedicated Server
+
Local/Test Backend
```

A developer should be able to simulate:

* Solo gameplay
* Two-player multiplayer
* Party gameplay
* Guild interactions
* Disconnects
* Reconnects
* Server failures

without requiring production infrastructure.

---

# 59. Local Multiplayer Testing

The project should support launching multiple clients locally.

Example:

```text
Server
 ├── Client 1
 ├── Client 2
 ├── Client 3
 └── Client 4
```

This will be important for testing:

* Movement synchronization
* Combat
* Trading
* Farming
* Party systems
* Guild permissions
* Chat
* Shared building

---

# 60. Production Deployment

The intended progression is:

### Stage 1 — Development

Local server.

### Stage 2 — Closed testing

Small cloud/VPS deployment.

### Stage 3 — Beta

Dedicated production servers with monitoring.

### Stage 4 — Scale

Multiple regional/server instances and automated provisioning as player population requires.

Infrastructure should grow according to actual demand.

---

# 61. Distribution

Initial development builds may be distributed directly.

Long-term distribution can include:

* Steam
* Official website
* Additional PC storefronts if justified

A custom launcher is not required for V1.

Distribution platforms should handle updates where practical.

---

# 62. Cross-Platform Architecture

Windows is the primary V1 target.

However, gameplay code should avoid unnecessary Windows-specific dependencies.

Architecture should remain capable of supporting:

* Linux
* macOS

later.

The server should ideally run independently of the player's operating system.

---

# 63. Web3 Boundary

Web3 is optional and must not be foundational to Underhallow's ability to function.

The game should remain playable without:

* Wallets
* Tokens
* NFTs
* Blockchain transactions

If blockchain features are introduced later, they should integrate with the existing ownership/economy architecture rather than dictate it.

---

# 64. Modding

Modding is not a V1 requirement.

However, systems should avoid making future extensibility impossible.

Data-driven content and clean separation between game systems and assets will provide a foundation for future modding if desired.

---

# 65. Security Principles

The following principles are mandatory:

1. Never trust client-provided economic values.
2. Never allow clients to directly create valuable items.
3. Validate movement server-side.
4. Validate interaction ranges server-side.
5. Validate rewards server-side.
6. Validate ownership server-side.
7. Validate permissions server-side.
8. Make important transactions atomic.
9. Make important requests idempotent where appropriate.
10. Log economically meaningful operations.
11. Treat disconnects as normal network failures, not trusted events.
12. Keep secrets out of the client.
13. Never embed privileged backend credentials in the game client.

---

# 66. Architectural Ownership Model

Underhallow's multiplayer ownership hierarchy is:

```text
WORLD
 │
 ├── GUILD
 │    ├── Guild Island
 │    ├── Guild Buildings
 │    ├── Guild Storage
 │    └── Guild Projects
 │
 ├── PARTY
 │    └── Temporary cooperative activity
 │
 └── PLAYER
      ├── Character
      ├── Inventory
      ├── Property
      ├── Progression
      └── Personal Assets
```

This hierarchy should remain consistent throughout gameplay systems.

---

# 67. System Design Rule

Every new gameplay feature must answer:

### 1. Can it work solo?

### 2. Can it support multiplayer?

### 3. Who owns the resulting state?

### 4. Who has permission to modify it?

### 5. What does the server validate?

### 6. What must persist?

### 7. What happens if the player disconnects?

### 8. What happens if the server crashes?

This becomes an architectural checklist for every future system.

---

# 68. V1 Technical Scope

V1 architecture should support:

* Single-player
* Real-time multiplayer
* Parties
* Guilds
* Personal properties
* Guild islands
* Farming
* Gathering
* Hunting
* Exploration
* Inventory
* Crafting
* Trading
* Chat
* Quests
* Persistent progression
* Offline progression
* Server-authoritative gameplay

V1 does **not** require:

* Massive MMO-scale populations
* Voice chat
* Kernel anti-cheat
* Controller-first development
* Camera rotation
* Seamless infinite world
* Full modding framework
* Mandatory blockchain integration
* Custom launcher

---

# 69. Scalability Philosophy

Underhallow should be designed for expansion without being built at MMO scale prematurely.

The architecture should scale horizontally where appropriate:

```text
Players
   ↓
Region Instances
   ↓
Multiple Game Servers
   ↓
Persistent Backend
```

Instead of:

```text
One enormous server
```

This allows the game to grow organically.

---

# 70. Future Expansion

The architecture should be capable of eventually supporting:

* Larger guilds
* More regions
* More players per region
* Seasonal events
* Larger cooperative encounters
* More sophisticated AI
* More complex guild systems
* Additional platforms
* Steam integration
* Voice communication
* Expanded economy
* Optional Web3 systems
* Modding
* Additional server regions

None of these should dictate V1 implementation.

---

# 71. Non-Negotiable Architectural Principles

The following principles are considered foundational:

### Principle 1 — Single-player must remain first-class

A player should never feel like they are playing an incomplete multiplayer game when alone.

### Principle 2 — Multiplayer must be native

We must not build the game in a way that makes future multiplayer require rewriting the entire gameplay layer.

### Principle 3 — Server owns truth

The client requests actions.

The server determines outcomes.

### Principle 4 — Supabase is persistence, not the game loop

The dedicated game server handles real-time gameplay.

### Principle 5 — Economy is authoritative

Currency, valuable items, ownership and transactions must be server-controlled.

### Principle 6 — Persistence should be selective

Only state that needs persistence should be persisted.

### Principle 7 — World simulation should be scalable

Regions and instances are preferred over one monolithic world simulation.

### Principle 8 — Fail safely

Disconnects and infrastructure failures must not create economic exploits or destroy legitimate progression.

### Principle 9 — Build for the actual V1

Do not prematurely implement MMO-scale infrastructure.

### Principle 10 — Preserve future options

V1 architecture should not unnecessarily prevent future multiplayer scale, additional platforms, or deeper social systems.

---

# 72. Reference Architecture

The resulting Underhallow architecture can be summarized as:

```text
                    UNDERHALLOW
                         │
              ┌──────────┴──────────┐
              │                     │
          GODOT CLIENT         GAME SERVER
              │                     │
       ┌──────┼──────┐       ┌──────┼─────────┐
       │      │      │       │      │         │
     Input  Render   UI    World  Gameplay  Validation
                              │      │         │
                              └──────┼─────────┘
                                     │
                              Persistent State
                                     │
                                     ▼
                                  SUPABASE
                                     │
             ┌───────────────────────┼───────────────────────┐
             │           │           │          │            │
          Accounts    Characters   Guilds    Economy     Properties
             │           │           │          │            │
             └───────────┴───────────┴──────────┴────────────┘
```

The fundamental flow is:

```text
PLAYER INPUT
     ↓
GODOT CLIENT
     ↓
GAME SERVER
     ↓
VALIDATION
     ↓
GAMEPLAY SIMULATION
     ↓
AUTHORITATIVE STATE
     ↓
PERSISTENCE WHEN REQUIRED
     ↓
STATE REPLICATION
     ↓
CLIENT PRESENTATION
```

---

# 73. Final Architecture Statement

Underhallow will be built as a **single-player-first, multiplayer-native PC game** using Godot.

The client provides the player's experience and presentation.

Dedicated authoritative game servers provide the real-time multiplayer simulation and enforce gameplay integrity.

Supabase provides persistent application data, authentication, economy records, social data, guild persistence, property ownership and other long-lived state.

The world is composed of connected regions and instances rather than attempting to simulate an enormous seamless MMO world from the beginning.

Players can live independently, maintain personal properties, farm, hunt, explore and progress alone.

When they choose to socialize, the same underlying systems support parties, guilds, cooperative activities, shared farming, trading, guild islands, guild projects and shared events.

The architecture therefore follows a single central principle:

> **Underhallow should never require multiplayer to be a complete game, but it should never make multiplayer feel like an afterthought.**

This principle governs all future technical and gameplay architecture decisions.
