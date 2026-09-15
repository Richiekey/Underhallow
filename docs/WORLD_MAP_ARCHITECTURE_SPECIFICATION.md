# UNDERHALLOW

## World & Map Architecture Specification

### Version 1.0

**Document ID:** WM-001  
**Status:** DRAFT  
**Authority Level:** Level 1 — Foundation Specification  
**Parent Documents:**  
* [North Star V1.0 (NS-001)](file:///c:/Users/HP/Documents/Underhallow/docs/NORTH_STAR.md)  
* [Technical Architecture Specification V1.0 (TA-001)](file:///c:/Users/HP/Documents/Underhallow/docs/TECHNICAL_ARCHITECTURE.md)  
* [Core Gameplay Systems Specification V1.0 (CG-001)](file:///c:/Users/HP/Documents/Underhallow/docs/CORE_GAMEPLAY_SYSTEMS_SPECIFICATION.md)  
* [Player Control, Movement & Interaction Specification V1.0 (PC-001)](file:///c:/Users/HP/Documents/Underhallow/docs/PLAYER_CONTROL_MOVEMENT_INTERACTION_SPECIFICATION.md)  
**Primary Domain:** World Architecture  
**Scope:** Main Island, Personal Island, world regions, terrain, traversal, environmental simulation, map structure, exploration architecture, and future expansion  

---

# 1. Purpose

This specification defines the physical and logical architecture of the Underhallow world.

It establishes:

* the structure of the world;
* the relationship between the Main Island and Personal Islands;
* regional and biome organization;
* world scale and traversal philosophy;
* terrain and elevation rules;
* water and environmental boundaries;
* Town Square and other settlements;
* Personal Island expansion;
* exploration and hidden areas;
* resource and wildlife persistence;
* time-based world behavior;
* map/chunk architecture;
* procedural-generation boundaries;
* future expansion requirements.

This document intentionally defines **world architecture rather than individual gameplay systems**.

Farming, combat, progression, NPC behavior, economy, building mechanics, and narrative systems may depend upon this document but are specified separately.

---

# 2. World Design Vision

Underhallow is built around a world that feels:

> **cozy, peaceful, explorable, alive, and slightly mysterious.**

The world should encourage players to wander without making wandering feel mandatory.

The player should frequently experience:

* recognizable landmarks;
* peaceful empty spaces;
* interesting discoveries;
* hidden paths;
* unusual locations;
* environmental storytelling;
* useful resources;
* NPC activity;
* unexplained mysteries.

The world should not feel like a collection of disconnected gameplay arenas.

It should feel like:

> **a real place that happens to contain a game.**

---

# 3. Core World Structure

Underhallow initially consists of two major world spaces:

1. **Main Island**
2. **Personal Island**

They are distinct authored world spaces connected through a deliberate travel system.

The player does not simply walk from one into the other.

Travel occurs through the established **boat/dock system**.

---

# 4. Main Island

The Main Island is the primary shared adventure space.

It contains:

* Town Square;
* settlements;
* wilderness;
* farms and natural areas;
* forests;
* water systems;
* exploration locations;
* resource areas;
* NPC locations;
* creature habitats;
* hidden areas;
* quests;
* story locations;
* landmarks;
* special points of interest.

The Main Island is the primary environment for:

> **events, exploration, discovery, NPC interaction, quests, adventure, and the broader world story.**

---

# 5. Personal Island

Each player receives a Personal Island.

The starting Personal Island has a common foundational layout shared by all players.

Every player begins with:

* the same fundamental island structure;
* a home;
* initial usable land;
* an expansion system based on unlockable grids.

Individual identity emerges through:

* farming;
* building;
* decoration;
* landscaping;
* resource use;
* structures;
* furniture;
* future customization systems.

The Personal Island therefore functions as both:

> **the player's home and their personal expression of the Underhallow world.**

---

# 6. Main Island vs Personal Island

| Characteristic | Main Island | Personal Island |
| :--- | :--- | :--- |
| **Purpose** | Adventure/world | Home/personal space |
| **Ownership** | Shared world | Individual player |
| **Scale** | Medium | Expandable |
| **NPCs** | Major role | Limited/specialized |
| **Exploration** | High | Moderate |
| **Farming** | Possible | Major |
| **Building** | Limited/controlled | Major |
| **Customization** | Low/moderate | High |
| **Story** | Major | Supporting |
| **Secrets** | Major | Possible |
| **Expansion** | World updates | Player unlocks |
| **Visitors** | Shared by default | Player-controlled/social system later |

---

# 7. World Regions

The Main Island uses clearly identifiable regions while maintaining natural transitions between them.

Regions should not feel like arbitrary boxes placed beside one another.

Instead, geography should explain their existence.

For example:

* forest transitions into woodland;
* woodland transitions into farmland;
* farmland approaches settlement;
* hills rise toward higher terrain;
* rivers divide or connect regions;
* coastlines define the island's boundaries.

The player should be able to recognize a region through:

* terrain;
* vegetation;
* architecture;
* lighting;
* ambient effects;
* resources;
* creatures;
* NPC activity;
* landmarks.

---

# 8. Biome Philosophy

Underhallow uses a moderate number of biomes/regions at launch.

The project should favor **distinctive quality over excessive variety**.

Every significant biome should have a gameplay identity in addition to visual identity.

A biome may differentiate itself through:

* resources;
* wildlife;
* crops;
* environmental conditions;
* NPCs;
* quests;
* secrets;
* traversal requirements;
* story relevance.

A biome that is only a recolored version of another biome should generally be avoided.

---

# 9. World Scale

The Main Island is a **medium-scale world**.

The objective is to provide enough space for:

* exploration;
* discovery;
* travel;
* landmarks;
* secrets;
* regional identity;

without producing excessive traversal time.

The player should not feel that simply getting from one meaningful location to another is a chore.

At the same time, the world should not be so compressed that:

* every location is visible immediately;
* exploration becomes trivial;
* regions lose identity;
* peaceful empty space disappears.

---

# 10. Traversal Philosophy

Traversal follows a hybrid philosophy:

> **Travel should be reasonably efficient while wandering should remain rewarding.**

The player should be able to intentionally travel toward a known destination without unnecessary friction.

However, the world should provide enough environmental interest that players naturally deviate from their route.

Examples:

> *“What's that path?”*  
> *“I've never seen that cave before.”*  
> *“I wonder what's behind that hill.”*  
> *“Why is that NPC standing there at night?”*  

This philosophy is central to Underhallow's exploration experience.

---

# 11. Empty Space

Some world areas should intentionally contain limited gameplay content.

These areas provide:

* visual breathing room;
* peaceful traversal;
* environmental atmosphere;
* opportunities for future additions;
* contrast with denser areas.

Not every section of the map should contain:

* an item;
* an NPC;
* a quest;
* a secret;
* a resource;
* or an interaction.

The world must avoid becoming a continuous reward dispenser.

---

# 12. Navigation

Navigation should combine:

1. environmental landmarks;
2. world geography;
3. player memory;
4. map UI;
5. contextual environmental cues.

Players should gradually learn the geography of the island rather than depending exclusively on an objective marker.

---

# 13. Landmarks

Important locations should have strong visual identities.

Examples may include:

* distinctive buildings;
* towers;
* bridges;
* unusual trees;
* mountains/hills;
* statues;
* docks;
* rivers;
* ruins;
* caves;
* large environmental formations.

Landmarks should serve both aesthetic and navigational purposes.

---

# 14. Map System

The player should have access to a world map.

The map should communicate:

* major regions;
* important settlements;
* discovered landmarks;
* relevant locations;
* docks;
* major routes;
* player position where appropriate.

The map should not necessarily reveal every secret.

Discovery should remain meaningful.

---

# 15. Hidden Locations

Underhallow supports genuinely hidden locations.

These may include:

* caves;
* concealed paths;
* hidden rooms;
* secret passages;
* unusual environmental spaces;
* isolated areas;
* lore locations.

Hidden spaces may be discovered through:

* environmental observation;
* exploration;
* unusual terrain;
* NPC hints;
* quests;
* items;
* time-based conditions;
* mystery/lore interactions.

---

# 16. Discovery Before Access

Players may discover locations before they possess whatever is required to access them.

This is intentional.

The world should be capable of communicating:

> **“You are not ready for this yet.”**

without necessarily placing a literal UI lock in front of the player.

This supports curiosity and long-term exploration.

---

# 17. World Gating

Not all areas of the Main Island must be immediately accessible.

However, the player should have substantial freedom from relatively early in the game.

Access restrictions may use:

* story progression;
* skills;
* tools;
* quests;
* NPC relationships;
* environmental obstacles;
* world-state conditions.

No single gating mechanism should dominate the entire world.

---

# 18. Soft vs Hard Gating

Where possible, Underhallow should prefer **natural gates** over arbitrary barriers.

Preferred examples:

* a broken bridge;
* dense vegetation;
* a tool-requiring obstacle;
* difficult terrain;
* a locked building;
* a quest-related access condition.

The objective is to make the restriction feel like part of the world.

---

# 19. Terrain Architecture

Terrain is primarily authored to support:

* navigation;
* visual composition;
* exploration;
* regional identity;
* farming;
* building;
* environmental storytelling.

Elevation is moderately gameplay-relevant.

The world should therefore have meaningful terrain variation without becoming a heavily vertical game.

---

# 20. Elevation

Underhallow may use:

* hills;
* slopes;
* raised terrain;
* cliffs;
* elevated platforms;
* depressions;
* valleys.

Elevation can influence:

* visibility;
* access;
* environmental composition;
* routes;
* landmarks;
* secrets.

However, the world should remain readable from the isometric camera.

---

# 21. Cliffs & Inaccessible Terrain

Inaccessible areas use natural barriers and controlled unlockable routes.

Examples:

* cliffs;
* dense forest;
* blocked paths;
* broken bridges;
* water;
* structures;
* terrain formations.

Some barriers may later become traversable through progression.

The world should not rely on invisible walls wherever a natural alternative is practical.

---

# 22. Water

Water is a significant world boundary and environmental feature.

The player cannot simply walk into water.

Water may support:

* boats;
* docks;
* fishing;
* visual atmosphere;
* environmental separation;
* traversal;
* future water-related systems.

Water should therefore be treated as more than decorative terrain.

---

# 23. Rivers

Rivers may cross the Main Island.

They should contribute to:

* regional identity;
* navigation;
* landscape composition;
* fishing;
* bridges;
* traversal decisions;
* environmental storytelling.

Rivers should have believable origins and destinations where practical.

---

# 24. Boat & Dock Network

Travel between major island spaces occurs through docks and boats.

The intended interaction sequence is:

**Walk to Dock → Interact → Short Transition → Arrive**

This keeps travel connected to the physical world rather than turning it into a purely abstract menu.

The architecture should allow future docks to support additional destinations.

---

# 25. Town Square

Town Square is the primary settlement of the Main Island.

It should feel like a:

> **medium-sized cozy town.**

It serves as the social and practical heart of the island.

Potential functions include:

* NPC homes;
* shops;
* services;
* quest interactions;
* gathering areas;
* events;
* public spaces;
* important story scenes.

---

# 26. Additional Settlements

The Main Island may contain several smaller settlements.

These should be fewer and more specialized than Town Square.

A settlement may have:

* a distinct community;
* unique NPCs;
* local resources;
* specialized services;
* regional architecture;
* unique quests;
* local stories.

The settlements should reinforce the feeling that the island contains communities rather than one artificial central hub.

---

# 27. NPC World Placement

NPCs should generally have believable fixed homes and workplaces.

Important NPCs should use time-based schedules.

NPC schedules may include:

* home;
* workplace;
* public spaces;
* shops;
* gathering areas;
* quest locations;
* nighttime locations.

Not every NPC requires identical simulation complexity.

Important characters receive greater behavioral detail.

---

# 28. World Time Integration

World architecture must support the existing traditional day system.

Locations may change across the day.

Time can affect:

* NPC locations;
* creature activity;
* available interactions;
* lighting;
* atmosphere;
* access;
* world events;
* secrets.

Night should therefore not simply be a darker visual filter.

---

# 29. Day/Night World Identity

The same location should be capable of feeling different at different times.

For example:

**Day**
* active town;
* visible wildlife;
* open services;
* bright exploration.

**Night**
* quieter town;
* different creature activity;
* different lighting;
* different environmental mood;
* potential mystery interactions.

Specific mechanics belong to the Time/Simulation specification.

---

# 30. Weather

Weather exists primarily as an atmospheric system with occasional gameplay effects.

Weather may influence:

* lighting;
* ambience;
* visual effects;
* NPC behavior;
* wildlife;
* farming;
* exploration;
* special events.

Weather should not become a survival burden.

---

# 31. Environmental Hazards

Underhallow supports meaningful but non-punishing environmental hazards.

Possible examples include:

* difficult terrain;
* dangerous areas;
* traps;
* darkness;
* environmental obstacles;
* specialized hazards.

Hazards should create gameplay decisions without transforming Underhallow into a survival game.

The removal of the stamina system remains authoritative.

**World traversal must not depend on stamina depletion.**

---

# 32. Personal Island Architecture

The Personal Island begins from a standardized foundational layout.

The starting configuration is intentionally consistent between players.

This provides:

* a common baseline;
* predictable world architecture;
* easier technical management;
* meaningful customization;
* future expansion potential.

Individual islands become increasingly different through player decisions.

---

# 33. Personal Island Expansion

The Personal Island expands through unlockable **grids**.

The architecture should support:

* an initial playable area;
* additional adjacent grids;
* future expansion rings;
* player-selected expansion where appropriate;
* increasing customization opportunities.

The exact economic and progression requirements for unlocking grids belong to other specifications.

---

# 34. Grid Architecture

Personal Island grids are logical world subdivisions.

They may define:

* construction boundaries;
* farming capacity;
* terrain regions;
* future expansion;
* world persistence;
* save-state organization.

The grid system should not necessarily make the world visually appear as a grid.

The underlying architecture and player-facing appearance are separate concerns.

---

# 35. Personal Island Expansion Philosophy

Expansion should feel like the player is **growing their home**, not merely purchasing additional map tiles.

New areas may provide opportunities for:

* larger farms;
* buildings;
* decoration;
* trees;
* paths;
* specialized areas;
* future systems.

Expansion should support long-term attachment to the island.

---

# 36. Home

The player's initial home has a defined starting location.

The architecture should allow the possibility of moving or relocating the home later.

This should not be required in the initial implementation.

---

# 37. Personal Island Building Space

Players should eventually be able to place structures within their unlocked island areas subject to building-system rules.

The world architecture must therefore support:

* valid buildable terrain;
* blocked terrain;
* reserved areas;
* building footprints;
* expansion boundaries;
* future decoration.

Detailed placement rules belong to the Building & Personal Island specification.

---

# 38. Environmental Editing

Players may modify portions of their Personal Island.

Environmental editing should primarily support:

* clearing;
* landscaping;
* decoration;
* paths;
* controlled terrain customization.

Major terrain structure should remain constrained.

This prevents Personal Islands from becoming technically unbounded terrain editors.

---

# 39. Personal Island Themes

The initial Personal Island environment uses a common fundamental theme.

The architecture should nevertheless permit future cosmetic or environmental themes.

Possible future themes might alter:

* vegetation;
* ground appearance;
* decorative assets;
* ambient effects;
* visual identity.

Such themes must not automatically alter fundamental gameplay rules unless explicitly designed to do so.

---

# 40. Personal Island Visitors

The world architecture must allow Personal Islands to eventually support visitors.

Visitors may be able to:

* explore;
* interact with objects;
* observe the owner's creations;
* leave gifts;
* participate in future social systems.

Multiplayer/social implementation is outside this document's initial scope.

The architecture should simply avoid preventing it.

---

# 41. World Persistence

Underhallow uses a hybrid persistence model.

Some world changes persist.

Others naturally regenerate.

This distinction is intentional.

### Persistent examples
* player-built structures;
* opened permanent locations;
* certain world-state changes;
* Personal Island development.

### Regenerating examples
* natural resources;
* certain wildlife;
* temporary environmental objects.

Exact persistence rules are defined by individual systems.

---

# 42. Resource Respawning

Resource regeneration uses **resource-specific rules**.

There is no universal respawn timer applied indiscriminately to every resource.

Different resources may have different:

* regeneration periods;
* conditions;
* quantities;
* locations;
* rarity;
* world-state requirements.

This allows the world to feel more natural.

---

# 43. Wildlife Architecture

Wildlife and creatures use a hybrid simulation model.

Some creatures may have:

* spawn regions;
* territories;
* simple schedules;
* time-of-day behavior;
* preferred environments.

More important creatures may have more advanced behavior.

The architecture should avoid requiring a full simulation of every creature at all times.

---

# 44. Performance Principle

World simulation should prioritize **perceived life over unnecessary computational complexity**.

The player should see a world that appears alive without requiring every entity to simulate at full fidelity simultaneously.

Systems should support:

* local simulation;
* simplified distant simulation;
* spawn/despawn management;
* region activation;
* controlled persistence.

---

# 45. Procedural Generation

The core world is **authored rather than procedurally generated**.

Procedural techniques may be used for supporting systems such as:

* minor resource placement;
* variation;
* repeated environmental details;
* controlled wildlife spawning;
* non-critical decorative variation.

Procedural generation must not undermine intentional world design.

Important locations, landmarks, towns, secrets, story spaces, and major terrain structures should remain authored.

---

# 46. World Grid Architecture

Underhallow uses a mostly grid-based logical architecture while permitting exceptions.

Different systems may operate at different logical resolutions.

For example:

* farming may use a placement grid;
* building may use a structural grid;
* world collision may use a different representation;
* movement may remain continuous;
* decorative objects may ignore strict grid alignment.

The player should experience a coherent world even where underlying systems use different representations.

---

# 47. Camera Compatibility

The world must support the established camera architecture:

* isometric presentation;
* 90-degree camera rotation;
* limited zoom;
* smooth player following;
* small look-ahead;
* camera boundaries.

World assets and layouts should therefore be designed to remain readable under the supported orientations.

---

# 48. Four-Direction World Presentation

The world should support all four camera orientations.

This requirement applies to:

* terrain readability;
* buildings;
* paths;
* major landmarks;
* environmental composition;
* navigation.

The asset pipeline must account for the visual consequences of camera rotation.

---

# 49. World Streaming & Map Architecture

The technical world should be represented as multiple authored regions/maps rather than one enormous monolithic map.

The architecture should support:

* region loading;
* transitions;
* controlled memory usage;
* independent region development;
* future expansion;
* localized simulation.

The player should experience these as parts of one coherent world.

---

# 50. Region Boundaries

Region boundaries should generally be represented through natural geography or authored transitions.

Examples:

* forests;
* roads;
* bridges;
* hills;
* rivers;
* gates;
* buildings;
* docks.

Technical loading boundaries should not necessarily be visually obvious.

---

# 51. Future World Expansion

The architecture must support future additions beyond the initial two-island structure.

Future content may include:

* additional islands;
* new regions;
* special areas;
* event spaces;
* story locations;
* temporary environments.

The initial architecture should not hard-code the assumption that only two destinations can ever exist.

---

# 52. Temporary World Events

The world architecture should support temporary events.

Potential examples include:

* festivals;
* special visitors;
* unusual world phenomena;
* temporary locations;
* limited-time activities.

Events should be capable of modifying world state without permanently corrupting the underlying map architecture.

---

# 53. Personal Island Future Expansion

Personal Island architecture must support additional expansion beyond the initial planned area.

The implementation should avoid hard-coding an unnecessarily small maximum number of grids.

Future expansion should remain compatible with:

* save data;
* building placement;
* player progression;
* world rendering;
* visitor systems;
* economy.

---

# 54. World Storytelling

The world itself is a storytelling medium.

Not every story should be delivered through dialogue.

World storytelling may use:

* architecture;
* ruins;
* environmental changes;
* unusual objects;
* NPC placement;
* paths;
* abandoned locations;
* visual contrasts;
* hidden spaces;
* nighttime behavior.

This is particularly important to Underhallow's **cozy world + dark mystery** identity.

---

# 55. Mystery Architecture

The world must allow the existence of unexplained elements.

The player should occasionally encounter something that creates questions rather than immediately providing answers.

Examples may include:

* strange structures;
* unexplained symbols;
* unusual NPC behavior;
* inaccessible locations;
* strange environmental events;
* hidden rooms;
* objects with unknown purpose.

The world should be capable of supporting the emotional contrast:

> **“How can such a cozy place have something this dark underneath it?”**

---

# 56. World Density

The Main Island uses moderate point-of-interest density.

The intended rhythm is:

**Explore → Travel → Observe → Discover → Rest → Continue**

rather than:

**Reward → Reward → Reward → Reward**

Important discoveries should therefore retain meaning.

---

# 57. World Composition

Major world areas should deliberately balance:

* gameplay density;
* empty space;
* landmarks;
* traversal routes;
* visual composition;
* secrets;
* environmental storytelling.

The world should be designed as a **place**, not merely as a gameplay optimization problem.

---

# 58. Technical Constraints

The world architecture must remain compatible with the established technical architecture.

Implementation must account for:

* browser performance;
* asset loading;
* map segmentation;
* persistence;
* collision;
* entity management;
* rendering;
* save data;
* future multiplayer/social functionality;
* future world expansion.

Technical implementation details belong in TA-001 and later implementation specifications.

---

# 59. Scope Boundaries

This specification does **not** fully define:

* farming mechanics;
* combat mechanics;
* inventory rules;
* player progression;
* NPC dialogue;
* quest logic;
* detailed economy;
* building placement mechanics;
* crafting recipes;
* fishing mechanics;
* exact weather mechanics;
* detailed save schema;
* multiplayer implementation.

Those systems must reference WM-001 where applicable.

---

# 60. Dependency Map

WM-001 provides world-level requirements for:

### Directly dependent systems

* Farming (`FA-001`)
* Hunting & Combat (`HC-001`)
* Building & Personal Island (`BI-001`)
* Exploration & Secrets (`EX-001`)
* NPC / Dialogue / Quest (`NQ-001`)
* Fishing (`FI-001`)
* Time / Simulation (`TS-001`)
* Inventory / Items (`II-001`)
* Player Progression (`PR-001`)
* Story / Narrative (`ST-001`)

### Supporting dependencies

* Save System (`SV-001`)
* UI/UX (`UI-001`)
* Audio (`AU-001`)
* Accessibility (`AX-001`)
* Technical Architecture (`TA-001`)

---

# 61. World Architecture Invariants

The following are authoritative constraints.

### WM-I01
Underhallow initially consists of a Main Island and Personal Islands.

### WM-I02
The Main Island is the primary shared adventure space.

### WM-I03
Personal Islands are individually owned player spaces.

### WM-I04
Players begin with a standardized Personal Island foundation.

### WM-I05
Personal Islands expand through unlockable grids.

### WM-I06
The Main Island uses authored regions with natural transitions.

### WM-I07
The Main Island is medium-scale.

### WM-I08
Traversal must not depend on stamina.

### WM-I09
Water prevents ordinary player walking.

### WM-I10
Boat/dock travel connects major island spaces.

### WM-I11
The world supports meaningful hidden locations.

### WM-I12
Some areas may be discovered before becoming accessible.

### WM-I13
The world uses moderate gameplay density with intentional peaceful space.

### WM-I14
Important world content is authored rather than procedurally generated.

### WM-I15
Supporting procedural techniques may be used for controlled variation.

### WM-I16
World simulation uses hybrid persistence and resource-specific regeneration.

### WM-I17
The world supports four camera orientations.

### WM-I18
The architecture supports future world expansion.

### WM-I19
The architecture supports future temporary world events.

### WM-I20
The world must support the cozy-adventure identity while leaving room for the underlying mystery.

---

# 62. Design Priorities

When future world decisions conflict, prioritize in this order:

1. **Cozy atmosphere**
2. **Exploration and discovery**
3. **Player freedom**
4. **World coherence**
5. **Storytelling**
6. **Gameplay depth**
7. **Technical efficiency**

Technical constraints may require compromises, but they should not unnecessarily destroy the first four priorities.

---

# 63. Validation Criteria

WM-001 should be considered successfully implemented when:

* the Main Island can be represented as multiple coherent authored regions;
* the Personal Island can be instantiated and expanded through grids;
* major world boundaries function correctly;
* boat/dock transitions work;
* camera rotation remains readable;
* world regions have recognizable identities;
* hidden spaces can exist;
* resources and wildlife can follow appropriate persistence rules;
* time can affect world presentation;
* world loading does not require one monolithic map;
* architecture permits future regions and islands;
* the world remains performant in the target browser environment.

---

# 64. Open Questions

The major architectural questions addressed during this specification process are considered resolved for V1.

Detailed questions intentionally deferred to later specifications include:

* exact biome list;
* exact map dimensions;
* exact grid dimensions;
* exact resource respawn values;
* exact NPC schedules;
* exact weather effects;
* exact fast-travel unlock rules;
* exact Personal Island expansion costs;
* exact world event implementation;
* exact terrain-editing tools;
* exact save representation.

These should be resolved in the relevant system specifications rather than prematurely hard-coded into WM-001.

---

# 65. Versioning & Change Control

Changes to the fundamental world architecture require review against:

* NS-001;
* CG-001;
* TA-001;
* PC-001;
* all directly dependent system specifications.

A fundamental change to the world structure should trigger a major version consideration.

Minor clarifications may result in a minor version increment.

---

# 66. Final World Architecture Principle

The Underhallow world should never feel like a technical container for gameplay systems.

It should feel like a place worth being in.

The architecture therefore exists to create the conditions for:

> **A peaceful world that rewards curiosity.**

The player should be able to farm, build, hunt, explore, socialize, become wealthy, follow the story, ignore the story, discover secrets, or simply spend an evening walking around their island.

And beneath that peaceful surface, the world must have enough depth and unanswered questions to make the player wonder:

> **“What is really going on in Underhallow?”**
