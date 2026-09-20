# UNDERHALLOW

## CORE GAMEPLAY SYSTEMS SPECIFICATION V1.0

**Document Status:** Draft — Finalized Design Decisions Incorporated  
**Version:** 1.0  
**Project:** Underhallow  
**Purpose:** Define the fundamental gameplay systems, player activities, progression model, world structure, and gameplay relationships that form the playable foundation of Underhallow.  
**Parent Documents:**  
* [Underhallow North Star V1.0](../01-product/NORTH_STAR.md)  
* [Underhallow Foundation Specification V1.0](../01-product/FOUNDATION_SPECIFICATION.md)  
* [Engine & Technical Architecture Specification V1 (ETA-001)](../02-architecture/ENGINE_TECHNICAL_ARCHITECTURE_SPECIFICATION.md)  
* [Underhallow Agent Constitution V1.0](../00-governance/AGENT_CONSTITUTION.md)  

---

# 1. Purpose

The Core Gameplay Systems Specification defines **what the player does in Underhallow and how the major gameplay systems interact**.

This document translates the high-level vision established in the:

* North Star V1.0
* Foundation Specification V1.0
* Engine & Technical Architecture Specification V1 (ETA-001)
* Agent Constitution V1.0

into a concrete gameplay foundation.

It is intentionally positioned above detailed implementation specifications.

This document defines:

* The core gameplay loop
* Player agency
* World structure
* Main Island
* Personal Island
* Exploration
* Farming
* Hunting
* Combat
* Building
* Crafting
* Fishing
* Inventory
* Progression
* Time
* Day/night
* Defeat
* Resource risk
* NPC interaction
* Quests
* Narrative integration
* Mystery
* Future economy boundaries
* Social/competitive boundaries

It does **not** yet define exact code, database schemas, formulas, asset specifications, or complete content catalogues.

---

# 2. Core Gameplay Philosophy

Underhallow is fundamentally a **cozy open-world adventure and life-simulation game**.

The player should feel:

* Happy
* Comfortable
* Curious
* Relaxed
* Adventurous
* Free

The game should provide meaningful things to do without constantly demanding that the player optimize their performance.

There is no single correct way to play Underhallow.

A player can become:

* A farmer
* A hunter
* An explorer
* A builder
* A trader
* A fisherman
* A combination of these
* Or simply someone who enjoys living in the world

The game should support both highly engaged players and players who simply want to relax.

---

# 3. Core Player Fantasy

The fundamental player fantasy is:

> **Become a resident of a mysterious world, build a life of your own, explore what lies beyond the familiar, and gradually uncover that the cozy world around you has a much darker history than it first appears.**

The player should eventually feel:

> **"This is my home, this is my island, and this is my story."**

---

# 4. Gameplay Taxonomy: Core Gameplay Pillars & Core World Systems

Underhallow enforces a foundational architectural distinction between **how players make a life** and the **infrastructure that allows those lives to function together**:

```text
CORE GAMEPLAY PILLARS
        ↓
Ways players make a life (Lifestyles & Livelihoods)
```

versus:

```text
CORE WORLD SYSTEMS
        ↓
Infrastructure that allows those lives to function together
```

This distinction is fundamental to Underhallow's world design, player agency, and long-term economic architecture. Players choose how to build their life; the world systems provide the physical, social, mechanical, and economic fabric connecting them. Underhallow documentation strictly maintains this separation and does not collapse both categories into a flat list.

---

## 4.1 The Five Core Gameplay Pillars

The Core Gameplay Pillars represent distinct player lifestyle and livelihood paths. They are not merely individual mechanics; each represents a comprehensive economic and gameplay identity around which a player can establish their character's life and purpose in Underhallow.

```text
🌾 Farming · 🏹 Hunting · ⛏️ Mining · 🎣 Fishing · 🐄 Animal Husbandry
```

### 4.1.1 🌾 Farming (Cultivation)
* **Classification:** Core Gameplay Pillar
* **Primary Activity:** Cultivation, agriculture, soil stewardship, and crop production.
* **Livelihood Scope:** A farmer cultivates land, tills soil, plants seeds, manages crop growth, harvests agricultural wealth, produces food, sells crop outputs, and supplies Crafting and Cooking.
* **Authoritative Specification:** [Farming System Specification (FB-001)](FARMING_SYSTEM_SPECIFICATION.md).

### 4.1.2 🏹 Hunting (Wildlife)
* **Classification:** Core Gameplay Pillar
* **Primary Activity:** Wildlife discovery, tracking, encounter management, and non-lethal harvesting.
* **Livelihood Scope:** A hunter explores dangerous territories, tracks creatures, engages in wildlife combat, harvests creature materials, produces food and leather, sells raw or processed wildlife outputs, supplies Crafting, and specializes around animal resources. Per Invariant 13 & 20, processing is never forced (selling raw resources is fully supported).
* **Authoritative Specification:** [Hunting & Combat System Specification (HU-001)](HUNTING_COMBAT_SYSTEM_SPECIFICATION.md).

### 4.1.3 ⛏️ Mining (Resource Extraction)
* **Classification:** Core Gameplay Pillar
* **Primary Activity:** Mineral and geological resource extraction.
* **Livelihood Scope:** A miner discovers mineral veins and subterranean deposits, extracts ores, gathers building stone, uncovers rare minerals, operates specialized extraction tools, supplies Crafting with metals and masonry, and trades raw or smelted materials through the economy.
* **Authoritative Specification:** [Resource Gathering, Forestry & Mining Specification (RG-001)](../00-governance/MASTER_SPECIFICATION_INDEX.md) *(Planned)*.

