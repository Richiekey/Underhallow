# UNDERHALLOW

# Building & Construction System Specification

**Document ID:** BI-001  
**Version:** V1.0  
**Status:** DRAFT  
**Authority Level:** Level 2 — Gameplay System Specification  
**System:** Building & Construction  
**Classification:** Core World System (Physical Infrastructure)  
**Primary Domain:** Player Building / Construction  
**Engine:** Godot  
**Language:** GDScript  

### Parent Specifications

* [North Star — NS-001](../01-product/NORTH_STAR.md)
* [Foundation Specification — FS-001](../01-product/FOUNDATION_SPECIFICATION.md)
* [Core Gameplay Systems Specification — CG-001](CORE_GAMEPLAY_SYSTEMS_SPECIFICATION.md)
* [Engine & Technical Architecture Specification — ETA-001](../02-architecture/ENGINE_TECHNICAL_ARCHITECTURE_SPECIFICATION.md)
* [Implementation Architecture Specification — IA-001](../02-architecture/IMPLEMENTATION_ARCHITECTURE_SPECIFICATION.md)
* [Player Control, Movement & Interaction Specification — PC-001](PLAYER_CONTROL_MOVEMENT_INTERACTION_SPECIFICATION.md)
* [World & Map Architecture Specification — WM-001](../04-world/WORLD_MAP_ARCHITECTURE_SPECIFICATION.md)
* [Player Progression Specification — PR-001](PLAYER_PROGRESSION_SPECIFICATION.md)
* [Farming System Specification — FB-001](FARMING_SYSTEM_SPECIFICATION.md)
* [Hunting & Combat System Specification — HU-001](HUNTING_COMBAT_SYSTEM_SPECIFICATION.md)
* [Multiplayer & Social Systems Specification — MS-001](../07-multiplayer/MULTIPLAYER_SOCIAL_SYSTEMS_SPECIFICATION.md)

### Related Future Specifications

* Personal Island Design Specification — PI-001
* Building Catalog / Content Definitions
* Guild Island Specification
* Economy Specification
* Crafting & Processing Specification
* Save & Persistence Specification

---

# 1. Purpose

The Building & Construction System defines how players acquire, place, construct, modify, customize, relocate, and remove structures and objects within spaces where building is permitted.

Per [CG-001 §4](CORE_GAMEPLAY_SYSTEMS_SPECIFICATION.md), Building is explicitly classified as a **Core World System** providing cross-pillar physical infrastructure rather than an isolated livelihood pillar. It provides the shared physical foundation supporting farming, hunting, mining, fishing, animal husbandry, crafting, commerce, and player housing.

It exists simultaneously as:

* a functional gameplay system;
* a creative expression system;
* a progression path;
* an economic opportunity;
* a multiplayer/social system;
* and a long-term foundation for player-owned spaces.

The system must support meaningful player expression without sacrificing the clarity, accessibility, persistence, performance, or multiplayer integrity required by Underhallow.

---

# 2. Design North Star

> **Building in Underhallow should allow players to create a place that feels uniquely theirs, while turning creativity and investment into meaningful gameplay.**

The player should be able to look at a developed space and feel:

> **“I made this.”**

Building should therefore reward both practical players and highly creative players.

A player who wants an efficient farm should be supported.

A player who wants a beautiful home should be supported.

A player who wants to build a workshop-oriented settlement should be supported.

A player who wants to combine all three should be supported.

No single architectural playstyle should be mandatory.

---

# 3. System Position

Building is a **Level 2 gameplay system**.

It is not subordinate to Personal Islands.

Instead:

> **BI-001 defines the construction system; individual world/property systems define where that construction system is permitted to operate.**

This distinction is important.

The same construction framework should eventually support:

* Personal Islands;
* Guild Islands;
* potentially other player-owned spaces;
* special event construction;
* and future large-scale structures.

Personal Island rules must therefore reference BI-001 rather than redefining construction mechanics independently.

---

# 4. Core Principles

## 4.1 Function + Creativity

