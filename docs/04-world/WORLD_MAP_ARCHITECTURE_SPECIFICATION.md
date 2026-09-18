# UNDERHALLOW

## World & Map Architecture Specification

### Version 1.0

**Document ID:** WM-001  
**Status:** APPROVED  
**Authority Level:** Level 1 — Foundation Specification  
**Parent Documents:**  
* [North Star V1.0 (NS-001)](../01-product/NORTH_STAR.md)  
* [Creative Direction V1.0 (CD-001)](../06-art/CREATIVE_DIRECTION.md)  
* [Art Direction Bible V1.0 (AD-001)](../06-art/ART_DIRECTION_BIBLE.md)  
* [World Bible V1.0 (WB-001)](WORLD_BIBLE.md)  
* [Engine & Technical Architecture Specification V1 (ETA-001)](../02-architecture/ENGINE_TECHNICAL_ARCHITECTURE_SPECIFICATION.md)  
* [Core Gameplay Systems Specification V1.0 (CG-001)](../03-gameplay/CORE_GAMEPLAY_SYSTEMS_SPECIFICATION.md)  
* [Player Control, Movement & Interaction Specification V1.0 (PC-001)](../03-gameplay/PLAYER_CONTROL_MOVEMENT_INTERACTION_SPECIFICATION.md)  
* [Biome & Environment Bible V1.1 (BE-001)](BIOME_ENVIRONMENT_BIBLE.md)  
* [Creature & Wildlife Bible V1.0 (CW-001)](CREATURE_WILDLIFE_BIBLE.md)  
* [Master Specification Index & Build Governance V1.0 (MSI-001)](../00-governance/MASTER_SPECIFICATION_INDEX.md)  

**Primary Domain:** World Architecture  
**Scope:** Main Island, Personal Island, world topology, scale, traversal, environmental simulation boundaries, map structure, exploration architecture, and future expansion  

---

# 1. Purpose

This specification defines the physical, spatial, and logical architecture of the Underhallow world.

It establishes:

* the canonical structure of the V1 world;
* the relationship between the Main Island and Personal Islands;
* Main Island topology and geographic continuity;
* world scale and travel-time design philosophy;
* layered world accessibility and natural gating;
* Personal Island constrained terrain editing and connected grid expansion;
* selective authored world persistence;
* temporary environmental geography and access changes;
* meaningful and restrained elevation/verticality;
* fast-travel and traversal constraints;
* boat/dock world transition topology;
* landmark philosophy and spatial readability;
* regional organization and world density;
* resource, time, and weather boundaries;
* non-lethal defeat world return;
* world-level failure and macro loops;
* architectural boundaries separating world topology from system mechanics.

This document intentionally defines **world architecture rather than individual gameplay systems**. Farming, combat, progression, NPC behavior, economy, building mechanics, and narrative systems depend upon this document but are specified in their respective system specifications.

---

# 2. World Design Vision

Underhallow is built around a world that feels:

> **cozy, peaceful, explorable, alive, and slightly mysterious.**

The emotional balance reflects **Creative Invariant 11**: ~65% Cozy Life / ~35% Adventure with mystery underlying both. The world encourages players to wander without making wandering feel mandatory.

The player experiences:

* recognizable, orienting landmarks;
* peaceful, atmospheric empty spaces;
* rewarding discoveries;
* hidden paths and caves;
* grounded settlements and living communities;
* environmental storytelling;
* abundant natural resources;
* believable wildlife ecology;
* subtle, unexplained mysteries.

The world does not feel like a collection of disconnected gameplay arenas or an artificial theme park. It feels like:

> **a real place that happens to contain a game.**

---

# 3. Canonical V1 World Structure

Underhallow V1 canonically consists of **two primary authored world spaces**:

### A. Main Island
* The primary communal and open-world environment of Underhallow.
* Contains Town Square and secondary settlements.
* Contains major resident NPCs and living community routines.
* Contains the overarching world narrative, regional lore, and quests.
* Contains diverse exploration regions and deep wilderness.
* Contains major landmarks, ruins, and points of interest.
* Contains coastal docks and travel infrastructure.
* Hosts the vast majority of adventure and communal world activity.

### B. Personal Island
* A private, player-owned island sanctuary.
* Every player begins with the same foundational baseline layout.
* Players progressively develop and customize their island over time.
* Contains the player's inherited cottage/home and private grounds.
* Contains unlockable, connected terrain grids.
* Supports farming, building construction, decorative placement, storage, workshops, and personal progression.
* Is smaller than the Main Island, maintaining an intimate, manageable scale.
* Remains an emotional destination (*"This is mine"*) rather than a sterile storage or farming menu.