### 4.1.4 🎣 Fishing (Aquatic Resources)
* **Classification:** Core Gameplay Pillar
* **Primary Activity:** Aquatic resource gathering, freshwater and oceanic fishing.
* **Livelihood Scope:** A fisher reads water conditions, casts in diverse coastal and inland waters, captures various fish species, harvests aquatic resources, produces food, sells fresh catch to local markets, supplies Cooking and Crafting, and specializes in rare aquatic specimens.
* **Authoritative Specification:** [Fishing Specification (FI-001)](../00-governance/MASTER_SPECIFICATION_INDEX.md) *(Planned)*.

### 4.1.5 🐄 Animal Husbandry (Livestock)
* **Classification:** Core Gameplay Pillar
* **Primary Activity:** Livestock care, herding, breeding, and pastoral production.
* **Livelihood Scope:** A rancher/herder raises domestic livestock, manages pastures, cares for animal wellbeing, breeds for desirable traits, produces sustainable animal goods (milk, wool, eggs, fertilizer), sells livestock and byproducts, and supplies Crafting and Cooking.
* **Authoritative Specification:** [Livestock & Animal Husbandry Specification (LA-001)](../00-governance/MASTER_SPECIFICATION_INDEX.md) *(Planned)*.

---

## 4.2 The Eight Core World Systems

Core World Systems operate across multiple lifestyle pillars. They provide the universal physical, social, mechanical, and economic infrastructure that enables individual player lifestyles to coexist, interconnect, and flourish.

| System | Classification | Primary Cross-Pillar Function | Authoritative Specification |
| :--- | :--- | :--- | :--- |
| 🏗️ **Building & Construction** | Core World System | Physical world infrastructure, player housing, workspaces, and territorial development across all pillars | [BI-001](BUILDING_CONSTRUCTION_SYSTEM_SPECIFICATION.md) |
| 💰 **Trading & Economy** | Core World System | Commerce, pricing, market exchange, and resource distribution connecting all pillar outputs | [EC-001](../00-governance/MASTER_SPECIFICATION_INDEX.md) *(Planned)* |
| 🧑🤝🧑 **Social / Community** | Core World System | Multiplayer cooperation, parties, guilds, shared spaces, and player interactions | [MS-001](../07-multiplayer/MULTIPLAYER_SOCIAL_SYSTEMS_SPECIFICATION.md) |
| 🗺️ **World / Exploration** | Core World System | Movement, regional geography, landmarks, discovery, spatial transitions, and secrets | [EX-001](../00-governance/MASTER_SPECIFICATION_INDEX.md) *(Planned)* / [WM-001](../04-world/WORLD_MAP_ARCHITECTURE_SPECIFICATION.md) |
| ⚔️ **Combat** | Core World System | Conflict resolution, hostile encounters, defense, and interaction mechanics supporting hunting and exploration | [HU-001](HUNTING_COMBAT_SYSTEM_SPECIFICATION.md) |
| 🎒 **Inventory / Items** | Core World System | Item definition, slot storage, transport capacity, stacking, and equipment management | [II-001](../00-governance/MASTER_SPECIFICATION_INDEX.md) *(Planned)* |
| 📜 **Quests / Progression** | Core World System | Structured milestones, narrative objectives, skill growth, and account advancement across all pillars | [PR-001](PLAYER_PROGRESSION_SPECIFICATION.md) / [NQ-001](../00-governance/MASTER_SPECIFICATION_INDEX.md) *(Planned)* |
| 🛠️ **Crafting** | Core World System | Cross-pillar resource transformation converting raw materials into goods, tools, and structures | [II-001](../00-governance/MASTER_SPECIFICATION_INDEX.md) *(Planned)* |

### 4.2.1 🏗️ Building & Construction (Physical Infrastructure)
Building is explicitly **not** one of the five Core Gameplay Pillars. Rather, it provides cross-pillar physical infrastructure. Building supports farming (plots, barns), hunting (drying racks, trophy halls), mining (smelters, storage sheds), fishing (docks, smokehouses), animal husbandry (coops, barns, fences), crafting (workbenches, workshops), and player identity (cottages, estates).

### 4.2.2 💰 Trading & Economy (Commerce & Exchange)
Trading belongs to the Economy / Commerce layer and is explicitly **not** an independent livelihood pillar. While a player may specialize as a merchant or trader, Trading functions as the systemic connective tissue through which all pillar outputs are valued, exchanged, and redistributed throughout the world:

```text
Farmer (Crops) ────────┐
Hunter (Hides/Meat) ───┤
Miner (Ores/Stone) ────┼──→ Economy & Trading ──→ World Wealth & Exchange
Fisher (Fish) ─────────┤
Rancher (Wool/Milk) ───┘
```

### 4.2.3 🛠️ Crafting (Resource Transformation)
Crafting is cross-pillar transformation infrastructure rather than an isolated livelihood pillar. It receives raw inputs generated across all five pillars and converts them into finished goods, tools, structures, and consumables:

```text
Farming (Fiber, Grains) ─────┐
Hunting (Hides, Bones) ──────┤
Mining (Ores, Gems) ─────────┼──→ Crafting ──→ Goods, Tools, Buildings, Consumables
Fishing (Scales, Oils) ──────┤
Animal Husbandry (Wool) ─────┘
```

### 4.2.4 🧑🤝🧑 Social / Community (Multiplayer Infrastructure)
Social systems provide the cross-cutting framework for player interaction, co-op parties, guild islands, mutual aid, and communal events across all lifestyle activities, upholding the single-player-first, multiplayer-native principle ([MS-001](../07-multiplayer/MULTIPLAYER_SOCIAL_SYSTEMS_SPECIFICATION.md)).

### 4.2.5 🗺️ World / Exploration (Spatial Framework)
Exploration provides the spatial environment and geographic context in which all pillars operate. It encompasses traversal, regional transitions, discovery, landmarks, and secrets across the Main Island, Personal Islands, and Guild Islands ([EX-001](../00-governance/MASTER_SPECIFICATION_INDEX.md), [WM-001](../04-world/WORLD_MAP_ARCHITECTURE_SPECIFICATION.md)).