Building must serve both gameplay and expression.

Functional buildings should matter mechanically.

Decorative construction should still have value through identity, atmosphere, customization, and social expression.

Neither side should invalidate the other.

---

## 4.2 Freedom Within World Rules

Players should have broad freedom within their permitted building space.

However, building is not completely unrestricted.

The world may impose:

* terrain restrictions;
* protected natural features;
* collision requirements;
* structure-specific placement requirements;
* access requirements;
* environmental restrictions;
* ownership restrictions;
* progression restrictions.

The objective is:

> **Creative freedom without spatial chaos.**

---

## 4.3 Meaningful Construction Without Tedious Construction

Construction should feel substantial enough that buildings matter.

However, construction should never become deliberately tedious.

Construction time, material requirements, and progression should create anticipation and investment rather than repetitive waiting.

---

## 4.4 Appearance and Function Are Separate

A building's visual appearance should not necessarily determine its gameplay function.

Where appropriate:

* multiple visual styles may perform the same function;
* visual customization may occur without changing functionality;
* players should be able to develop a coherent architectural identity.

---

## 4.5 Persistent World State

Built structures are part of persistent game state.

The renderer is not authoritative.

A structure exists because the relevant authoritative building state records it.

Visual scenes are representations of that state.

This follows the project's established architectural rule that gameplay state must remain valid independently of presentation.

---

# 5. Building Lifecycle

Every constructible object follows a general lifecycle:

**Available → Selected → Previewed → Validated → Placed → Under Construction → Completed → Modified / Relocated → Demolished**

Not every object must use every stage.

For example, a small decorative object may have an effectively immediate construction process while a major structure may require meaningful construction time.

The lifecycle must remain extensible.

---

# 6. Construction Flow

## 6.1 Select

The player selects a structure, furniture item, decorative object, or other constructible object.

The system presents relevant information including:

* required materials;
* required progression;
* placement rules;
* construction requirements;
* relevant restrictions.

---

## 6.2 Preview

A ghost/preview representation appears before placement.

The preview communicates whether the proposed placement is valid.

The player should be able to:

* move the object;
* rotate it where supported;
* observe collision/placement validity;
* cancel placement;
* confirm placement.

---

## 6.3 Validation

Placement must be validated before the authoritative state changes.

Validation may consider:

* ownership;
* permissions;
* available space;
* terrain;
* collision;
* protected world features;
* structure requirements;
* required materials;
* progression requirements;
* building-space restrictions;
* object orientation;
* access requirements.

The client preview is informational.

It is **not authoritative**.

---

## 6.4 Placement

Once validated, the authoritative system accepts the construction request.

The relevant building state is updated.

The world representation then reacts to the state change.

This follows the project's established:

**Command → Validation → Mutation → Event**

architecture.

---

# 7. Construction Time

Construction time varies by structure.

### Small Objects

May require little or effectively no waiting.

### Standard Structures

May require a short period of in-game time.

### Major Structures

May require substantially longer construction.

The system must avoid imposing one universal construction duration across all objects.

Construction duration should communicate the relative significance of the object.

---

# 8. Construction Resources

Construction may require:

* ordinary gathered materials;
* specialized construction materials;
* currency;
* and, where appropriate, time.

Not every structure must require every resource type.

Construction materials should connect naturally to the wider Underhallow resource economy.

Examples of resource relationships may include:

**World Gathering → Materials → Construction**

and:

**World Gathering → Materials → Processing → Advanced Construction Materials**

This creates useful relationships between exploration, farming, hunting, crafting, processing, and building.

---

# 9. Construction Material Progression

The construction system supports increasingly advanced materials.

Early structures should primarily use accessible materials.

Later structures may require:

* specialized resources;
* processed materials;
* rare materials;
* progression-gated components;
* or other advanced requirements.

Advanced materials should represent meaningful progression rather than arbitrary resource inflation.

---

# 10. Building Categories

The system supports the following broad categories:

### Residential

* homes;
* house expansions;
* residential structures.