### C. Future Social / Guild Spaces (Guild Islands Deferred)
* Guild Islands and communal guild-owned territories are **deferred beyond V1.0**.
* The world architecture is designed to be multiplayer-ready, but Guild Islands are not a V1-required world layer.
* V1 single-player-first world architecture focuses strictly on the relationship between the Main Island and the Personal Island. Future guild spaces will be integrated additively without disrupting V1 foundations.

---

# 4. Main Island Topology & Geographic Continuity

The canonical rule for Underhallow V1 is:

> **The Main Island is ONE PRIMARY CONTINUOUS LANDMASS.**

It encompasses diverse, organically interconnected terrain:
* temperate forests and quiet woodlands;
* rolling hills and agricultural valleys;
* natural rivers, ponds, and freshwater lakes;
* coastal beaches, rocky bluffs, and sea caves;
* wetlands, moors, and coastal marshes;
* working farmlands and orchard estates;
* Town Square and outlying hamlets;
* ancient ruins, crumbling stone walls, and forgotten shrines;
* rugged wilderness zones;
* small offshore islets accessible by wading, sandbars, or rowboats.

### Anti-Fragmentation Invariant:
The Main Island must **never be divided into disconnected mini-maps or instanced corridors**. The player navigates a seamless, cohesive landmass. The intended player experience is:

> *"This is one real place that I am gradually learning."*

Players develop physical spatial memory of roads, ridges, waterways, and tree lines through repeated, natural traversal.

---

# 5. World Scale & Traversal Philosophy

The Main Island is designed as a **medium-scale world**.

Scale is governed by experiential design constraints rather than arbitrary tile counts:
* **Meaningful Traversal Distances:** Crossing between major regions requires deliberate travel, giving weight to expeditions.
* **Landmark Visibility:** Major landmarks can be sighted from surrounding high ground or clearings, orienting the traveler without interface clutter.
* **Balanced Density:** Safe, settled farmlands provide comfort and clarity; deep wilderness provides isolation and tension.
* **Neither MMO nor Theme Park:** Avoid the vast, empty deserts of MMO scale; avoid the hyper-compressed theme-park density where biomes collide unnaturally every twenty paces.

### Travel-Time Philosophy:
Travel time serves as a core pacing mechanism:
* Important early-game locations (Town Square, neighboring farms, initial forest edge) are comfortably reachable on foot within short, pleasant walks.
* Deeper wilderness, high ridges, and remote ruins require deliberate expedition planning.
* Players naturally discover shortcuts, cleared trails, and familiar bypasses as they progress.
* Travel provides constant opportunities for observation, foraging, wildlife spotting, and environmental storytelling.
* Traversal must never become tedious, artificial padding. Base walking speed is continuous and reliable; stamina depletion is strictly prohibited.

---

# 6. World Accessibility & Layered Gating

Underhallow adopts the foundational accessibility philosophy:

> **THE WORLD IS BROADLY EXPLORABLE EARLY, BUT FULL ACCESS TO ITS VALUE IS PROGRESSIVE.**

World access is structured into five distinct operational layers:

| Access Layer | Player Experience | Example |
| :--- | :--- | :--- |
| **1. Visibility** | The player can see or learn about an area from afar. | Sighting a ruined tower on a distant ridge across the river valley. |
| **2. Physical Access** | The player can physically reach the geographic area. | Walking along the riverbank or discovering a ford across shallow water. |
| **3. Functional Access** | The player possesses the tools, skills, or capacity to interact. | Requiring an iron pickaxe to quarry hard granite, or a boat to cross deep water. |
| **4. Content Access** | Story events, quests, or resident trust unlock deeper interactions. | Gaining entry to a locked crypt or earning an NPC's key to an old mill. |
| **5. Resource Access** | Specific yields require environmental conditions or expertise. | Foraging night-blooming mushrooms or harvesting seasoned timber. |

### Natural Gating over Arbitrary Barriers:
Arbitrary invisible walls are strictly forbidden. Access barriers must be physically and diegetically grounded:
* fallen timbers requiring an axe to clear;
* dense bramble thickets;
* broken stone bridges requiring community or personal repair;
* steep rocky bluffs requiring finding the natural switchback trail;
* deep waterways requiring a boat or bridge;
* weather-locked passes or seasonal conditions;
* locked gates requiring narrative progression or keys.

The player should frequently think: *"I could probably get over there if I find a way around,"* rather than: *"The interface says I am under-leveled."*

---

# 7. Personal Island Architecture & Relationship to Main Island

The Personal Island is not a separate mini-game or disconnected menu; it is an intrinsic part of the same physical world.

The macro spatial relationship operates as:

```text
       Main Island (Communal Adventure)
  [Town / Quests / NPCs / Wilderness / Dungeons]
                       ↕
               Coastal Dock Ferry
                       ↕
       Personal Island (Private Sanctuary)
  [Home / Farming / Building / Rest / Storage]
```

