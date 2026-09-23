# Underhallow Documentation Architecture

Welcome to the central documentation index for **Underhallow**. This repository adheres to a strict, categorized documentation architecture designed for human-directed, AI-agent-assisted, human-QA-gated game development.

---

## 1. Directory Tree & Architecture

All documentation in Underhallow is partitioned into nine operational categories (`00-governance` through `08-reports`):

```text
docs/
├── README.md                                               # This central documentation index
├── 00-governance/                                          # Project governance, rules, constitution, & indexing
│   ├── AGENT_CONSTITUTION.md                               # AC-001: AI agent roles, whitelists, & Definition of Done
│   ├── EXECUTION_DOCUMENTATION_PROTOCOL.md                 # EDP-001: Execution, evidence, & team synchronization protocol
│   ├── MASTER_SPECIFICATION_INDEX.md                       # MSI-001: Central registry, authority levels, & roadmap
│   └── SPECIFICATION_RECONCILIATION.md                     # SR-001: Approved engine, platform, & architecture reconciliation
│
├── 01-product/                                             # High-level product vision, boundaries, & milestones
│   ├── NORTH_STAR.md                                       # NS-001: Core vision, immutable invariants, & design pillars
│   ├── FOUNDATION_SPECIFICATION.md                         # FS-001: Foundational system boundaries & product definition
│   └── PRODUCTION_PLAN.md                                  # PP-001: Phased roadmap (Phases 0–7) & vertical slice gates
│
├── 02-architecture/                                        # Technical architecture & engine implementations
│   ├── ENGINE_TECHNICAL_ARCHITECTURE_SPECIFICATION.md       # ETA-001: Godot 4.x, state authority, server & persistence
│   ├── IMPLEMENTATION_ARCHITECTURE_SPECIFICATION.md         # IA-001: GDScript domain structure, input actions, & slice specs
│   └── TECHNICAL_ARCHITECTURE.md                           # TA-001: Legacy browser/Phaser baseline (SUPERSEDED)
│
├── 03-gameplay/                                            # Core and universal gameplay systems
│   ├── CORE_GAMEPLAY_SYSTEMS_SPECIFICATION.md              # CG-001: Primary loops, 5 pillars, 8 world systems, & invariants
│   ├── FARMING_SYSTEM_SPECIFICATION.md                     # FB-001: Soil, tilling, watering, crop growth, & harvesting
│   ├── HUNTING_COMBAT_SYSTEM_SPECIFICATION.md              # HU-001: Weapon handling, wildlife encounters, tracking, & harvesting
│   ├── BUILDING_CONSTRUCTION_SYSTEM_SPECIFICATION.md       # BI-001: Universal construction framework & hybrid placement
│   ├── PLAYER_CONTROL_MOVEMENT_INTERACTION_SPECIFICATION.md # PC-001: Continuous isometric controls, targeting, & camera
│   └── PLAYER_PROGRESSION_SPECIFICATION.md                 # PR-001: Skill development, unlock trees, & progression pacing
│
├── 04-world/                                               # World geography, biomes, wildlife, & territories
│   ├── WORLD_BIBLE.md                                      # WB-001: Island lore, geography, history, & emotional arc
│   ├── WORLD_MAP_ARCHITECTURE_SPECIFICATION.md             # WM-001: Isometric chunking, coordinate geometry, & transitions
│   ├── MAIN_ISLAND_DESIGN_SPECIFICATION.md                 # MI-001: Communal geography, 7–9 regions, & landmark navigation
│   ├── PERSONAL_ISLAND_DESIGN_SPECIFICATION.md             # PI-001: Private sanctuary, cottage evolution, & homesteading
│   ├── BIOME_ENVIRONMENT_BIBLE.md                          # BE-001: 16 Environmental Laws, 6-tier hierarchy, & ecotones
│   └── CREATURE_WILDLIFE_BIBLE.md                          # CW-001: 16 Wildlife Laws, 10 taxonomies, & behavior tiers
│
├── 05-narrative/                                           # Storytelling, character design, & mystery framework
│   ├── NARRATIVE_BIBLE.md                                  # NB-001: 6-phase mystery curve, grandparent legacy, & 10 laws
│   ├── CHARACTER_BIBLE.md                                  # CB-001: Living population, 30–50 NPC roster, routines, & memory
│   └── MYSTERY_LORE_ARCHITECTURE_SPECIFICATION.md          # ML-001: 5 mystery layers, 20 mystery laws, & revelation phases
│
├── 06-art/                                                 # Visual identity, aesthetics, & art standards
│   ├── ART_DIRECTION_BIBLE.md                              # AD-001: Handcrafted pixel art, isometric view, lighting, & UI
│   └── CREATIVE_DIRECTION.md                               # CD-001: 65% Cozy / 35% Adventure balance & Invariant 11
│
├── 07-multiplayer/                                         # Multiplayer, dedicated servers, & social systems
│   └── MULTIPLAYER_SOCIAL_SYSTEMS_SPECIFICATION.md         # MS-001: Player co-op, trade, chat, guilds, & netcode
│
└── 08-reports/                                             # Verification passes, test logs, audits, & session records
    ├── qa/                                                 # Automated & manual QA execution reports (QA-001, QA-002, etc.)
    │   ├── QA_SESSION_01_REPORT.md                         # QA-001: Baseline Phase 1 runtime test execution report
    │   ├── QA_CONSTRUCTION_SURGICAL_PASS_3_REPORT.md       # QA-002: Construction Pass 3 coordinate verification
    │   ├── QA_HUNTING_SURGICAL_PASS_REPORT.md              # QA-003: Hunting loop & discovery contract verification
    │   └── QA_CLEMENTINE_PROVENANCE_REVERIFICATION_REPORT.md # QA-004: Clementine provenance correction re-verification
    ├── architecture/                                       # Architectural audits, state boundary checks, technical debt
    ├── gameplay/                                           # Playability notes, mechanical balance, tuning logs
    ├── infrastructure/                                     # Server deployment, persistence, performance profiling
    ├── narrative/                                          # Lore audits, dialogue review, consistency checks
    ├── world/                                              # Map balance, coordinate alignment, tile budget checks
    ├── gm/                                                 # Game Master review records & sign-offs
    │   ├── GM_SESSION_RECORD_PROTOCOL.md                   # GSP-001: Formal GM Review Protocol & Template
    │   ├── GM_SESSION_20260918_EDP001_ACCEPTANCE.md        # GM-20260918-001: EDP-001 Post-Acceptance Synchronization Record
    │   └── GM_SESSION_20260918_CLEMENTINE_NARRATIVE_SLICE.md # GM-20260918-002: Clementine Narrative Slice Acceptance Record
    └── gm2/                                                # GM2 planning records, archived briefs, and review reports to GM1
        └── README.md                                       # GM2 report storage directory standard
```