### Production

* workshops;
* processing structures;
* crafting facilities;
* specialized production buildings.

### Farming

* farming structures;
* storage-related agricultural structures;
* livestock-related structures;
* agricultural utility buildings.

### Hunting

* hunting-related structures;
* equipment facilities;
* storage and processing structures.

### Storage

* chests;
* storage buildings;
* specialized storage.

### Commerce

* shops;
* stalls;
* player businesses;
* future economic structures.

### Utility

* infrastructure;
* functional world objects;
* lighting;
* access structures.

### Transportation / Spatial

* roads;
* paths;
* bridges;
* gates.

### Boundary

* fences;
* walls;
* gates;
* other property-defining structures.

### Decorative

* furniture;
* landscaping objects;
* ornaments;
* aesthetic structures;
* environmental decoration.

This category list is extensible.

It does **not** constitute the final building catalog.

---

# 11. Functional Buildings

Functional buildings can materially affect gameplay.

Possible functions include:

* improving farming;
* supporting hunting;
* enabling crafting;
* enabling processing;
* increasing or organizing storage;
* supporting commerce;
* generating limited resources or income;
* unlocking specialized activities.

The building system does not require every structure to provide a gameplay bonus.

A structure may exist primarily for identity or aesthetics.

---

# 12. Building Equipment

Some functional buildings require specific interior equipment to become operational.

For example, the distinction may be:

**Building shell → Interior equipment → Functional station**

This allows buildings to become meaningful containers for other gameplay systems rather than merely acting as large static objects.

---

# 13. Interior Construction

Selected major structures support interiors.

Interiors should provide:

* room creation or arrangement where appropriate;
* furniture placement;
* functional stations;
* decorative expression;
* spatial personalization.

Not every structure requires an interior.

The system should avoid forcing interiors onto structures whose purpose does not justify them.

---

# 14. Furniture

Furniture is a distinct construction category.

Furniture generally receives greater placement freedom than major buildings.

Players may be able to:

* position furniture precisely;
* rotate furniture freely where appropriate;
* rearrange interiors;
* customize appearance;
* combine functional and decorative objects.

Furniture may eventually participate in the player economy.

---

# 15. Homes

The player's home is a special class of building.

The home should support:

* strong personal identity;
* exterior customization;
* interior customization;
* physical expansion;
* cosmetic upgrades;
* functional upgrades.

Home progression should feel like the development of a personal place rather than merely upgrading a numerical level.

---

# 16. Placement Model

Building uses a **hybrid placement model**.

Major structures generally benefit from structured placement and snapping.

Decorative objects and furniture may use more precise placement.

The system therefore supports both:

* structured construction;
* expressive decoration.

---

# 17. Grid Interaction

The building system supports contextual grid-based placement where appropriate.

Grid visualization should appear when it helps the player understand:

* building alignment;
* valid placement areas;
* structural relationships;
* farming/building boundaries.

The grid should not unnecessarily dominate the visual presentation.

---

# 18. Snapping

Auto-snap is supported.

The player may toggle or bypass snapping where appropriate.

Snapping should improve:

* alignment;
* roads;
* walls;
* repeated structures;
* organized layouts.

It should not prevent detailed decorative placement.

---

# 19. Rotation

Rotation is structure-dependent.

Some structures may have defined orientations.

Others may support multiple orientations.

Furniture and decorative objects generally receive greater rotational freedom.

The implementation must not assume every object shares a universal rotation rule.

---

# 20. Relocation

Completed structures may be moved through a dedicated relocation mode.

Relocation should preserve the structure's identity and relevant progression unless explicitly defined otherwise.

The system may apply costs or restrictions to relocation depending on the structure.

Relocation should not require the player to unnecessarily demolish and rebuild an important structure.

---

# 21. Demolition

Players may demolish structures they own or are authorized to modify.

Demolition should:

1. validate ownership/permission;
2. remove the structure from authoritative state;
3. resolve any dependent systems;
4. recover applicable resources;
5. update presentation.