### 4.2.6 ⚔️ Combat (Interaction System)
Combat is shared interaction infrastructure. Combat supports wildlife defense, hostile encounters, and expedition risk management. Hunting is a livelihood lifestyle; combat is the interaction mechanism utilized during that pursuit.

### 4.2.7 🎒 Inventory / Items (Resource Transport)
Inventory and item systems manage the ownership, containment, weight, stacking, and transfer of resources produced by all five pillars. Inventory constraints serve as the primary expedition pacing mechanism in place of artificial stamina meters (Invariant 4).

### 4.2.8 📜 Quests / Progression (Universal Advancement)
Quests and progression provide horizontal and vertical advancement across every lifestyle and world system. Progression rewards engagement in any pillar without forcing players to participate in activities they do not enjoy ([PR-001](PLAYER_PROGRESSION_SPECIFICATION.md), [NQ-001](../00-governance/MASTER_SPECIFICATION_INDEX.md)).

---

## 4.3 Conceptual Economic Relationship

The Core Gameplay Pillars and Core World Systems interact through an integrated, self-sustaining economic loop:

```text
CORE PILLARS (Farming · Hunting · Mining · Fishing · Husbandry)
     │
     ▼
Gather / Produce (Raw Resources)
     │
     ▼
Crafting (Transformation)
     │
     ▼
Finished Goods & Supplies
     │
     ▼
Trading & Markets (Commerce Layer)
     │
     ▼
Player Economy
     │
 ┌───┴────┐
 ▼        ▼
Consume  Build & Equip
 └───┬────┘
     ▼
Continue Life in Underhallow
     │
     └────→ Gather / Produce
```

---

## 4.4 Player Specialization Model

Underhallow does not require any player to master all systems. The five pillars allow players to pursue deep, distinct lifestyles and economic specializations:

* **The Dedicated Farmer:** Focuses on crop rotation, soil management, and high-yield harvests; trades agricultural surpluses for tools, stone, and animal products.
* **The Wilderness Hunter:** Specializes in tracking, animal habits, and rare wildlife harvests; trades pelts, meats, and trophies for farm produce and crafted arrows.
* **The Subterranean Miner:** Focuses on mineral prospecting and deep quarrying; supplies smiths and builders with high-grade ores and structural stone.
* **The Coastal Fisher:** Reads oceanic tides and weather patterns; supplies fresh fish, oils, and rare aquatic ingredients to village markets and cooks.
* **The Pastoral Rancher:** Breeds prized livestock and harvests wool, dairy, and eggs; trades animal byproducts for feed and agricultural grains.
* **The Artisan / Crafter:** Leverages the Crafting world system to refine multi-pillar raw materials into high-value tools, furniture, and equipment.
* **The Merchant / Trader:** Specializes within the Trading world system, mastering supply lines, regional arbitrage, and marketplace commerce.

---

## 4.5 Authoritative Specification Mapping

All pillars and world systems map to authoritative Level 2 specifications registered in the [Master Specification Index (MSI-001)](../00-governance/MASTER_SPECIFICATION_INDEX.md). Existing specification IDs and their current drafting statuses remain strictly authoritative:

| System Name | Classification | Specification ID | Current Status | Parent / Authority |
| :--- | :--- | :--- | :---: | :--- |
| **Farming** | Core Gameplay Pillar | `FB-001` | DRAFT | [docs/03-gameplay/FARMING_SYSTEM_SPECIFICATION.md](FARMING_SYSTEM_SPECIFICATION.md) |
| **Hunting** | Core Gameplay Pillar | `HU-001` | DRAFT | [docs/03-gameplay/HUNTING_COMBAT_SYSTEM_SPECIFICATION.md](HUNTING_COMBAT_SYSTEM_SPECIFICATION.md) |
| **Mining** | Core Gameplay Pillar | `RG-001` | PLANNED | Resource Gathering, Forestry & Mining *(Not yet drafted)* |
| **Fishing** | Core Gameplay Pillar | `FI-001` | PLANNED | Fishing *(Not yet drafted)* |
| **Animal Husbandry** | Core Gameplay Pillar | `LA-001` | PLANNED | Livestock & Animal Husbandry *(Not yet drafted)* |
| **Building & Construction** | Core World System | `BI-001` | DRAFT | [docs/03-gameplay/BUILDING_CONSTRUCTION_SYSTEM_SPECIFICATION.md](BUILDING_CONSTRUCTION_SYSTEM_SPECIFICATION.md) |
| **Trading & Economy** | Core World System | `EC-001` | PLANNED | Economy *(Not yet drafted)* |
| **Social / Community** | Core World System | `MS-001` | DRAFT | [docs/07-multiplayer/MULTIPLAYER_SOCIAL_SYSTEMS_SPECIFICATION.md](../07-multiplayer/MULTIPLAYER_SOCIAL_SYSTEMS_SPECIFICATION.md) |
| **World / Exploration** | Core World System | `EX-001` | PLANNED | Exploration & Secrets *(Not yet drafted)* |
| **Combat** | Core World System | `HU-001` | DRAFT | [docs/03-gameplay/HUNTING_COMBAT_SYSTEM_SPECIFICATION.md](HUNTING_COMBAT_SYSTEM_SPECIFICATION.md) |
| **Inventory / Items** | Core World System | `II-001` | PLANNED | Inventory, Items, Tools & Crafting *(Not yet drafted)* |
| **Quests** | Core World System | `NQ-001` | PLANNED | NPCs, Dialogue & Quests *(Not yet drafted)* |
| **Progression** | Core World System | `PR-001` | DRAFT | [docs/03-gameplay/PLAYER_PROGRESSION_SPECIFICATION.md](PLAYER_PROGRESSION_SPECIFICATION.md) |
| **Crafting** | Core World System | `II-001` | PLANNED | Inventory, Items, Tools & Crafting *(Not yet drafted)* |