---

## 2. Category Classification & Placement Rules

When authoring new documents or filing reports, place them strictly according to this taxonomy:

### `00-governance/`
Contains the overarching rules that govern how development is conducted.
* **Master Specification Index (MSI):** The central registry for all specifications.
* **Agent Constitution:** Development boundaries, agent roles, domain whitelists, and Definitions of Done.
* **Execution & Documentation Protocol (EDP):** 12-stage multi-agent work lifecycle (Human → GM1 → GM2 → Gemini → Team Review → QA → GM2 → GM1), session assignments, GM2 implementation brief standard, and documentation synchronization.
* **Reconciliation Specifications:** High-level decisions resolving platform, engine, or scope shifts.

### `01-product/`
High-level product identity, scope, and scheduling.
* **North Star:** Vision, core philosophy, and immutable design invariants.
* **Foundation Specification:** Universal system boundaries and product definitions.
* **Production Plan:** Phased delivery plans, milestones, and vertical slice roadmaps.

### `02-architecture/`
Technical specifications governing engine mechanics, client-server topology, and low-level software architecture.
* Technical architecture specifications (ETA).
* Implementation architecture blueprints (IA).
* Historical/superseded technical baselines.

### `03-gameplay/`
Universal game systems, mechanics, player controls, and progression loops.
* Organized around five **Core Gameplay Pillars** (lifestyles: Farming, Hunting, Mining, Fishing, Animal Husbandry) and eight **Core World Systems** (infrastructure: Building, Trading/Economy, Social, World/Exploration, Combat, Inventory/Items, Quests/Progression, Crafting).
* Defines foundational player livelihoods, cross-pillar transformation, and universal game rules.