Demolition is a controlled state mutation rather than deletion of an arbitrary scene node.

---

# 22. Material Recovery

Demolishing a structure generally returns **most**, but not necessarily all, construction materials.

The recovery model exists to prevent experimentation from becoming excessively punishing.

This encourages players to redesign their spaces.

It also prevents construction from becoming completely costless.

---

# 23. Structural Damage

Structures may support damage in contexts where it improves gameplay.

Damage should be used selectively.

Potential causes include:

* special gameplay events;
* world events;
* controlled encounters;
* narrative events.

Ordinary construction should not create an oppressive maintenance loop.

---

# 24. Destruction

Permanent destruction of player structures should be rare.

Unauthorized destruction must not be a normal multiplayer griefing mechanism.

If destruction occurs, it should generally result from:

* controlled world events;
* specific narrative circumstances;
* clearly communicated gameplay systems.

---

# 25. Building Progression

Building is a formal progression path.

The system uses:

**Character Level + Building Skill**

rather than a Building Skill existing in isolation.

Character Level represents broad player development.

Building Skill represents specialized construction mastery.

---

# 26. Building Skill

Building Skill may progress through meaningful building-related activity.

Progression may unlock:

* new structures;
* improved structures;
* improved construction efficiency;
* advanced materials;
* furniture;
* interior capabilities;
* production capabilities;
* advanced construction techniques.

Progression must reward engagement without requiring excessive repetition.

---

# 27. Cross-System Progression

Building progression can interact with other progression systems.

Some structures may require:

* Farming progression;
* Hunting progression;
* Exploration;
* NPC relationships;
* quests;
* Character Level;
* Building Skill.

These requirements should be purposeful.

They should create connections between lifestyles rather than arbitrary locks.

---

# 28. Building Specialization

Players may develop a specialized builder identity.

Examples include:

* residential builder;
* workshop-focused builder;
* agricultural builder;
* decorative designer;
* commercial builder;
* infrastructure-focused builder.

Specialization should remain soft.

Underhallow should not force the player into an exclusive building class.

---

# 29. Environmental Restrictions

Construction must respect important environmental rules.

Certain natural features may be protected.

Examples could include:

* important trees;
* unique landmarks;
* special terrain;
* quest-critical objects;
* world-critical environmental features.

The specific protected-feature catalog belongs to the relevant world specifications.

---

# 30. Terrain

Placement validity may depend on terrain.

Different structures may have different requirements.

For example:

* some require relatively flat terrain;
* some may adapt to terrain;
* some may require specific environmental conditions;
* some may only exist in designated building areas.

BI-001 defines the construction capability.

World specifications define the actual terrain restrictions for individual spaces.

---

# 31. Collision

Collision rules are structure-dependent.

The system must account for:

* existing structures;
* terrain;
* important world objects;
* paths;
* entrances;
* gameplay-critical access;
* other players where appropriate.

Collision validation should prevent impossible or disruptive layouts without unnecessarily restricting creativity.

---

# 32. Access

Functional structures must remain meaningfully accessible.

Where necessary, the system should validate:

* entrances;
* doors;
* interaction points;
* production stations;
* pathways.

A visually valid placement should not automatically be considered gameplay-valid if it makes the structure unusable.

---

# 33. Roads and Paths

Roads and paths are construction objects.

They should integrate with:

* movement;
* visual organization;
* spatial design;
* settlement development.

Their exact mechanical benefits are determined by future world/movement specifications.

Buildings and paths may have contextual compatibility rules.

---

# 34. Multiplayer Ownership

Every persistent structure must have an authoritative ownership context.

Possible ownership contexts include:

* individual player;
* guild/organization;
* world/system ownership;
* special event ownership.

Ownership must never be inferred purely from scene presence.

---

# 35. Building Permissions

Multiplayer construction is permission-based.

Possible permission levels include:

* owner;
* trusted builder;
* collaborator;
* visitor;
* restricted.

The exact permission vocabulary should be reconciled with MS-001.