---

# 5. Player Agency

The player has three layers of agency.

## 5.1 Immediate Agency

What the player does right now.

Examples:

* Walk
* Interact
* Gather
* Plant
* Harvest
* Hunt
* Fish
* Build
* Craft
* Talk
* Explore

---

## 5.2 Session Agency

What the player chooses to accomplish during a game session.

Examples:

* Complete a quest
* Explore a new region
* Gather resources
* Hunt
* Develop their farm
* Expand their island
* Search for a secret
* Fish
* Improve their house

---

## 5.3 Long-Term Agency

What kind of resident the player ultimately becomes.

Examples:

* Wealthy farmer
* Skilled hunter
* Dedicated explorer
* Master builder
* Trader
* Mixed-role player
* Highly developed island owner

There must not be one universally optimal playstyle.

---

# 6. World Structure

Underhallow consists of three primary world spaces:

```text
                  MAIN ISLAND
             (Public Adventure Hub)
                       │
         ┌─────────────┴─────────────┐
         │         Boat / Dock       │
         ▼                           ▼
  PERSONAL ISLAND              GUILD ISLANDS
  (Player-Owned)            (Guild-Owned Co-op)
```

The island spaces serve distinct, complementary purposes.

---

# 7. Main Island

The Main Island is the primary shared world and adventure environment.

It contains:

* Town Square
* NPCs
* Shops and services
* Story locations
* Exploration regions
* Wildlife
* Hostile creatures
* Resources
* Hidden areas
* Secrets
* Quests
* Major events
* Lore
* Mystery content

The Main Island is the primary place where the player experiences the wider world of Underhallow.

---

# 8. Personal Island

Every player receives a Personal Island.

All players initially begin with an equivalent foundational island.

The player gradually transforms it through their choices.

The island can contain:

* House
* Farm plots
* Buildings
* Trees
* Storage
* Crafting facilities
* Decorative objects
* Other future structures

The Personal Island represents the player's ownership and long-term development.

---

# 9. Personal Island Development

The island is based around a grid-based development system.

The player's initial usable area surrounds their house.

Additional sections of the island can eventually be unlocked.

Players can decide how to use available space.

Possible uses include:

* Farming
* Building
* Storage
* Decoration
* Crafting

---

# 9.1 Guild Islands

In accordance with [SR-001](../00-governance/SPECIFICATION_RECONCILIATION.md), [WM-001](../04-world/WORLD_MAP_ARCHITECTURE_SPECIFICATION.md), and [MS-001](../07-multiplayer/MULTIPLAYER_SOCIAL_SYSTEMS_SPECIFICATION.md), guilds can unlock and develop persistent **Guild Islands**.

Guild Islands provide:

* A central Guild Hall housing the communal Guild Bank, trophy hall, and crafting workshops.
* Large communal farm fields for collaborative agriculture.
* Modular personal residential plots assigned to individual members.
* A shared gathering and rally space for guild-organized hunting expeditions.

Like Personal Islands, Guild Islands are accessed through the harbor boat/dock travel system and enforce strict, server-authoritative permission boundaries.

The grid exists to provide structure, but the island must still feel like a physical world rather than a spreadsheet.

---

# 10. Player Movement

Movement is the fundamental physical interaction layer.

The player must be able to:

* Move through accessible terrain
* Navigate around obstacles
* Enter appropriate locations
* Approach interactable objects
* Explore the environment
* Travel between world spaces

Movement must feel responsive, predictable and intuitive within the isometric presentation.

Detailed movement and camera behavior will be defined in the **Player Controller, Movement & Interaction Specification**.

---

# 11. Exploration

Exploration is a foundational **Core World System** providing the shared spatial framework and environmental context in which all gameplay pillars operate.

The player should be rewarded for going beyond the obvious path.

The world can contain:

### Resources

* Common resources
* Uncommon resources
* Rare resources
* Region-specific resources

### Discoveries

* Hidden areas
* Landmarks
* Secret objects
* NPCs
* Rare encounters
* Special locations

### Narrative Discoveries

* Clues
* Lore
* Environmental storytelling
* Journals
* Strange events
* Mysterious locations

### Gameplay Discoveries

* Quests
* Rare items
* New resources
* New creatures
* New opportunities

---

# 12. Optional Discovery

Some discoveries should be completely optional.

A player should be able to complete the main experience without discovering everything.

Some secrets may require:

* Careful exploration
* Returning to an area
* Visiting at a specific time
* Following clues
* Talking to particular NPCs
* Experimentation
* Simply being curious

This supports the feeling that Underhallow is a real world rather than a linear checklist.

---

# 13. Expedition Model

The player repeatedly moves between their Personal Island and the wider world.

The fundamental expedition loop is:

```text
Prepare
   ↓
Leave Personal Island
   ↓
Travel by Boat
   ↓
Explore Main Island
   ↓
Farm / Hunt / Gather / Fish / Quest
   ↓
Inventory Fills
   ↓
Choose:
   ├── Return Safely
   └── Continue Taking Risks
   ↓
Return Home
   ↓
Store Resources
   ↓
Develop / Craft / Prepare
   ↓
Next Expedition
```

This expedition model replaces the need for an energy/stamina system.

---

# 14. No Stamina System

**V1.0 Decision: No stamina or energy restriction.**

The player will not have a stamina meter limiting the number of actions they can perform during a day.

This decision is deliberate.

Instead, the game's natural constraints are:

* Inventory capacity
* Time
* Risk
* Player choice