### Purpose of the Personal Island:
* **Private Sanctuary:** A safe, permanent haven free from hostile threats, competition, or non-consensual griefing.
* **Home & Restoration:** The emotional anchor where the player sleeps, organizes items, and recovers after expeditions.
* **Creative Expression:** The primary canvas for building structures, planting crops, landscaping, and decorating.
* **Economic Engine:** Space for productive workshops, crop fields, storage facilities, and animal shelters.
* **Non-Mandatory Freedom:** The Personal Island is a sanctuary, not a prison. Players who prefer hunting, foraging, or exploring the Main Island are never forced to maintain an industrial farm.

---

# 8. Personal Island Terrain Editing Boundaries

To protect architectural stability, visual cohesion, and performance, Personal Island terrain modification operates under strict V1 boundaries:

### Supported V1 Terrain Modifications:
* clearing wild trees, stumps, and fallen branches;
* clearing loose surface stones, weed clusters, and ground clutter;
* tilling soil into agricultural plots (via farming tools governed by [FB-001](../03-gameplay/FARMING_SYSTEM_SPECIFICATION.md));
* laying constructed pathways (stone, brick, wood planks, gravel);
* surface landscaping and cosmetic ground cover painting (grass, dirt, packed earth);
* placing buildings, workshops, fences, and outdoor furniture (governed by [BI-001](../03-gameplay/BUILDING_CONSTRUCTION_SYSTEM_SPECIFICATION.md));
* planting domestic crops, orchard saplings, and decorative flora.

### NOT Supported in V1 (Constrained Architecture):
* unrestricted voxel-style 3D terrain sculpting;
* arbitrary elevation lifting or lowering;
* freeform cliff creation or excavation;
* arbitrary water carving or ocean trenching;
* river redirection or dynamic fluid simulation;
* fully deformable or destructive world geometry.

The island's primary coastal cliffs, shoreline contours, and baseline elevation shelves remain authored. Customization transforms the surface without breaking the island's geographic integrity.

---

# 9. Personal Island Connected Grid Expansion

The Personal Island expands through **Connected Player-Selected Grid Expansion**:

1. **Baseline Foundation:** Every player begins with a standardized starting territory containing the inherited cottage, a modest yard, a small dock, and initial clearable land.
2. **Expansion Grids:** Surrounding island territory is divided into logical expansion grids following the island's authored landmass.
3. **Coherent Adjacency:** A player may only unlock an expansion grid that directly shares a boundary with already unlocked territory. Isolated or disconnected island claims are impossible.
4. **Meaningful Choice:** When multiple adjacent grids are available, the player chooses their expansion trajectory (e.g., expanding eastward toward the meadow versus northward toward the pine bluff).
5. **Permanence:** Once unlocked, grid access is permanent.
6. **System Boundaries:** Unlocking requirements (currency, deeds, community favor) are governed by Economy ([EC-001](../00-governance/MASTER_SPECIFICATION_INDEX.md)) and Personal Island Design ([PI-001](PERSONAL_ISLAND_DESIGN_SPECIFICATION.md)). WM-001 defines the spatial grid topology, not the economic pricing.

---

# 10. World Persistence: Selective Authored Persistence

Underhallow utilizes **Selective Authored Persistence** to balance player agency with living ecological renewal:

### What Persists (World Memory):
* repaired bridges, cleared highway blockages, and restored landmarks;
* completed world construction and community restoration projects;
* unlocked gates, opened doors, and discovered secret passages;
* persistent NPC relationship milestones and story state mutations;
* all player construction, farming, and decoration on the Personal Island;
* major quest consequences that alter settlements or regional accessibility.

### What Regenerates (Ecological Cycle):
* ordinary wild forage nodes (berries, mushrooms, herbs);
* harvestable timber trees and surface stones in designated wild zones;
* ambient wildlife populations and creature spawns (governed by [CW-001](CREATURE_WILDLIFE_BIBLE.md));
* temporary weather effects and seasonal cycles;
* transient world events and festival decorations.

The governing principle is:

> *"A world that remembers important things, but breathes and renews its life."*

The world does not permanently record every minor footprint or broken branch, preventing save-file bloat while making meaningful accomplishments permanent.

---

# 11. Temporary World Changes & Dynamic Access

The Main Island supports authored, event-driven, or environmental access changes that temporarily alter world topology:

* **Hydrological Freezes:** Bitter cold spells freezing shallow rivers or lake margins, allowing players to walk across water into otherwise isolated grottos.
* **Tidal Exposures:** Low-tide conditions revealing passable sandbars leading to offshore sea caves or islets.
* **Festival Grounds:** Town Square or village greens transforming with temporary stalls, pavilions, and lanterns during seasonal celebrations.
* **Storm Obstructions:** Severe tempests temporarily blocking a low road with a fallen tree, forcing travelers to use the scenic ridge path until cleared.
* **Special Visitors:** Wandering merchants, traveling herbalists, or tinkerers establishing temporary camps at roadside clearings.

