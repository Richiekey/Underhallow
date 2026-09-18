# Underhallow

## Specification Reconciliation V1.0

**Document ID:** SR-001  
**Version:** V1.0  
**Status:** Reconciliation Baseline  
**Authority Level:** Project Governance & Architecture Reconciliation  
**Purpose:** Reconcile the existing Underhallow specification library with the latest founder-approved design decisions.  
**Scope:** Authority hierarchy, platform, engine, multiplayer, world architecture, player control, gameplay systems, guilds, parties, economy, persistence, and documentation dependencies.  
**Parent Specifications:**
* [North Star V1.0 (NS-001)](file:///c:/Users/HP/Documents/Underhallow/docs/01-product/NORTH_STAR.md)
* [Foundation Specification V1.0 (FS-001)](file:///c:/Users/HP/Documents/Underhallow/docs/01-product/FOUNDATION_SPECIFICATION.md)
* [Engine & Technical Architecture Specification V1 (ETA-001)](file:///c:/Users/HP/Documents/Underhallow/docs/02-architecture/ENGINE_TECHNICAL_ARCHITECTURE_SPECIFICATION.md)
* [Master Specification Index & Build Governance V1.0 (MSI-001)](file:///c:/Users/HP/Documents/Underhallow/docs/00-governance/MASTER_SPECIFICATION_INDEX.md)

---

# 1. Executive Summary

Underhallow has progressed substantially beyond its original browser-first, single-player foundation.

The repository currently contains three architectural generations:

### Generation 1 — Original Foundation

The original North Star and Foundation documents establish:

* Browser as the initial platform.
* Single-player as the initial mode.
* Phaser/TypeScript-era technical assumptions.
* Future multiplayer as a possibility rather than a foundational architecture requirement.

The original North Star explicitly identifies Browser as the initial platform and Single-player as the initial mode.

### Generation 2 — Engine Architecture Transition

`ETA-001` establishes the new technical foundation:

* Windows PC
* Godot
* GDScript
* Dedicated authoritative game servers
* Supabase persistence
* Single-player-first, multiplayer-native architecture
* Real-time cooperative multiplayer
* Guilds
* Parties
* Personal properties
* Guild islands
* Server-authoritative economy and gameplay

`ETA-001` is already registered in the MSI as the approved Level 1 foundation and the previous browser/Phaser architecture is marked superseded.

### Generation 3 — Current Gameplay Design

Subsequent design work has gone beyond ETA-001.

The current intended Underhallow model now includes:

* Real-time cooperative multiplayer.
* Parties independent of guild membership.
* Guilds with membership caps.
* Guild-owned islands.
* Limited personal plots on guild islands.
* Guild hierarchy and permissions.
* Guild banks.
* Shared farming.
* Cooperative hunting.
* Direct player trading.
* Marketplace trading.
* Guild progression.
* Guild quests.
* Guild chat.
* Party chat.
* Direct messages.
* Local/proximity chat.
* Persistent personal properties.
* Offline progression.
* Graceful disconnect/reconnect.
* No stamina.
* No V1 PvP, aside from the possibility of later limited competitive systems.
* Fixed isometric camera with zoom and **no V1 camera rotation**.
* Dedicated server authority for economically meaningful actions.

These decisions now need to be distributed through the appropriate specifications.

---

# 2. Reconciliation Principle

The existing MSI provides the correct governance model:

> Higher-authority specifications govern lower-authority specifications, and conflicts must be formally resolved rather than silently choosing one document over another.

Therefore, our reconciliation does **not** mean:

> "ETA-001 automatically overwrites everything."

Instead:

```text
Founder Decision
       ↓
Change / Reconciliation
       ↓
Highest affected authority updated
       ↓
Foundation specifications updated
       ↓
System specifications updated
       ↓
MSI dependencies/statuses updated
       ↓
Implementation follows reconciled source of truth
```

---

# 3. Authority State After Reconciliation

The intended hierarchy becomes:

```text
LEVEL 0
│
├── NS-001 North Star
│      ↓
├── AC-001 Agent Constitution
│
LEVEL 1
│
├── ETA-001 Engine & Technical Architecture
├── CG-001 Core Gameplay
├── PC-001 Player Control
└── WM-001 World & Map
│
LEVEL 2
│
├── PR-001 Player Progression
├── FA/FB-001 Farming
├── HU/HC-001 Hunting & Combat
├── BI-001 Building & Personal Island
├── NQ-001 NPC / Dialogue / Quest
├── EX-001 Exploration
├── II-001 Inventory / Items / Crafting
├── TS-001 Time / Simulation
├── EC-001 Economy
└── ST-001 Story / Narrative
│
LEVEL 3+
│
└── Implementation / QA / supporting systems
```

The major difference is that **multiplayer is no longer merely a future supporting feature**.

It is now a cross-cutting architectural capability.

---

# 4. Reconciliation #1 — Platform

## Existing state

The North Star says:

> Initial Platform: Browser

The Foundation Specification also identifies Browser as the initial platform.

## Current decision

Underhallow is now:

> **Windows PC-first**

with future architecture remaining open to Linux/macOS.

## Resolution

The platform decision must be formally updated in the North Star and Foundation Specification.

The old browser-first direction becomes historical/superseded rather than remaining an active contradiction.

## Result

```text
OLD
Browser-first

NEW
Windows PC-first
```

Browser support may remain a possible future distribution target, but it is no longer the primary V1 platform.

---

# 5. Reconciliation #2 — Engine

## Existing state

The old technical architecture was based on the browser/Phaser implementation model.

The MSI already records:

> TA-001 — Technical Architecture (Browser/Phaser Prototype Baseline) — SUPERSEDED

and:

> ETA-001 — Engine & Technical Architecture — APPROVED.

## Current decision

Godot is the authoritative engine.

## Resolution

No new engine specification is required.

`ETA-001` remains the governing engine specification.

The old `TECHNICAL_ARCHITECTURE.md` remains historical/superseded.

---

# 6. Reconciliation #3 — Multiplayer Philosophy

This is the largest design change.

## Existing North Star

The original North Star says multiplayer is not part of the initial game and should only be considered later.

## ETA-001

ETA-001 has already moved beyond this and defines:

> **Single-player-first, multiplayer-native.**

It also defines real-time cooperative multiplayer, parties, guilds, personal properties, guild islands and server authority.

## Current decision

The latest decision is stronger and more specific:

> **Underhallow remains fully playable as a single-player game, but every gameplay system that naturally supports groups should be architected to support real-time multiplayer.**

Therefore:

```text
Single-player
      +
Real-time cooperative multiplayer
      +
Persistent social systems
```

is the target.

## Resolution

The North Star and Foundation Specification must be updated so they no longer describe multiplayer as merely a distant possibility.

Multiplayer becomes part of the long-term product architecture while remaining non-mandatory for the player.

---

# 7. Reconciliation #4 — Underhallow Is Not an MMO

The multiplayer expansion must not accidentally redefine Underhallow as an MMO.

The current design is:

> **Single-player-first persistent online-capable cooperative RPG/life-sim with shared-world features.**

It is explicitly **not**:

* MMO-first
* mandatory-online
* PvP-first
* massively populated
* raid-centric
* subscription-dependent

The architecture uses instances and controlled player populations precisely to prevent premature MMO complexity.

---

# 8. Reconciliation #5 — World Structure

The existing world specification establishes:

```text
Main Island
     +
Personal Island
```

with boat/dock travel between them.

This remains valid.

The new multiplayer architecture adds another layer:

```text
Underhallow World
│
├── Main Island
│    ├── Town
│    ├── Wilderness
│    ├── Forest
│    ├── Hunting areas
│    └── Other regions
│
├── Personal Islands
│
└── Guild Islands
```

Technically, public regions and guild islands may be instanced.

This does **not** invalidate the authored world structure.

The distinction is:

> **World design describes what the player experiences. Technical architecture describes how the game runs it.**

---

# 9. Reconciliation #6 — Main Island Multiplayer

The Main Island remains the primary shared world.

It should support:

* Solo exploration.
* Meeting other players.
* Parties.
* Hunting together.
* Gathering together.
* Events.
* Trading.
* Social interaction.

Normal regions initially target approximately:

**16–32 concurrent players.**

This is an engineering target rather than a permanent design limit.

---

# 10. Reconciliation #7 — Personal Islands

The existing Personal Island design remains authoritative as the player's:

* Home
* Farm
* Building space
* Long-term property
* Expression space

The new architecture adds:

* Persistent server-backed state.
* Controlled visitor access.
* Future multiplayer interaction.
* Offline progression.

Personal ownership remains individual.

---

# 11. Reconciliation #8 — Guild Islands

This is a new major world category.

Guild islands are:

* Guild-owned.
* Persistent.
* Instanced.
* Accessible without the guild leader being online.
* Permission-controlled.
* Capable of containing shared guild facilities.
* Capable of containing limited personal member plots.

Ownership hierarchy:

```text
Player
   ↓
Personal Property

Guild
   ↓
Guild Island
   ├── Shared Areas
   ├── Guild Buildings
   ├── Guild Storage
   ├── Guild Farms
   └── Member Personal Plots
```

Guild islands therefore become a formal part of world architecture rather than merely a social feature.

---

# 12. Reconciliation #9 — Guilds

Guilds are now a persistent gameplay/social system.

Current decisions:

### Membership

Initial target:

**~50 members**

with potential expansion through guild progression.

### Ranks

Hierarchical ranks with permissions.

### Storage

Shared guild bank.

### Access

Permission-controlled.

### Progression

Guild levels + reputation/renown.

### Unlocks

Potentially:

* More members
* Larger island
* Buildings
* Storage
* Quests
* Cosmetics
* Special resources
* Group activities

### Guild quests

Supported.

### Guild leader absence

Succession policy is configurable.

### Guild island abandonment

Guild islands can eventually be lost through abandonment rather than default PvP conquest.

---

# 13. Reconciliation #10 — Parties

Parties are separate from guilds.

A player can party with:

* Guild members
* Players from other guilds
* Unguilded players

Target:

**4–6 players.**

Parties support:

* Hunting
* Exploration
* Quests
* Gathering
* Events
* Cooperative activities

A player can therefore participate socially without committing to a guild.

---

# 14. Reconciliation #11 — Shared Farming

Farming remains individually owned where ownership matters.

However, multiplayer participation is supported.

Example:

```text
Alice plants
Bob waters
Charlie helps maintain
Alice owns resulting crop
```

The server must preserve ownership while allowing cooperation.

This distinction is important:

> **Participation does not automatically equal ownership.**

---

# 15. Reconciliation #12 — Hunting

The Hunting specification already supports a much deeper hunting economy than the early foundation documents implied.

It explicitly supports:

* Hunting as a lifestyle.
* Resource harvesting.
* Raw selling.
* Processing.
* Using resources.
* Trading.
* Hunting specialization.

One recent founder clarification must be preserved:

> **Hunters are never forced to process their kills.**

They may sell raw materials at a lower value.

Processing provides higher potential value but is optional.

Therefore:

```text
Raw material
    ↓
Sell cheaply

OR

Process
    ↓
Higher-value material
    ↓
Sell / craft / use
```

This is already aligned with the Hunting specification.

---

# 16. Reconciliation #13 — Stamina

This is already correctly resolved in Core Gameplay.

V1 has:

> **No stamina or energy system.**

The replacement constraints are:

* Inventory capacity
* Time
* Risk
* Player choice

The recent multiplayer architecture does not change this.

Stamina must remain excluded unless explicitly reintroduced through a future approved change.

---

# 17. Reconciliation #14 — Defeat and Resource Loss

The Core Gameplay specification already establishes the expedition-loss model:

* Permanent progression remains.
* Current expedition resources are lost on defeat.
* Player returns home.
* Time is lost.

This remains authoritative.

Multiplayer does not change the fundamental rule.

The multiplayer implementation must simply define how it behaves when:

* A player is defeated during a party activity.
* A player disconnects.
* Multiple players are involved in a hunt.
* Loot is shared.

Those details belong in the relevant multiplayer/economy implementation specifications.

---

# 18. Reconciliation #15 — Camera

This is a direct conflict.

## Existing PC-001

PC-001 currently specifies:

> Player-controlled 90° camera rotation.

## Current decision

We accepted:

> **Fixed isometric camera, zoomable, no V1 rotation.**

Therefore PC-001 is now inconsistent with the current architecture.

## Resolution

Change:

```text
Camera rotation:
90° player-controlled rotation
```

to:

```text
Camera rotation:
Disabled in V1

Camera:
Fixed isometric orientation
Player-controlled zoom
Smooth follow
Controlled look-ahead where appropriate
```

This is a required reconciliation.

---

# 19. Reconciliation #16 — Input

PC-001 already has a strong input abstraction.

It defines conceptual actions rather than hardcoding physical devices:

* Move
* Interact
* Tool
* Attack
* Inventory
* Map
* Hotbar
* Cancel

This is compatible with the new architecture.

Current decision:

### V1

Keyboard + mouse.

### Architecture

Controller-ready.

Therefore:

**No major redesign required.**

---

# 20. Reconciliation #17 — Movement

PC-001 already establishes:

* Free movement.
* WASD.
* Arrow keys.
* Click-to-move.
* Normalized diagonal movement.
* No sprint.
* Contextual interaction.
* Context-dependent facing.

ETA-001 establishes authoritative multiplayer movement.

These systems are compatible.

The resulting architecture becomes:

```text
Input
 ↓
Local movement/prediction
 ↓
Server validation
 ↓
Authoritative position
 ↓
Replication
```

The player-facing control specification and technical specification therefore complement each other rather than compete.

---

# 21. Reconciliation #18 — Camera vs World Architecture

The World specification assumes isometric presentation and PC-001 currently assumes rotation.

The new decision removes rotation.

Therefore the world architecture should be treated as optimized around:

> **One consistent isometric orientation.**

This simplifies:

* Pixel-art production.
* Building orientation.
* Collision.
* Navigation.
* Map readability.
* Asset requirements.

---

# 22. Reconciliation #19 — Offline Progression

The current architecture supports offline progression.

Appropriate systems may continue progressing while the player is offline:

* Crops
* Animal production
* Crafting timers
* Construction
* Certain guild projects

But Underhallow should not simulate every entity continuously while nobody is present.

The correct model is:

```text
Persisted timestamp/state
        ↓
Player returns
        ↓
Server calculates elapsed progression
        ↓
New authoritative state
```

This remains compatible with the existing world simulation philosophy.

---

# 23. Reconciliation #20 — Disconnects

This is a new multiplayer implementation requirement.

When a player disconnects:

1. Server detects disconnection.
2. Player enters a temporary reconnect state.
3. Important state is preserved.
4. Player may reconnect to the session.
5. If reconnection fails, the player exits safely.

Target reconnect window:

**2–5 minutes.**

Combat requires additional protection against disconnect exploitation.

---

# 24. Reconciliation #21 — Communication

New social architecture:

### V1

* Local/proximity chat
* Party chat
* Guild chat
* Direct/private messages

### Later

* Voice chat
* Potential broader/global communication

Voice is deliberately deferred.

---

# 25. Reconciliation #22 — PvP

The current multiplayer model does **not** require PvP.

V1 should prioritize:

* Cooperation
* Exploration
* Farming
* Hunting
* Trading
* Guild activities
* Events

Competitive systems may exist later as optional trails/events.

PvP should not become foundational to the game.

---

# 26. Reconciliation #23 — Economy

The existing economic philosophy remains:

> Build a compelling game economy first.

Web3 remains optional.

Multiplayer adds:

* Direct player trading.
* Marketplace.
* Guild banks.
* Shared economic activities.

Server authority remains mandatory for:

* Currency
* Items
* Trades
* Marketplace
* Guild storage
* Rewards
* Ownership

---

# 27. Reconciliation #24 — Server Authority

ETA-001 establishes the correct authority model.

The client requests actions.

The server determines outcomes.

This applies particularly to:

* Combat
* Movement validation
* Farming
* Hunting
* Inventory
* Trading
* Currency
* Guild permissions
* Ownership
* Rewards

The client must never be treated as the authority over economically valuable state.

---

# 28. Reconciliation #25 — Supabase

Supabase remains appropriate for:

* Authentication
* Persistent player data
* Guild data
* Property ownership
* Inventory persistence
* Economy records
* Transactions
* Social data
* Cloud persistence

It is **not** the real-time game simulation.

The dedicated Underhallow server owns active gameplay state.

---

# 29. Reconciliation #26 — Existing Specification Statuses

The MSI currently contains some statuses that no longer accurately represent the project's current design state.

Examples:

### PC-001

MSI says:

> LOCKED

but the actual file says:

> Draft

This must be reconciled.

### WM-001

Currently:

> DRAFT

This remains appropriate unless we formally lock it.

### PR-001

Currently:

> DRAFT

Appropriate.

### Farming

Currently:

> DRAFT

Appropriate.

### Hunting

Currently:

> DRAFT

Appropriate.

### ETA-001

Currently:

> APPROVED

This should be promoted to the project's chosen final foundation status once the authority migration is complete.

---

# 30. Reconciliation #27 — Parent References

Several newer documents still reference the superseded technical architecture.

For example, Core Gameplay identifies the old:

> `TECHNICAL_ARCHITECTURE.md`

as a parent specification.

World & Map similarly references the old TA-001/browser architecture.

These references are now stale.

They must point to:

> `ETA-001 — Engine & Technical Architecture Specification`

where technical architecture is actually required.

---

# 31. Reconciliation #28 — Core Gameplay

Core Gameplay remains broadly compatible.

The following remain authoritative:

* No stamina.
* Limited inventory.
* Expedition risk.
* Personal islands.
* Farming.
* Hunting.
* Building.
* Exploration.
* Narrative.
* Cozy-first philosophy.

However, Core Gameplay needs a multiplayer compatibility pass.

It should explicitly state that systems which naturally support group participation are multiplayer-capable without making multiplayer mandatory.

---

# 32. Reconciliation #29 — World & Map

World & Map remains largely compatible.

Its central model:

```text
Main Island
+
Personal Island
```

should remain.

However, it needs to incorporate:

* Guild islands.
* Multiplayer region instances.
* Shared public spaces.
* Controlled personal-island visitation.
* Future multiplayer world population.
* Technical distinction between authored world and runtime instances.

The authored geography should **not** be redesigned merely because server instances exist.

---

# 33. Reconciliation #30 — Player Control

PC-001 requires the clearest immediate gameplay correction.

Required changes:

### Keep

* Free movement.
* WASD.
* Arrow keys.
* Click-to-move.
* Input abstraction.
* Contextual interaction.
* E interaction.
* Directional tool use.
* Building ghost placement.
* Farming targeting.
* No sprint.
* No stamina.

### Change

Remove:

> Player-controlled 90° camera rotation.

Replace with:

> Fixed isometric V1 camera with zoom.

### Add

Multiplayer implications:

* Authoritative movement.
* Network-safe action requests.
* Multiplayer interaction awareness.
* Reconnect behavior.
* Server validation.

---

# 34. Reconciliation #31 — Hunting Multiplayer

Hunting becomes:

```text
Solo hunting
     +
Party hunting
     +
Guild hunting
     +
Public/shared encounters
```

Normal hunting may use individual resource ownership.

Special encounters can use shared/group reward distribution.

This follows the established principle:

> Not every multiplayer activity needs identical loot rules.

---

# 35. Reconciliation #32 — Farming Multiplayer

Farming becomes:

```text
Personal farm
      +
Cooperative assistance
      +
Guild farming
```

Ownership remains explicit.

Participation does not automatically transfer ownership.

---

# 36. Reconciliation #33 — Building Multiplayer

Building becomes:

### Personal

Player-owned construction.

### Guild

Permission-controlled shared projects.

A guild member may contribute to construction without receiving personal ownership of the resulting guild structure.

---

# 37. Reconciliation #34 — Trading

Trading becomes a two-layer system:

```text
Direct Trade
    +
Marketplace
```

Direct trade is proximity/session-based.

Marketplace trading is persistent.

Both are server-authoritative.

---

# 38. Reconciliation #35 — Guild Ownership

The ownership model becomes:

```text
PLAYER
 ├── Character
 ├── Inventory
 ├── Personal Property
 └── Personal Progression

PARTY
 └── Temporary Cooperative Activity

GUILD
 ├── Members
 ├── Guild Bank
 ├── Guild Progression
 ├── Guild Projects
 └── Guild Island

WORLD
 ├── Main Island
 ├── Public Regions
 └── Shared Events
```

This hierarchy should be reused consistently across future specifications.

---

# 39. Reconciliation #36 — Multiplayer Is Cross-Cutting

The MSI currently treats Multiplayer/Social Systems as a future supporting system.

That classification is now insufficient.

Multiplayer should be treated as a **cross-system architectural capability**.

There should eventually be a dedicated Multiplayer & Social specification, but it must depend on:

```text
ETA-001
CG-001
PC-001
WM-001
PR-001
FA-001
HU-001
BI-001
EC-001
```

rather than existing as an isolated feature.

---

# 40. Reconciliation #37 — New Required Specification

The next major system specification that becomes necessary is:

## Multiplayer & Social Systems Specification

Proposed ID:

**MS-001**

It should define:

* Player sessions
* Parties
* Guilds
* Guild membership
* Guild ranks
* Guild permissions
* Guild banks
* Guild islands
* Personal plots
* Social visibility
* Player visits
* Chat
* Direct messages
* Trading
* Shared activities
* Group loot
* Multiplayer permissions
* Presence
* Disconnect/reconnect
* Social safety
* Guild abandonment
* Guild succession
* Group activities
* Multiplayer events

This is now a genuine system specification, not merely an implementation detail.

---

# 41. Reconciliation #38 — New Supporting Specifications

Following MS-001, additional specifications will eventually be required for:

### Save & Persistence

**SV-001**

### Time & World Simulation

**TS-001**

### Economy

**EC-001**

### Inventory / Items / Crafting

**II-001**

### Building / Personal Island

**BI-001**

### NPC / Dialogue / Quest

**NQ-001**

### UI/UX

**UI-001**

### QA

**QA-001**

The order should be determined by dependency rather than simply following the old registry mechanically.

---

# 42. Reconciliation #39 — Documentation Migration

The repository should not delete the old architecture documents.

Instead:

```text
TA-001 Browser/Phaser
        ↓
SUPERSEDED
        ↓
ETA-001 Godot/PC
```

The old document remains useful for historical context.

New agents must not treat it as active architecture.

---

# 43. Reconciliation #40 — North Star Migration

This is the most important governance step.

The North Star currently contains several decisions that are now obsolete:

* Browser-first.
* Multiplayer not initially included.
* Multiplayer primarily as future visitation/social interaction.

These cannot simply be ignored because the North Star has higher authority than ETA-001.

Therefore the correct process is:

```text
Current Founder Decision
        ↓
North Star amendment
        ↓
Foundation reconciliation
        ↓
ETA-001 confirmation
        ↓
System specification reconciliation
        ↓
MSI update
```

This preserves the repository's own governance rules.

---

# 44. Final Reconciled Product Architecture

After reconciliation, the authoritative Underhallow model is:

```text
                         UNDERHALLOW
                              │
              ┌───────────────┴────────────────┐
              │                                │
         SINGLE PLAYER                   MULTIPLAYER
              │                                │
       Personal Island                  Real-time Co-op
       Main Island                       Parties
       Farming                           Guilds
       Hunting                           Trading
       Building                          Chat
       Exploration                       Guild Islands
       Story                             Shared Activities
       Progression                       Social World
              │                                │
              └───────────────┬────────────────┘
                              │
                       SAME GAME SYSTEMS
                              │
                    ┌─────────┴─────────┐
                    │                   │
              GODOT CLIENT       DEDICATED SERVER
                    │                   │
                    │             Authoritative
                    │               Simulation
                    │                   │
                    └─────────┬─────────┘
                              │
                           SUPABASE
                              │
                     Persistent State
```

---

# 45. Reconciled Design Philosophy

The final philosophy is:

> **Underhallow is a complete single-player game that was architected from the beginning so that players can naturally share the same world, activities and progression systems with other players.**

Multiplayer does not replace the single-player experience.

It expands it.

A player can:

* Live alone.
* Farm alone.
* Hunt alone.
* Build alone.
* Explore alone.
* Progress alone.

Or they can:

* Invite friends.
* Form parties.
* Hunt together.
* Farm together.
* Trade.
* Chat.
* Join guilds.
* Build guild infrastructure.
* Maintain a guild island.
* Participate in group events.

The two experiences use the same underlying gameplay architecture.

---

# 46. Reconciliation Decision Table

| Area                    | Existing Repo              | Current Decision                  | Resolution                    |
| ----------------------- | -------------------------- | --------------------------------- | ----------------------------- |
| Platform                | Browser                    | Windows PC                        | **Change**                    |
| Engine                  | Phaser legacy              | Godot                             | **ETA-001 authoritative**     |
| Mode                    | Single-player              | Single-player-first               | **Expand**                    |
| Multiplayer             | Future                     | Native real-time co-op            | **Major expansion**           |
| Main Island             | Shared authored world      | Shared + instanced                | **Extend technically**        |
| Personal Island         | Player-owned               | Persistent player property        | **Confirm**                   |
| Guild Island            | Not foundational           | Guild-owned persistent island     | **Add**                       |
| Guilds                  | Future                     | Core multiplayer system           | **Add MS-001**                |
| Parties                 | Future                     | 4–6 player groups                 | **Add MS-001**                |
| Shared farming          | Not fully defined          | Supported                         | **Add to Farming/MS**         |
| Cooperative hunting     | Not fully defined          | Supported                         | **Add to Hunting/MS**         |
| Trading                 | Future                     | Direct + marketplace              | **Add Economy/MS**            |
| Guild bank              | Future                     | Permission-controlled             | **Add MS/Economy**            |
| Chat                    | Future                     | Local/party/guild/DM              | **Add MS-001**                |
| Offline progression     | Partial                    | Explicitly supported              | **Confirm/TS/SV**             |
| Disconnect handling     | Not fully defined          | Reconnect window                  | **Add MS/ETA**                |
| PvP                     | Not required               | Not V1                            | **Confirm**                   |
| Stamina                 | Removed                    | Removed                           | **Already reconciled**        |
| Camera rotation         | 90° rotation               | No V1 rotation                    | **Change PC-001**             |
| Input                   | Good abstraction           | Keyboard/mouse + controller-ready | **Confirm**                   |
| Server authority        | New ETA                    | Strong authority                  | **Confirm**                   |
| Supabase                | Backend                    | Persistence, not simulation       | **Confirm**                   |
| Old Phaser architecture | Existing                   | Superseded                        | **Keep archived**             |
| North Star              | Browser/future multiplayer | PC/multiplayer-native             | **Formal amendment required** |
| MSI                     | Mixed statuses             | Reconciled registry               | **Update**                    |

---

# 47. Required Repository Changes

The reconciliation identifies the following actual documentation work:

### Priority 1 — Authority

1. Amend **North Star V1.0**.
2. Reconcile **Foundation Specification**.
3. Confirm **ETA-001** against the amended parent documents.

### Priority 2 — Foundation

4. Update **Core Gameplay**.
5. Update **Player Control**.
6. Update **World & Map**.
7. Correct stale parent references to superseded TA-001.

### Priority 3 — Multiplayer

8. Create **MS-001 Multiplayer & Social Systems Specification**.
9. Integrate guilds, parties, guild islands and social systems.

### Priority 4 — System Dependencies

10. Reconcile Farming.
11. Reconcile Hunting & Combat.
12. Create Building & Personal Island.
13. Create Inventory / Items / Crafting.
14. Create Time / Simulation.
15. Create Economy.
16. Create Save / Persistence.

### Priority 5 — Governance

17. Update MSI statuses.
18. Update dependency graph.
19. Record the architecture migration in the Decision Log.
20. Record the superseded browser architecture properly.
21. Add the new multiplayer architecture to the registry.

---

# 48. Important Conclusion

**We do not need to throw away the existing Underhallow documentation.**

Most of the game's actual design foundation remains valid.

The project needs a **controlled migration**, not a rewrite.

The main migration is:

```text
Browser / Phaser
      ↓
SUPERSEDED

Single-player-only foundation
      ↓
Single-player-first / multiplayer-native

Simple future social interaction
      ↓
Real-time cooperative world

Personal Island
      ↓
Personal Island + Guild Islands

Future multiplayer
      ↓
Cross-system multiplayer capability
```

The result is still recognizably the same Underhallow:

> **A cozy, mysterious, open-ended world where the player builds a life of their own.**

We've simply evolved the technical and social foundation enough to support players building that life **alone or together**.