The player is free to continue performing activities without an artificial energy wall.

A stamina system may only be introduced in a future version if actual playtesting demonstrates that the game requires one.

Agents must not introduce a stamina system into V1.0 without an explicit design decision.

---

# 15. Inventory

The player has a **limited-slot inventory**.

Inventory capacity is one of the primary constraints in exploration.

The player must make decisions about:

* What to carry
* What to collect
* What to leave behind
* When to return home
* Which resources are worth carrying
* What equipment is needed for an expedition

The exact slot count and inventory categories will be defined in the **Inventory, Items & Resources Specification**.

---

# 16. Inventory as Gameplay

Inventory should create meaningful decisions without becoming unnecessarily frustrating.

The intended tension is:

> "I have valuable things with me. Do I go home now, or do I keep exploring?"

This gives resource collection and exploration a natural risk/reward structure.

---

# 17. Voluntary Return

The player can voluntarily return to their Personal Island at any time.

Returning home allows the player to:

* Secure resources
* Store items
* Prepare equipment
* Develop their island
* Craft
* Begin another expedition

There is no requirement to remain on the Main Island until the end of the day.

---

# 18. Time System

Underhallow uses a traditional game-day structure.

A day progresses through periods such as:

**Morning → Afternoon → Evening → Night**

Time can influence:

* NPC availability
* Events
* Wildlife
* Exploration
* Quests
* Farming
* Environmental atmosphere
* Special discoveries

Exact day length and time progression will be defined in the **Time & World Simulation Specification**.

---

# 19. Seasons

Seasons are part of the long-term vision.

However:

**Seasons are not required for the initial gameplay implementation.**

The underlying architecture should allow seasonal systems to be introduced later without requiring a fundamental rewrite.

Initial world simulation will prioritize:

* Game days
* Time progression
* Day/night
* NPC schedules
* World events

Seasonal simulation can be layered on later.

---

# 20. Nighttime

Night is both an atmospheric and gameplay state.

Night should:

* Change lighting
* Change ambience
* Alter NPC behavior
* Change wildlife
* Introduce nighttime creatures
* Potentially reveal unique locations
* Potentially enable special events
* Potentially reveal unique discoveries

Night should not simply punish the player.

It should create opportunities.

The player should sometimes deliberately remain outside at night because:

> **There are things in Underhallow that can only be experienced after dark.**

---

# 21. Farming

Farming is one of the two primary player roles.

The basic farming loop is:

**Prepare → Plant → Maintain → Grow → Harvest → Use/Sell**

Farming should be moderately strategic.

It should be deeper than a purely decorative system but less management-heavy than a dedicated farming simulator.

---

# 22. Farming Activities

Players may eventually:

* Prepare farmland
* Plant crops
* Maintain crops
* Harvest crops
* Manage multiple plots
* Improve farming infrastructure
* Optimize production
* Expand their agricultural operation

Exact farming mechanics will be defined separately.

---

# 23. Farming Skill

Farming has its own progression path.

The player can develop a **Farming Skill**.

Progression may unlock:

* New crops
* Improved tools
* Farming structures
* Better techniques
* More efficient production
* Specialized opportunities

Exact formulas are deferred.

---

# 24. Hunting

Hunting is the second primary player role.

The basic hunting loop is:

**Explore → Find → Engage → Defeat → Gather → Return/Use**

Hunting combines:

* Exploration
* Tracking/discovery
* Combat
* Risk
* Resource gathering

---

# 25. Combat

Combat is a **Core World System** providing shared interaction infrastructure for hostile encounters and wildlife defense.

Combat is not an independent lifestyle pillar; rather, it is the interaction mechanism utilized during the Hunting livelihood and dangerous territorial expeditions.

Combat is intentionally simple.

Combat should be:

* Accessible
* Readable
* Responsive
* Low-complexity
* Appropriate for the cozy adventure identity

Combat exists primarily to support:

* Hunting
* Dangerous areas
* Creature encounters
* Exploration
* Resource acquisition

Underhallow is not intended to become a hardcore combat-focused RPG.

---

# 26. Hunting Skill

The player has a dedicated **Hunting Skill**.

Progression may eventually unlock:

* Better hunting equipment
* Stronger encounters
* Improved efficiency
* New hunting opportunities
* Access to more dangerous regions

Exact mechanics are deferred to the Hunting & Combat Specification.

---

# 27. Defeat

Underhallow uses a **non-lethal defeat model**.

The player does not permanently die.

When defeated in combat:

1. The encounter ends.
2. The player loses the resources gathered during the current expedition.
3. Time is lost.
4. The player returns to their Personal Island.
5. Permanent progression remains intact.

---

# 28. Expedition Resource Loss

**V1.0 Decision:**

The player loses the resources acquired during the current expedition when defeated.

The conceptual boundary is:

> **Everything gathered since the player last safely returned home is at risk.**

Permanent progression is not lost.

The player does not lose:

* Character level
* Skill progression
* House progression
* Island development
* Permanent unlocks

This creates meaningful expedition risk without creating devastating permanent failure.

---

# 29. Building

Building & Construction is a **Core World System** providing foundational physical infrastructure across all lifestyle pillars, workspaces, and territorial development.

Building is explicitly not one of the five Core Gameplay Pillars. It provides cross-pillar physical infrastructure that supports farming, hunting, mining, fishing, animal husbandry, crafting, commerce, and player housing.

Building is both:

**Functional + Creative**

Functional building provides gameplay benefits.

Creative building allows players to express themselves.

Buildings may provide:

* Storage
* Production
* Crafting
* Farming capabilities
* Specialized functionality
* Decoration
* Other future services

---

# 30. Building Skill

Building has its own progression path.

A **Building Skill** can unlock:

* New structures
* Improved structures
* Additional building capabilities
* More advanced island development