### `04-world/`
Spatial, geographical, environmental, and ecological specifications.
* World Bibles and territory design specifications (Main Island, Personal Island, Guild Islands).
* Environmental rules, biome classifications, and wildlife/creature bibles.

### `05-narrative/`
The narrative fabric of Underhallow.
* Narrative bibles, character designs, NPC schedules, dialogue architectures.
* Mystery and lore frameworks, revelation curves, and environmental storytelling.

### `06-art/`
Visual, aesthetic, and stylistic guidelines.
* Modern pixel art standards, color palettes, isometric tile guidelines, and lighting.
* Creative direction and visual tone specifications.

### `07-multiplayer/`
Social, networking, and collective player infrastructure.
* Dedicated server synchronization, co-op interactions, guild structures, and economies.

### `08-reports/`
Historical execution reports, test runs, audit logs, and executive review sessions. Never place design specifications in `08-reports/`.
* **`qa/`**: Formal QA verification passes verifying code commits against requirements.
* **`architecture/`**: Architectural drift analysis, boundary audits, and refactoring proposals.
* **`gameplay/`**: Playtest balance logs and control feel audits.
* **`infrastructure/`**: Server performance, load tests, and database migration logs.
* **`narrative/`**: Narrative consistency checks and lore audits.
* **`world/`**: Level design, collision mesh, and coordinate validation logs.
* **`gm/`**: Executive Game Master (GM1) reviews, experiential evaluations, milestone sign-offs, and protocol specifications (e.g. `GSP-001`).
* **`gm2/`**: Execution planning records, archived implementation briefs, and coordination reports from GM2 to GM1 per `EDP-001`.

---

## 3. Specification Governance & Linking Standards

### 3.1 Document ID System
Every formal specification receives a permanent Document ID and prefix (e.g., `NS-001`, `ETA-001`, `BI-001`, `GSP-001`, `QA-001`). See [Master Specification Index (MSI-001)](00-governance/MASTER_SPECIFICATION_INDEX.md) for the complete prefix registry.

### 3.2 Canonical Link Format
All internal markdown links must use clean **repository-relative paths** resolving from the current document to the target document:
```markdown
[Display Text](<relative-path-to-document>.md)
```
Example from `docs/README.md`:
```markdown
[Underhallow North Star V1.0 (NS-001)](01-product/NORTH_STAR.md)
```
Example from a category directory (e.g. `docs/00-governance/`):
```markdown
[Underhallow North Star V1.0 (NS-001)](../01-product/NORTH_STAR.md)
```
Machine-specific absolute URLs (`file:///C:/Users/...`) and local filesystem paths are strictly prohibited in committed documentation.

### 3.3 Adding or Moving Documents
1. **Never create loose documents in root `docs/`:** Every document belongs in a categorized directory (`00`–`08`).
2. **Update the Master Specification Index:** Register the new document in `docs/00-governance/MASTER_SPECIFICATION_INDEX.md` (§4 Prefix Table and §28 Registry Table).
3. **Verify Link Integrity:** Validate that all internal markdown links resolve using repository-relative paths to ensure zero broken links.