---

# 36. Temporary Permissions

The system supports temporary construction permissions.

This allows a player to grant another player access without permanently transferring ownership.

Examples include:

* inviting a friend to help decorate;
* hiring a builder;
* collaborative projects;
* temporary event construction.

---

# 37. Collaborative Construction

Collaborative construction is supported architecturally.

Initial gameplay may keep collaboration intentionally limited.

The architecture must nevertheless avoid making future collaboration require a fundamental rewrite.

Possible future collaboration includes:

* shared construction;
* delegated construction;
* professional builders;
* guild projects;
* coordinated landmark construction.

---

# 38. Guild Islands

Guild Islands should use the same core construction framework wherever practical.

However:

> **Personal Island ownership and Guild Island ownership are different authority contexts.**

Therefore the underlying construction mechanics may be shared while:

* ownership;
* permissions;
* access;
* persistence;
* governance;

differ between them.

---

# 39. Building Economy

Building can eventually become an economic profession.

Potential economic activities include:

* selling furniture;
* selling decorative objects;
* supplying construction materials;
* constructing structures for others;
* offering building services;
* operating building-related businesses.

These systems should not be required for Building V1 to be meaningful.

---

# 40. Construction Material Economy

Construction materials may have their own economic relationships.

Materials can originate from:

* gathering;
* farming;
* hunting;
* crafting;
* processing;
* exploration;
* trading.

The construction economy should therefore reinforce the broader world economy.

---

# 41. Visual Customization

Visual identity is a first-class concern.

Players should have meaningful opportunities to customize:

* building appearance;
* materials;
* styles;
* furniture;
* decorations;
* layout;
* landscaping;
* architectural combinations.

Customization should be substantial enough that two players can create visibly different spaces even when using similar functional structures.

---

# 42. Architectural Styles

A single functional structure may eventually have multiple visual styles.

Styles may represent:

* regional aesthetics;
* cultural influences;
* materials;
* progression;
* rare discoveries;
* NPC relationships;
* exploration;
* special events.

Cultural and regional architecture should enrich the world rather than function as arbitrary cosmetic recolors.

---

# 43. Large Structures

The architecture must support large structures.

Large structures may require:

* multiple construction stages;
* larger material requirements;
* more complex placement validation;
* multiple rooms;
* multiple functional stations;
* special progression requirements.

The implementation should not assume every structure is a small single-object footprint.

---

# 44. Landmark Structures

Landmark-scale construction is reserved for special late-game or major progression contexts.

Examples could eventually include:

* monumental buildings;
* community facilities;
* major guild structures;
* rare architectural projects.

Landmark construction should feel exceptional rather than simply being another tier of ordinary house.

---

# 45. Data-Driven Construction

Constructible objects should be data-driven.

A construction definition should be capable of describing, as appropriate:

* identifier;
* category;
* display information;
* footprint;
* placement rules;
* rotation rules;
* required materials;
* required progression;
* construction duration;
* visual representation;
* interior availability;
* functional capabilities;
* permitted environments;
* ownership requirements;
* permission requirements.

Exact schema belongs to the implementation architecture and content-definition layer.

---

# 46. Authoritative State

Building state must be authoritative independently of presentation.

At minimum, authoritative state must be capable of representing:

* structure identity;
* owner;
* construction definition;
* location;
* orientation;
* construction state;
* relevant customization;
* progression/upgrade state;
* damage state where applicable;
* permissions where applicable.

The implementation must not use scene nodes as the source of truth.

---

# 47. Command Architecture

Meaningful building mutations should follow:

**Command → Validation → Mutation → Event**

Examples include:

* `PlaceStructure`
* `BeginConstruction`
* `CompleteConstruction`
* `MoveStructure`
* `RotateStructure`
* `ModifyStructure`
* `DemolishStructure`
* `GrantBuildPermission`
* `RevokeBuildPermission`

Exact command naming remains an implementation concern.

---

# 48. Server Authority

In multiplayer contexts:

> **The server is authoritative over persistent construction state.**