Building progression should eventually provide both functional and aesthetic opportunities.

---

# 31. House

The player's house is a central Personal Island structure.

It represents:

* Ownership
* Progression
* Personal identity
* Shelter
* Storage
* Potential future functionality

House upgrades may eventually include:

* Additional space
* Rooms
* Storage
* Functional upgrades
* Decoration
* Other systems

The exact house progression will be defined separately.

---

# 32. Crafting

Crafting is a **Core World System** providing cross-pillar resource transformation.

It exists to convert raw materials gathered across all five Core Gameplay Pillars (farming, hunting, mining, fishing, animal husbandry) into finished goods, tools, equipment, structures, and consumables.

Potential outputs include:

* Tools
* Equipment
* Consumables
* Building materials
* Utility items
* Specialized items

Crafting functions as shared transformation infrastructure supporting the lifestyle pillars and the player economy rather than existing as an isolated livelihood pillar.

---

# 33. Fishing

Fishing is one of the five **Core Gameplay Pillars**, representing the aquatic resource production livelihood.

A player specializing as a fisher reads water conditions, navigates coastal and freshwater environments, catches fish species, harvests aquatic resources, and supplies Cooking, Crafting, and local markets.

Fishing provides:

* Aquatic resources
* Food & culinary ingredients
* Economic income through Trade
* Collection & discovery opportunities
* Rare materials & secrets
* Coastal & maritime exploration

Fishing offers a complete, viable lifestyle identity within Underhallow's world.

---

# 34. Tools

Players will have tools and equipment appropriate to their activities.

Potential categories include:

* Farming tools
* Gathering tools
* Forestry tools
* Mining tools
* Fishing equipment
* Hunting equipment

Every tool must have a meaningful gameplay purpose.

The game should not introduce conventional tools merely because similar farming games contain them.

---

# 35. Player Progression

Underhallow uses several interconnected progression dimensions.

The initial progression model includes:

### Character

* Character Level

### Skills

* Farming Skill
* Hunting Skill
* Building Skill

### Personal Development

* House
* Personal Island
* Buildings
* Island expansion

### Economic Development

* Wealth
* Assets
* Future economic ownership

### Discovery

* Explored areas
* Secrets
* Lore
* Major discoveries

---

# 36. Progression Philosophy

Progression should primarily unlock **new possibilities**.

Progression should not be reduced to:

> Number goes up.

For example, gaining Farming Skill should ideally unlock new crops, techniques or opportunities rather than only increasing crop output by a percentage.

Numerical improvements can exist where appropriate, but they should support meaningful gameplay.

---

# 37. Multiple Valid Progression Paths

A player should be able to progress through different combinations of activities.

Possible paths include:

### Farmer

Farming → wealth → infrastructure → island development

### Hunter

Exploration → hunting → resources → equipment → dangerous areas

### Explorer

Exploration → discoveries → secrets → rare resources → lore

### Builder

Resource gathering → building → island development → creative expression

### Mixed Player

Combines any of the above.

No single path should invalidate the others.

---

# 38. Wealth

Wealth is one of the long-term progression dimensions.

Players can eventually become wealthy through:

* Labor
* Skill
* Farming
* Hunting
* Fishing
* Trading
* Exploration
* Ownership
* Market activity
* Luck

The economic fantasy is:

> **Players who work intelligently and take opportunities can become extremely successful, while players who don't care about wealth can still enjoy Underhallow.**

---

# 39. Future Economy

Trading & Economy is a **Core World System** providing the commerce and exchange layer that connects the outputs of all Core Gameplay Pillars.

Trading is explicitly **not an independent Core Gameplay Pillar**. While a player may specialize as a merchant or trader, Trading functions as the world system through which crops, pelts, ores, fish, livestock goods, and crafted items circulate through player and NPC economies.

The eventual Underhallow economy is intended to potentially connect to the real world.

However:

**The economy is deliberately deferred.**

The core game must remain fun and functional without it.

The eventual economic system may incorporate:

### Labor & Skill

* Farming
* Hunting
* Gathering
* Crafting
* Other activities

### Markets

* Buying
* Selling
* Trading
* Price variation
* Market opportunities

### Ownership

* Businesses
* Production
* Land
* Economic infrastructure
* Other productive assets

The exact economic model will be designed in a dedicated **Economy Specification**.

No economic implementation should be introduced simply because it is part of the long-term vision.

---

# 40. NPCs

NPCs primarily function as:

* Story characters
* Quest characters
* World inhabitants
* Sources of information
* Guides
* Participants in events
* Sources of mystery and lore

NPC relationship simulation is not currently a core progression system.

That may be expanded later if justified by playtesting.

---

# 41. Quest System

Quests provide structure and narrative motivation.

Potential quest categories include:

* Main story
* Character quests
* Exploration
* Farming
* Hunting
* Building
* Collection
* Mystery
* World events

Quests are optional after the introductory sequence unless a future story specification explicitly defines otherwise.

---

# 42. Character-Driven Story

The primary narrative experience is character-driven.

The player should learn about Underhallow through:

* People
* Conversations
* Events
* Relationships
* Locations
* Discoveries
* Environmental storytelling

Characters should feel like inhabitants rather than simple quest dispensers.

---

# 43. Mystery

Underhallow contains an underlying dark mystery.

The surface experience is:

> Cozy → Wholesome → Peaceful → Relaxing → Adventurous

Beneath that is:

> Mystery → Uncertainty → Hidden History → Darker Truth

The contrast between these layers is a defining part of the game's identity.

The player should eventually experience moments of:

> **"How can a world this cozy have something this dark underneath it?"**

The mystery should unfold gradually.

It should not overwhelm the early cozy experience.

---

# 44. First-Time Player Experience

The first 10–15 minutes are **narratively guided**.