These changes are **authored, readable, and purposeful**. They create memorable moments of discovery without introducing chaotic procedural volatility.

---

# 12. Meaningful but Restrained Verticality

Verticality in Underhallow is designed to enhance visual composition and navigation while maintaining strict isometric readability:

* **Navigational Overlooks:** High ridges and cliff terraces offer commanding views over lower river valleys, farmlands, and coastal bays, aiding orientation.
* **Layered Exploration:** Caves beneath limestone bluffs, subterranean cellars beneath ruins, and multi-tier village streets create depth.
* **Restrained Mechanics:** Underhallow is **not a platformer**. There is no jumping mechanic, ledge-grabbing, or freeform falling. Traversal between elevations utilizes authored ramps, stairs, switchbacks, and gentle slopes.
* **Isometric Depth Clarity:** Raised terrain uses clean orthogonal cliff faces and stepped contours, ensuring players never get lost behind towering vertical geometry.

---

# 13. Traversal & Fast Travel Philosophy

Physical world traversal is an essential gameplay pillar of Underhallow:

* **Walking is Foundational:** Moving on foot is the primary means of experiencing the world. Normal locomotion speed is steady, responsive, and entirely free from stamina or energy meters (PC-001 / Invariant 5).
* **Boats Connect Islands:** Travel between the Main Island and the Personal Island is handled through physical boat and dock networks.
* **No Unrestricted Teleportation:** Instant, universal map teleportation is strictly prohibited in V1.0. Players cannot open a map menu and teleport anywhere at will.
* **Future Convenience Travel:** If convenience travel mechanisms (e.g., regional carriage routes, ferry stops) are introduced in later expansions, they must be:
  * unlocked through progression or infrastructure repair;
  * limited to specific fixed transit nodes (e.g., dock to dock, town gate to crossroads);
  * world-integrated and diegetic;
  * subordinate to physical world exploration.

---

# 14. Boat & Dock World Transition Architecture

WM-001 establishes the physical and topological framework for dock travel:

```text
Player Interacts with Dock Boat at Personal Island
                         ↓
            Player Controls Locked (PC-001)
                         ↓
        Diegetic Transition Presentation (Fade / Wake)
                         ↓
           Target Main Island Scene Loaded
                         ↓
        Player Positioned at Canonical Dock Marker
                         ↓
        Camera Aligned & Player Controls Restored
```

* **Physical Docks:** Every travel route connects two physically authored dock structures.
* **Topology Ownership:** WM-001 owns dock locations, water clearances, pier geometry, and spawn marker placement.
* **System Boundaries:** Transportation mechanics, vessel upgrades, travel fares, ferry timetables, and travel UX are governed by Transportation & Travel ([TR-001](../00-governance/MASTER_SPECIFICATION_INDEX.md)). WM-001 defines the physical connection points.

---

# 15. Player Agency in World Architecture

The world layout actively enforces **The Prime Directive** and **Invariant 2**:

> *"Do not build Underhallow as a collection of features. Build it as a world."*

World topology must support all valid player playstyles without structural prejudice:
* **The Dedicated Farmer:** Can spend entire cycles cultivating crops, developing personal plots, and trading at the village market without being forced into dangerous wilderness.
* **The Wilderness Hunter:** Can venture into deep forests, mountain ridges, and coastal bluffs, tracking wildlife and returning raw goods directly to regional butchers or merchants (Invariant 13).
* **The Builder / Decorator:** Can focus on quarrying stone, felling timber, restoring ruins, and expanding homestead architecture.
* **The Explorer / Wanderer:** Can spend hours discovering unmarked caves, ancient inscriptions, secluded fishing spots, and environmental secrets.

The world map contains no mandatory chokepoints that force an explorer to become an industrial farmer, nor does it force a peaceful farmer into monster combat.

---

# 16. Exploration Design & Hidden Locations

Exploration is a primary pillar of Underhallow. The Main Island is densely layered with non-checklist discoveries:

* **Caves & Grottoes:** Concealed behind ivy curtains, waterfall sheets, or rocky crevices.
* **Ancient Ruins:** Weathered stone archways, sunken foundations, and overgrown stone circles dating to prior eras.
* **Secluded clearings:** Sheltered hollows with rare floral blooms or quiet spring pools.
* **Environmental Storytelling:** An abandoned campsite with a forgotten journal; a weathered wooden rowboat marooned high on a grassy bluff; an ancient boundary stone carved with strange symbols.
* **Non-Gated Secrets:** Not every secret requires a high-level tool or key. Many discoveries reward simple curiosity, observational vigilance, and the habit of revisiting familiar places at different times of day or under unusual weather.