Clients may:

* preview;
* request;
* display;
* animate;
* predict presentation where safe.

Clients may not unilaterally establish persistent structure state.

This protects:

* ownership;
* resource integrity;
* placement integrity;
* persistence;
* multiplayer fairness.

---

# 49. Persistence

Completed structures and relevant construction state must be persistable.

Persistence must survive:

* leaving the world;
* returning later;
* scene unloading;
* reconnecting;
* server/client presentation recreation.

Save structures must be versioned according to the project's persistence architecture.

---

# 50. Loading

When a building space loads:

1. authoritative building state is retrieved;
2. structures are reconstructed from state;
3. presentation is instantiated;
4. functional systems reconnect;
5. permissions and ownership are restored.

A player's structures must not depend on having remained in the scene continuously.

---

# 51. Performance

The system must support spaces containing potentially large numbers of constructed objects.

The implementation should therefore avoid:

* unnecessary per-object processing;
* excessive scene complexity;
* redundant state duplication;
* expensive continuous validation.

Construction validation should primarily occur when relevant state changes.

---

# 52. Construction UI

The construction interface should communicate:

* available structures;
* categories;
* requirements;
* material costs;
* progression requirements;
* placement validity;
* construction state;
* customization;
* relevant warnings.

The UI should remain consistent with Underhallow's contextual interaction philosophy.

---

# 53. Placement Feedback

Invalid placement must be immediately understandable.

The player should know *why* placement is invalid where practical.

Examples:

* occupied space;
* invalid terrain;
* insufficient materials;
* locked structure;
* insufficient progression;
* restricted area;
* missing access;
* permission denied.

The system should avoid unexplained “cannot build here” failures.

---

# 54. Accessibility

Building should support basic accessibility requirements established by the broader project.

The player should not need extreme precision to perform ordinary construction tasks.

Where practical, the system should support:

* clear placement feedback;
* readable requirements;
* reliable snapping;
* predictable rotation;
* cancellation;
* accessible interaction controls.

---

# 55. Failure Handling

A failed construction request must not partially mutate authoritative state.

Examples:

If the player lacks materials:

* no materials are consumed;
* no structure is created.

If placement is invalid:

* no structure is created.

If permission is revoked:

* the mutation is rejected.

If a multiplayer request becomes stale:

* the server revalidates against current state.

---

# 56. Exploit Resistance

The building system must protect against:

* duplicated structures;
* duplicated materials;
* unauthorized construction;
* unauthorized demolition;
* ownership spoofing;
* invalid coordinates;
* invalid rotations;
* bypassed progression requirements;
* client-side resource manipulation;
* race conditions during simultaneous construction.

The server must never trust client-supplied economic or ownership outcomes.

---

# 57. Construction and Other Systems

Building integrates with multiple Underhallow systems.

### Farming

Buildings can support agricultural activity.

### Hunting

Buildings can support hunting preparation, equipment, storage, and related activities.

### Crafting

Workshops and stations can provide crafting functionality.

### Inventory

Construction consumes and may recover resources.

### Progression

Building participates in Character Level and Building Skill progression.

### Economy

Materials, structures, furniture, and services can eventually participate in trade.

### NPCs

NPC relationships and quests may unlock structures or architectural opportunities.

### Exploration

Exploration can reveal rare materials, styles, structures, or construction opportunities.

### Multiplayer

Ownership and permissions govern collaborative construction.

---

# 58. Anti-Grind Principle

Building progression must not require players to repeatedly construct and demolish objects simply to gain Building Skill.

Progression should primarily reward meaningful building engagement.

The system should avoid:

> “Build the cheapest object 500 times to level Building.”

Instead, progression should emerge naturally from:

* constructing meaningful structures;
* completing projects;
* learning new techniques;
* undertaking larger projects;
* fulfilling construction-related opportunities.

---

# 59. Player Expression

The system should support architectural storytelling.

A player's space can communicate:

* personality;
* priorities;
* profession;
* progression;
* wealth;
* creativity;
* relationships;
* achievements;
* exploration history.

The player's constructed environment becomes part of their identity.

---

# 60. Long-Term Extensibility

BI-001 must remain extensible to support future systems without architectural replacement.

Potential future additions include:

* advanced building materials;
* architectural styles;
* professional builders;
* guild construction;
* collaborative construction;
* advanced interiors;
* modular structures;
* large-scale infrastructure;
* landmark construction;
* environmental decoration;
* construction contracts;
* player businesses.

These systems should extend the construction framework rather than replace it.

---

# 61. V1 Scope

The first implementation should prioritize the smallest coherent construction loop:

**Select → Preview → Validate → Place → Persist → Reconstruct**

Initial implementation should establish:

* construction definitions;
* placement validation;
* ghost preview;
* snapping;
* supported rotation;
* material requirements;
* authoritative state;
* construction persistence;
* demolition;
* basic relocation;
* ownership;
* basic permission handling.

Advanced economic and social construction features can follow later.

---

# 62. Explicit Non-Goals for BI-001 V1

The following are **not required to be fully implemented by BI-001 V1**:

* professional builder economy;
* complex player-to-player construction contracts;
* advanced guild construction;
* landmark-scale construction;
* highly complex interior simulation;
* complete architectural style catalog;
* advanced structural damage simulation;
* sophisticated NPC construction workers;
* complete construction marketplace.

These remain supported by the architecture but can be introduced through later specifications.

---

# 63. Prototype Philosophy

Building should follow Underhallow's broader:

> **Specify enough → prototype → learn → refine → lock → build**

philosophy.

Exact values such as:

* construction durations;
* material quantities;
* object footprints;
* snap increments;
* rotation increments;
* maximum structure counts;
* recovery percentages;
* progression thresholds;

should be validated through prototype testing before becoming permanently locked.

---

# 64. Core Invariants

The following are system invariants.

### BI-I01 — Ownership Integrity

A player cannot modify a structure without appropriate authority.

### BI-I02 — Server Authority

Persistent multiplayer building state cannot be established solely by a client.

### BI-I03 — Resource Integrity

Construction cannot consume resources without a valid construction mutation.

### BI-I04 — Placement Integrity

A structure cannot become authoritative through an invalid placement.

### BI-I05 — Persistence Integrity

A completed structure must remain reconstructable from authoritative state.

### BI-I06 — State/Presentation Separation

Visual nodes cannot be the authoritative source of building truth.

### BI-I07 — Permission Integrity

Temporary or delegated access must not silently become ownership.

### BI-I08 — Safe Demolition

Unauthorized actors cannot demolish persistent player structures.

### BI-I09 — Extensibility

The building architecture must support future property contexts without requiring a separate construction engine for each one.

---

# 65. Definition of Done

BI-001 is considered implementation-ready when:

* the construction lifecycle is implemented;
* authoritative building state exists;
* construction definitions are data-driven;
* placement validation works;
* ghost preview works;
* supported snapping works;
* supported rotation works;
* construction resource validation works;
* ownership validation works;
* permission validation works;
* construction persistence works;
* reconstruction from state works;
* demolition works;
* relocation works;
* multiplayer authority boundaries are enforced;
* invalid requests fail safely;
* automated tests cover core invariants;
* relevant parent specifications remain consistent.

---

# 66. Governance

BI-001 is subordinate to:

**North Star → Foundation → System**

and takes precedence over lower-level implementation documents where it establishes gameplay rules.

Implementation documents may specify *how* the rules are implemented.

They may not silently change *what* the rules are.

Any significant change to BI-001 requires specification reconciliation according to MSI governance.

---

# 67. Final System Statement

> **Building in Underhallow is a major lifestyle built around meaningful creation. Players gather resources, develop construction skill, create functional and beautiful structures, customize their spaces, and gradually transform them into expressions of identity. The system provides broad creative freedom while preserving world rules, progression, persistence, multiplayer ownership, and long-term extensibility.**

---