The player begins as a new resident.

The introductory sequence should establish:

* Who the player is
* Why they are in the town
* Why they have been given a Personal Island
* Where their home is
* How the basic systems work
* Who some of the important characters are
* Why they should care about the world

---

# 45. Introductory Flow

The initial sequence follows approximately:

```text
Arrival
   ↓
Town Square
   ↓
Meet Residents
   ↓
Story Introduction
   ↓
Understand Why You Are Here
   ↓
Receive Personal Island
   ↓
Travel by Boat
   ↓
Arrive at Island
   ↓
Receive / Enter House
   ↓
Learn Basic Farming
   ↓
Complete Introductory Tasks
   ↓
Tutorial Story Resolution
   ↓
Full Player Freedom
```

This tutorial exists inside the game world.

---

# 46. Tutorial Philosophy

The tutorial should teach through context and action.

Instead of relying primarily on instructions, the player should have an in-world reason to perform each action.

The intended progression is:

**Curiosity → Belonging → Discovery → Ownership → Freedom**

The player should eventually reach:

> **"This is my place. What do I want to do now?"**

---

# 47. Open-World Freedom

After the introductory sequence, players are free to establish their own routines.

They may:

* Farm
* Hunt
* Explore
* Build
* Fish
* Craft
* Trade
* Complete quests
* Search for secrets
* Develop their island
* Simply wander

No single activity is mandatory for ordinary progression.

---

# 48. World Persistence

Meaningful player actions should persist.

Examples:

* Buildings remain built.
* Island changes remain.
* House upgrades remain.
* Player progression remains.
* Discovered content remains discovered.
* Major story milestones remain completed.
* Stored resources remain stored.

The world should feel like a place the player is actually changing over time.

---

# 49. World Transitions

The player travels between their Personal Island, Guild Islands, and the Main Island using a **boat/dock system**.

Conceptually:

```text
  Personal Island / Guild Island
                ↓
               Dock
                ↓
               Boat
                ↓
            Main Island
```

The transition should feel diegetic rather than like a purely technical teleport.

---

# 50. Social & Cooperative Systems

In accordance with [SR-001](../00-governance/SPECIFICATION_RECONCILIATION.md), [ETA-001](../02-architecture/ENGINE_TECHNICAL_ARCHITECTURE_SPECIFICATION.md), and [MS-001](../07-multiplayer/MULTIPLAYER_SOCIAL_SYSTEMS_SPECIFICATION.md), Underhallow is **single-player-first, multiplayer-native**.

The single-player experience is complete, self-contained, and fully playable without any social interaction. For players who choose to engage socially, the architecture natively provides:

* Real-time cooperative multiplayer (V1 has no PvP).
* Parties (4–6 players) for shared hunting expeditions, farming assistance, and exploration.
* Guilds (~50 members) with shared progression, bank storage, and persistent Guild Islands.
* Cross-island visitation governed by granular owner permission matrices.
* Direct peer-to-peer trading and marketplace commerce.
* Proximity, party, guild, and direct text chat channels.

Multiplayer expands player agency and community without ever compromising solo autonomy or imposing mandatory group requirements.

---

# 51. Competitive Systems

Competition is optional.

Underhallow V1 contains no player-versus-player (PvP) combat, territory warfare, or grief raiding. The world does not require:

* Leaderboards
* PvP
* Competitive rankings

for the core game to be enjoyable.

Future optional competitive systems may exist for players who want them.

The philosophy is:

> **Players can compete without making competition mandatory.**

---

# 52. Core Gameplay Invariants

The following are protected design rules.

### Invariant 1 — Player Freedom

There must be multiple valid ways to play and progress.

### Invariant 2 — Exploration Has Value

Exploration must provide meaningful discoveries.

### Invariant 3 — No Mandatory Competition

Players can enjoy the game without competing against others.

### Invariant 4 — No V1 Stamina System

Player activity is not artificially restricted by an energy bar.

### Invariant 5 — Inventory Creates Expedition Decisions

Limited inventory should create strategic choices.

### Invariant 6 — Risk Is Meaningful but Recoverable

Defeat can hurt an expedition without destroying permanent progression.

### Invariant 7 — Personal Island Matters

The Personal Island must become a meaningful representation of player progress.

### Invariant 8 — Progression Unlocks Possibilities

Progression should do more than increase numerical values.

### Invariant 9 — Cozy First

Systems should preserve the intended relaxing and wholesome experience.

### Invariant 10 — Mystery Is Protected

The underlying mystery should have room to develop gradually.

### Invariant 11 — Core Game Does Not Depend on Future Economy

The game must be enjoyable without the eventual economic layer.

### Invariant 12 — Single Player First

The initial game must be coherent and complete without multiplayer.

---

# 53. System Dependency Model

At the highest level:

```text
                     PLAYER
                       │
                       ▼
              MOVEMENT / INTERACTION
                       │
                       ▼
                     WORLD
                       │
          ┌────────────┼────────────┐
          ▼            ▼            ▼
      EXPLORATION    NPCs       ACTIVITIES
                                  │
                    ┌─────────────┴─────────────┐
                    ▼                           ▼
          CORE GAMEPLAY PILLARS         CORE WORLD SYSTEMS
          (Farming, Hunting,            (Building, Social,
           Mining, Fishing,              Combat, Exploration)
           Animal Husbandry)                    │
                    │                           │
                    ▼                           │
                RESOURCES                       │
                    │                           │
                    ▼                           ▼
          CRAFTING / INVENTORY ─────────→ PLAYER ECONOMY
          (Resource Transformation)      (Trading & Markets)
                    │                           │
                    └─────────────┬─────────────┘
                                  ▼
                             PROGRESSION
                                  │
          ┌─────────┼─────────────┴─────────────┐
          ▼         ▼                           ▼
       PLAYER      HOUSE                     ISLAND
          │                                     │
          └─────────────────┬───────────────────┘
                            ▼
                       NEW OPTIONS
                            │
                            ▼
                       EXPLORATION
```