---

# 17. World Landmark Philosophy & Spatial Orientation

The Main Island is navigated through **visual landmark orientation** rather than intrusive UI waypoints:

* **Primary Visual Anchors:** Tall, distinctive structures visible across multiple biomes (e.g., the Old Mill tower, the high limestone sea cliff, the crumbling central barrow, the great willow tree).
* **Secondary Waypoints:** Crossroads shrines, wooden bridges, stone mile markers, and distinctive tree formations that orient local travel.
* **Diegetic Navigation:** Players learn to navigate by spatial relationships:
  > *"Follow the river past the old stone bridge, turn right at the weeping willow, and the clearing lies behind the low limestone ridge."*
* **Minimap Subordination:** Minimaps and world maps support navigation but must not replace environmental engagement. Quest arrows must never turn the player's attention into a mindless line-following exercise.

---

# 18. World Readability & Spatial Clarity

Underhallow's fixed isometric perspective (AD-001 / PC-001) demands absolute spatial clarity:

* **Walkable Space Definition:** Walkable terrain, road surfaces, and pathways must be instantly distinguishable from impassable brush, deep water, and cliff faces.
* **Clean Collision Boundaries:** Scenery assets (trees, rock piles, walls) must have unambiguous physical collision footprints at their base, eliminating collision snagging or sticky corners.
* **Overhead Clearance:** Tree canopies, porch roofs, and archways must allow the character sprite to pass cleanly behind them with reliable depth sorting (Y-sorting) without triggering false collision blocks.
* **Controlled Visual Density:** Detail must enhance beauty without creating noisy visual clutter. Points of interest, doorways, and interactive objects must stand out clearly against the environmental background.

---

# 19. World Density & Atmospheric Empty Space

Content density is balanced to evoke a living, breathing countryside:

* **Intentional Breathing Room:** The world contains open meadows, quiet woodland groves, and long coastal paths that exist simply to provide atmosphere, quiet reflection, and spatial contrast.
* **Anti-Theme-Park Standard:** The map avoids cramming a treasure chest, monster, or NPC into every square meter. Over-density destroys the feeling of a believable, grounded world.
* **Rhythm of Travel:** Travel follows a natural cadence:
  $$\text{Settlement} \longrightarrow \text{Pastoral Outskirts} \longrightarrow \text{Open Wilderness} \longrightarrow \text{Notable Discovery} \longrightarrow \text{Safe Return}$$

---

# 20. Region & Biome Architecture

The Main Island is organized into distinct, organically flowing regions.

WM-001 defines the **architectural container and spatial layout**, while the [Biome & Environment Bible (BE-001)](BIOME_ENVIRONMENT_BIBLE.md) and [Main Island Design Specification (MI-001)](MAIN_ISLAND_DESIGN_SPECIFICATION.md) define the canonical environmental identities, ecotones, and regional lore.

### Core Regional Framework (Aligned with BE-001 & MI-001):
1. **Town Square & Valley Heart:** Communal center, council hall, shops, market green, river bridges.
2. **Old Farmlands & Homesteads:** Pastoral hedgerows, stone cottages, crop fields, windbreak trees.
3. **Whispering Woods / Sunlit Woodlands:** Broadleaf canopies, forest paths, lumber hollows, mossy glades.
4. **Eastern Coastal Bluffs & Docks:** Sea cliffs, rocky tidepools, fisherman shacks, sandy inlets, main travel pier.
5. **Western Moorlands & Heath:** Wind-swept grasses, granite outcrops, peat bogs, ancient boundary stones.
6. **Sunken Mire & Wetland Margin:** Reeds, stagnant channels, willow thickets, misty footpaths.
7. **Northern Ridge & Ancient Barrowlands:** High limestone terraces, pine groves, crumbling ruins, deep mystery sites.

Transitions between regions are physical and organic (ecotones), never abrupt biome hard-cuts.

---

# 21. Resource World Boundaries

WM-001 establishes the spatial distribution principles of natural resources across the world map:

* **Resource Territories:** Surface ores are found in rocky outcrops and highland cuts; hardwood timber in dense deep forests; common softwoods in woodland margins; wild herbs and berries along hedgerows and riverbanks.
* **Ownership Boundary:** WM-001 defines **where** resource zones lie and how they sit within the world topology. It does **not** define node hitpoints, tool tiers, extraction drop tables, harvest yields, or respawn timers. Those belong strictly to Resource Gathering, Forestry & Mining ([RG-001](../00-governance/MASTER_SPECIFICATION_INDEX.md)) and Foraging & Wild Resources ([FR-001](../00-governance/MASTER_SPECIFICATION_INDEX.md)).