Narrative, quests and mystery operate across the entire world rather than existing as isolated systems.

---

# 54. System Independence

Major systems should remain independently understandable.

Examples:

* Farming must not depend on combat.
* Combat must not depend on the future economy.
* Building must not depend on multiplayer.
* Exploration must not depend on quests.
* The game must not require the economy to function.
* The Personal Island must remain useful without social features.

This keeps the architecture modular and allows future systems to be added safely.

---

# 54.1 Multiplayer Compatibility Principle

In accordance with [SR-001](../00-governance/SPECIFICATION_RECONCILIATION.md) and [ETA-001](../02-architecture/ENGINE_TECHNICAL_ARCHITECTURE_SPECIFICATION.md), Underhallow is **single-player-first, multiplayer-native**.

Every core gameplay system (farming, hunting, gathering, building, trading, exploration) functions completely and satisfyingly for a solo player. When playing cooperatively:

* Systems naturally support group participation (shared farming assistance, party hunting, joint exploration, guild projects).
* Ownership remains explicit (participation does not automatically transfer ownership).
* Multiplayer expands the player experience without ever making multiplayer mandatory.

---

# 55. Deferred Systems

The following are explicitly deferred from this specification:

* Final economy design
* Real-world economic integration
* Guilds & detailed social structures (MS-001)
* Chat architecture (MS-001)
* Blockchain integration, if eventually used
* Monetization
* Detailed NPC relationship systems
* Complete crafting catalogue
* Complete item catalogue
* Detailed combat formulas
* Detailed farming formulas
* Exact island expansion pricing
* Complete quest catalogue
* Final narrative plot
* Full mystery reveal structure
* Seasonal mechanics
* Weather systems
* Final market mechanics

These systems will receive dedicated specifications when appropriate.

---

# 56. Required Detailed Specifications

The Core Gameplay Systems Specification establishes the foundation for the following documents:

1. **Player Controller, Movement & Interaction Specification** (PC-001)
2. **Time & World Simulation Specification** (TS-001)
3. **Exploration & World Systems Specification** (EX-001)
4. **Farming Systems Specification** (FB-001)
5. **Hunting & Combat Specification** (HU-001)
6. **Resource Gathering, Forestry & Mining Specification** (RG-001)
7. **Fishing Specification** (FI-001)
8. **Livestock & Animal Husbandry Specification** (LA-001)
9. **Building & Personal Island Specification** (BI-001)
10. **Inventory, Items, Tools & Crafting Specification** (II-001)
11. **Player Progression Specification** (PR-001)
12. **NPC & Quest Systems Specification** (NQ-001)
13. **Narrative & Mystery Specification** (ST-001)
14. **Economy Specification** (EC-001)
15. **Multiplayer & Social Systems Specification** (MS-001)

The order may be adjusted when dependencies require it.

---

# 57. Definition of Done for Core Gameplay

The Core Gameplay foundation is considered complete when:

* The major gameplay pillars are defined.
* The primary gameplay loop is defined.
* The expedition loop is defined.
* The three-space world structure (Main Island, Personal Island, Guild Islands) is defined.
* Player progression categories are defined.
* Farming is defined at the system level.
* Hunting/combat is defined at the system level.
* Building is defined at the system level.
* Exploration is defined at the system level.
* Inventory philosophy is defined.
* Time/day/night philosophy is defined.
* Defeat/resource-loss philosophy is defined.
* Introductory player experience is defined.
* Future economy boundaries are defined.
* Social/competitive boundaries are defined.
* Core gameplay invariants are established.
* Detailed unresolved mechanics are explicitly deferred to their appropriate specifications.

---

# 58. Current Status

**CORE GAMEPLAY SYSTEMS SPECIFICATION V1.0 — DESIGN FOUNDATION COMPLETE**

The major decisions currently locked are:

| System                | Decision                                     |
| --------------------- | -------------------------------------------- |
| Game structure        | Three-space open world (Main, Personal, Guild Islands) |
| Main world            | Main Island                                  |
| Player world          | Personal Island                              |
| Core Gameplay Pillars (Lifestyles) | Farming, Hunting, Mining, Fishing, Animal Husbandry |
| Core World Systems (Infrastructure) | Building, Trading/Economy, Social, World/Exploration, Combat, Inventory, Quests/Progression, Crafting |
| Inventory             | Limited slots                                |
| Stamina               | **Removed**                                  |
| Time                  | Traditional game day                         |
| Seasons               | Deferred                                     |
| Night                 | Atmospheric + gameplay relevant              |
| Combat                | Simple                                       |
| Defeat                | Non-lethal                                   |
| Defeat consequence    | Lose current expedition resources + time     |
| Return home           | Voluntary                                    |
| Island travel         | Boat + dock                                  |
| Building              | Functional + creative                        |
| Farming               | Moderately strategic                         |
| NPCs                  | Story/quest focused                          |
| Story                 | Character-driven + adventure                 |
| Mystery               | Dark underlying mystery                      |
| Progression           | Character + skills + house + island + wealth |
| Economy               | Labor + markets + ownership eventually       |
| Multiplayer           | Single-player-first, native co-op (ETA-001/MS-001) |
| Competition           | Optional                                     |
| Tutorial              | Narrative-driven first 10–15 minutes         |
| Long-term gameplay    | Open-ended                                   |

---

## 59. Final Design Principle

The entire system should ultimately support one experience:

> **Underhallow should give the player a world they can enter, inhabit, explore, shape and eventually uncover.**

The player should not feel like they are completing a game system.

They should feel like they are **living inside a game world**.