---

# 22. Time, Weather & Environmental Simulation Boundaries

The world map responds dynamically to environmental simulation:

* **Diurnal Cycles:** Regions undergo lighting, ambient sound, and activity shifts between morning, afternoon, twilight, and night.
* **Weather Footprints:** Rain dampens soil, enhances river flow, and generates atmospheric mist; clear days increase visibility across distant valley ridges.
* **Ownership Boundary:** WM-001 defines the spatial structures that respond to environmental conditions (e.g., a river basin that can flood or freeze). The numerical clock, day length, calendar, and scheduling are owned by Time & Simulation ([TS-001](../00-governance/MASTER_SPECIFICATION_INDEX.md)). Atmospheric parameters, precipitation tables, and storm mechanics are owned by Weather & Environmental Systems ([WE-001](../00-governance/MASTER_SPECIFICATION_INDEX.md)).

---

# 23. World Events & Flexible Communal Spaces

Communal spaces on the Main Island are architecturally flexible:

* **Multi-Use Town Green:** The central open green in Town Square serves as a daily thoroughfare, but is designed to host seasonal harvest festival stalls, midsummer bonfires, or temporary traveling caravans without altering the permanent map geometry.
* **Modular Placement:** Event fixtures (lantern posts, banquet tables, market tents) occupy designated spatial anchor points that activate and deactivate based on world state, preserving underlying navigation paths.

---

# 24. Multiplayer Readiness & Social Architecture

Underhallow is **single-player-first, multiplayer-native**:

* **Single-Player Baseline:** The entire V1 world map functions completely and coherently as a solitary, cozy adventure RPG. The world does not require other players to feel alive or functional.
* **Multiplayer Additive Architecture:** World layouts (pathway widths, door clearances, dock sizes) are dimensioned to accommodate multiple players comfortably without crowding or blocking.
* **Deferred Guild Spaces:** Guild-owned islands, guild halls, and shared social hubs are planned for future multiplayer expansions (governed by [MS-001](../07-multiplayer/MULTIPLAYER_SOCIAL_SYSTEMS_SPECIFICATION.md)) and do not form part of the initial V1 world footprint.

---

# 25. The Macro World Loop

The world map architecture facilitates a continuous, natural gameplay loop:

```text
       [ Personal Island ]
       Home / Farm / Build / Prepare
               │
           (Boat Travel)
               ▼
        [ Main Island Dock ]
               │
               ▼
      [ Town Square & Hamlets ]
      Dialogue / Quests / Trade / Services
               │
               ▼
   [ Regional Wilderness & Ruins ]
   Explore / Hunt / Forage / Mine / Solve
               │
               ▼
      [ Meaningful Discovery ]
   Rare Resources / Lore / Dungeon / Landmark
               │
           (Return Travel)
               ▼
       [ Personal Island ]
   Unload / Upgrade / Rest / Develop / Grow
```

This macro loop represents an organic relationship between adventure and sanctuary, allowing players to move freely between outward discovery and home creation.

---

# 26. Failure, Defeat & Return to Home

In accordance with **Core Operating Invariant 6 (Non-Lethal Defeat & Expedition Loss)**:

* **The Physical Defeat Contract:** When a player's health is depleted in dangerous wilderness, dungeons, or ruins on the Main Island, they are not permanently killed or deleted.
* **Return Transition:** The player is cleanly transitioned from the defeat location back to their Personal Island cottage bed.
* **World State Continuity:** The Main Island world state remains intact. Resource loss (expedition inventory penalties) is processed by the combat and inventory systems ([HU-001](../03-gameplay/HUNTING_COMBAT_SYSTEM_SPECIFICATION.md), [PR-001](../03-gameplay/PLAYER_PROGRESSION_SPECIFICATION.md)); WM-001 defines the spatial return anchor at the player's home.

---

# 27. Specification Ownership Boundaries

To maintain rigorous governance across the specification library, WM-001 establishes clear boundaries:

| System / Domain | Governing Specification | WM-001 Boundary |
| :--- | :--- | :--- |
| **World Topology & Scale** | **WM-001 (This Document)** | **Authoritative.** Owns world structure, scale, island connectivity, and spatial design. |
| **Player Locomotion & Control** | [PC-001](../03-gameplay/PLAYER_CONTROL_MOVEMENT_INTERACTION_SPECIFICATION.md) | WM-001 provides the physical spaces; PC-001 owns input, movement, camera follow, and interaction. |
| **Engine & Technical Pipeline** | [ETA-001](../02-architecture/ENGINE_TECHNICAL_ARCHITECTURE_SPECIFICATION.md) | WM-001 defines spatial requirements; ETA-001 owns Godot nodes, chunk streaming, and netcode. |
| **Biome & Environmental Identity** | [BE-001](BIOME_ENVIRONMENT_BIBLE.md) | WM-001 houses the biomes; BE-001 owns environmental laws, layer models, flora, and ecotones. |
| **Creatures & Ambient Wildlife** | [CW-001](CREATURE_WILDLIFE_BIBLE.md) | WM-001 provides habitat space; CW-001 owns wildlife laws, taxonomies, and routines. |
| **Main Island Regional Layout** | [MI-001](MAIN_ISLAND_DESIGN_SPECIFICATION.md) | WM-001 establishes the continuous island rule; MI-001 details specific regional maps. |
| **Personal Island Layout & Progression** | [PI-001](PERSONAL_ISLAND_DESIGN_SPECIFICATION.md) | WM-001 defines baseline grid expansion; PI-001 details house stages and plots. |
| **Building & Construction** | [BI-001](../03-gameplay/BUILDING_CONSTRUCTION_SYSTEM_SPECIFICATION.md) | WM-001 defines buildable terrain rules; BI-001 owns construction recipes, snapping, and tools. |
| **Farming Mechanics** | [FB-001](../03-gameplay/FARMING_SYSTEM_SPECIFICATION.md) | WM-001 defines agricultural plots; FB-001 owns soil, crop growth, and seeds. |
| **Hunting & Combat** | [HU-001](../03-gameplay/HUNTING_COMBAT_SYSTEM_SPECIFICATION.md) | WM-001 provides wilderness terrain; HU-001 owns creature stats, weapons, and damage. |
| **Resource Gathering & Forestry** | [RG-001](../00-governance/MASTER_SPECIFICATION_INDEX.md) | WM-001 defines node locations; RG-001 owns node durability, tools, and drop tables. |
| **Foraging & Wild Plants** | [FR-001](../00-governance/MASTER_SPECIFICATION_INDEX.md) | WM-001 defines gathering zones; FR-001 owns wild plant tables and regeneration timers. |
| **Transportation & Travel** | [TR-001](../00-governance/MASTER_SPECIFICATION_INDEX.md) | WM-001 defines docks and piers; TR-001 owns ferry schedules, boat costs, and transit UX. |
| **Time & Simulation** | [TS-001](../00-governance/MASTER_SPECIFICATION_INDEX.md) | WM-001 defines physical day/night changes; TS-001 owns the clock, calendar, and simulation ticks. |
| **Weather & Atmosphere** | [WE-001](../00-governance/MASTER_SPECIFICATION_INDEX.md) | WM-001 defines weather-reactive paths; WE-001 owns precipitation, storm systems, and fog. |
| **Multiplayer & Social Systems** | [MS-001](../07-multiplayer/MULTIPLAYER_SOCIAL_SYSTEMS_SPECIFICATION.md) | WM-001 ensures spatial readiness; MS-001 owns party systems, visitor permissions, and guild islands. |

---

# 28. World Architecture Invariants

The following immutable invariants govern all world design and map authoring in Underhallow:

* **WM-I01 — Canonical Two-Island Structure:** Underhallow V1 consists of two canonical authored island spaces: the Main Island and the Personal Island. Guild Islands are deferred to future expansions.
* **WM-I02 — Continuous Main Island Landmass:** The Main Island is one primary, contiguous landmass. It must never be fragmented into disconnected, instanced mini-maps.
* **WM-I03 — Private Sanctuary Invariant:** The Personal Island is an unassailable private player sanctuary, supporting customizable housing, farming, building, and peaceful retreat.
* **WM-I04 — Standardized Baseline Island:** Every player starts with the identical foundational Personal Island layout, from which personal customization organically develops.
* **WM-I05 — Connected Grid Expansion:** Personal Island expansion occurs strictly through player-selected, permanently unlocked grids that share a border with already unlocked land.
* **WM-I06 — Constrained Terrain Editing:** V1 Personal Island terrain modification supports clearing, landscaping, paths, planting, and building placement; freeform voxel sculpting, cliff excavation, and river redirection are prohibited.
* **WM-I07 — Medium World Scale:** The Main Island is medium-scale, avoiding both sprawling MMO emptiness and hyper-compressed theme-park density.
* **WM-I08 — Travel-Time Constraint:** Pacing is governed by travel time; essential locations are reachable on foot, while deep wilderness requires deliberate expedition planning.
* **WM-I09 — No Stamina Traversal:** Traversal speed and endurance are never restricted by stamina or energy meters.
* **WM-I10 — No Unrestricted Teleportation:** Universal menu-based fast travel is prohibited in V1. Travel between islands occurs diegetically via boats and docks.
* **WM-I11 — Natural Layered Gating:** Access restrictions favor physical barriers, tool requirements, environmental states, and world knowledge over arbitrary level locks or invisible walls.
* **WM-I12 — Selective Authored Persistence:** The world selectively preserves major structural repairs, unlocked routes, story changes, and personal island development, while regenerating ordinary resources and wildlife.
* **WM-I13 — Meaningful Restrained Verticality:** Verticality provides viewpoints, cave grottos, and layered navigation; Underhallow is not a platformer and contains no jump mechanics.
* **WM-I14 — Visual Landmark Navigation:** Exploration relies on visual landmarks, natural terrain features, and player memory rather than constant minimap waypoint following.
* **WM-I15 — Spatial Readability First:** Isometric layouts prioritize clean walkable paths, obvious collision bounds, and clutter-free interactive spaces.
* **WM-I16 — Authored World Integrity:** Major world terrain, landmarks, settlements, and narrative spaces are meticulously authored, not procedurally generated.
* **WM-I17 — Fixed Isometric Presentation:** The world is designed and authored exclusively for a fixed isometric perspective ($2:1$ dimetric) with zoom support; camera rotation is disabled in V1.
* **WM-I18 — Responsive Environmental Geometry:** The world topology accommodates dynamic environmental events (freezes, tides, festivals) without corrupting permanent geometry.
* **WM-I19 — Non-Lethal Defeat Return:** Health depletion triggers an expedition return to the Personal Island cottage, preserving permanent character progression.
* **WM-I20 — Single-Player-First, Multiplayer-Ready:** The world is fully functional and satisfying as a single-player game, while architecturally engineered to support seamless multiplayer additions.

---

# 29. Technical & Map Segmentation Guidelines

To ensure stable 60 FPS performance on target PC hardware within Godot (per ETA-001):

* **Segmented Regional Streaming:** The continuous Main Island is authored in logical chunks/regions, streamed into active memory based on player proximity.
* **Y-Sorting Depth Layering:** All entities, structures, trees, and terrain props conform to a unified 2D isometric Y-sorting coordinate plane.
* **Memory Management:** Distant regions operate in an abstracted simulation state; high-fidelity rendering, collision detection, and entity spawning are restricted to active local chunks.
* **Load Boundary Concealment:** Region transitions occur naturally along winding paths, tree canopies, mountain cuts, or short dock sequences, avoiding jarring loading freezes.

---

# 30. Open Questions

### Blocking Questions:
* *None.* All core foundation questions regarding world structure, island topology, scale, accessibility, personal terrain editing, persistence, fast travel, and system boundaries are resolved and approved.

### Deferred Questions (To be detailed in regional and system specifications):
1. **Exact Tile Boundaries:** Precise coordinate extents for individual regional chunk borders (to be established during Godot scene authoring).
2. **Grid Plot Square Footages:** Exact pixel dimensions for Personal Island expansion grid parcels (owned by [PI-001](PERSONAL_ISLAND_DESIGN_SPECIFICATION.md)).
3. **Event Anchor Coordinates:** Specific Vector2 anchor points for Town Square festival tent layouts (owned by [EV-001](../00-governance/MASTER_SPECIFICATION_INDEX.md)).
4. **Seasonal Waterway Freeze Dates:** Exact calendar days on which specific river fords become frozen and passable (owned by [TS-001](../00-governance/MASTER_SPECIFICATION_INDEX.md) and [WE-001](../00-governance/MASTER_SPECIFICATION_INDEX.md)).

---

# 31. Definition of Done & Validation Criteria

WM-001 is considered fully approved and ready to govern level design and technical map production when:

* The canonical two-island structure (Main Island + Personal Island) is firmly codified and distinguished from deferred guild spaces.
* The continuous landmass rule for the Main Island is established, prohibiting fragmented mini-maps.
* Personal Island terrain editing boundaries (clearing, decorating, planting, building; no freeform sculpting) are locked.
* Connected grid expansion for Personal Islands is topologically defined.
* Selective authored persistence rules are clearly separated from natural resource regeneration.
* Travel-time constraints and the complete prohibition of unrestricted teleportation are enforced.
* Physical boat and dock transition topology is specified without duplicating TR-001 mechanics.
* Meaningful, restrained verticality is defined without introducing jumping or platforming mechanics.
* Visual landmark navigation principles and isometric readability standards are established.
* All cross-system ownership boundaries are cleanly delineated against governing specifications.
* All specification cross-references are audited against MSI-001 with 100% portable relative links.

---

# 32. Final World Architecture Statement

> **The world of Underhallow is designed to be lived in, not merely passed through. It is an enduring home and an ancient mystery; a place where cozy farmlands and quiet hearths rest beside shadowed forests and forgotten ruins. Every road, river, cliff, and clearing exists with deliberate purpose—to invite curiosity, reward exploration, and give the player a world they can truly call home.**
