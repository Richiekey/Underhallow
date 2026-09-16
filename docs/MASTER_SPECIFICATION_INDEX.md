# UNDERHALLOW

## Master Specification Index & Build Governance

### Version 1.1 — Reconciled Baseline

**Document ID:** MSI-001  
**Status:** APPROVED (Project Governance Baseline)  
**Authority Level:** Level 0 — Project Governance & Control Layer  
**Applies To:** All Underhallow design, specification, implementation, testing, and agent workflows  
**Repository:** `Richiekey/Underhallow`  

---

## 1. Purpose

The **Master Specification Index (MSI)** is the central registry and governance layer for Underhallow's technical and game-design documentation.

Its purpose is to ensure that:

* every major system has a known specification;
* specifications have clear ownership and dependencies;
* authoritative decisions are not accidentally contradicted;
* agents know which documents they must read before working;
* implementation progresses in a controlled order;
* experimental ideas remain distinguishable from locked decisions;
* cross-system changes are properly evaluated;
* obsolete specifications are archived rather than silently deleted;
* the project maintains a single source of truth.

The MSI does **not** replace individual specifications.

Instead:

> **The MSI tells the project what specifications exist, how they relate to one another, which specification has authority, and what state each system is in.**

---

# 2. Governance Principles

Underhallow documentation follows these principles.

### 2.1 Single Source of Truth

Every authoritative game or technical decision must ultimately exist in an appropriate specification.

Chat conversations, agent suggestions, task prompts, prototypes, comments, and temporary notes do not override locked specifications.

---

### 2.2 Authority Follows the Specification Hierarchy

When two documents appear to conflict, the higher-authority document takes precedence unless the conflict is formally resolved.

The authority hierarchy is:

1. **North Star & Creative Authority (Level 0)**
2. **Foundation Specifications (Level 1)**
3. **World & Gameplay System Specifications (Level 2)**
4. **Supporting Systems (Level 3)**
5. **Implementation & Governance Specifications (Level 4)**
6. **Agent Task Specifications**

An agent must not resolve an authority conflict by simply choosing whichever document is more convenient.

---

### 2.3 Human Authority Through the Master Specification

The ultimate project authority is the human project owner (Founder / Omni).

However, decisions are operationalized through the Master Specification system rather than informal instructions scattered throughout development.

Therefore:

> **The human owner establishes authority; the Master Specification system records and distributes that authority.**

---

### 2.4 Specification Before Production

A system should not enter production implementation without sufficient specification.

However, Underhallow does **not** require every system to be fully specified before any prototype can exist.

The project uses progressive specification and prototype validation.

---

# 3. Specification Hierarchy

Underhallow documentation is divided into five distinct operational levels:

## Level 0 — Project Authority

These documents establish the fundamental creative vision, immutable design principles, and governance rules of Underhallow. They possess the highest project-level authority.

Current documents include:

* **North Star V1.0** (`NS-001`) — Vision, Core Philosophy, & Immutable Invariants
* **Creative Direction V1.0** (`CD-001`) — Canonical Creative Foundation & Invariant 11
* **Art Direction Bible V1.0** (`AD-001`) — Canonical Art Direction Specification & Invariant 12
* **World Bible V1.0** (`WB-001`) — Canonical World-Building Foundation & Invariant 13
* **Agent Constitution V1.0** (`AC-001`) — Development Governance, Agent Whitelists, & DoD
* **Specification Reconciliation V1.0** (`SR-001`) — Approved Architecture Reconciliation
* **Master Specification Index & Build Governance V1.1** (`MSI-001`) — Project Navigation & Control Layer

---

## Level 1 — Foundation Specifications

Foundation specifications translate Level 0 creative and product authority into structural architectures for gameplay, technology, world geography, narrative, and character identity.

Current established documents include:

* **Foundation Specification V1.0** (`FS-001`) — Product & System Definition Baseline
* **Engine & Technical Architecture Specification V1** (`ETA-001`) — Engine, State, Dedicated Server & Persistence (supersedes `TA-001`)
* **Core Gameplay Systems Specification V1.0** (`CG-001`) — Primary Loops, Pillars, Agency, & Gameplay Invariants
* **Player Control, Movement & Interaction Specification V1.0** (`PC-001`) — Traversal, Interactions, & Fixed Camera Controls
* **World & Map Architecture Specification V1.0** (`WM-001`) — Isometric Map, Chunking, Y-Sort Depth, & Coordinate Geometry
* **Narrative Bible V1.0** (`NB-001`) — Narrative Architecture, Mystery Curve, & Ten Narrative Laws
* **Character Bible V1.0** (`CB-001`) — Living Population Architecture, NPC Tiers, & Community Relations
* **Biome & Environment Bible V1.1** (`BE-001`) — Environmental Identity, 16 Canonical Environmental Laws, 6-Tier Hierarchy, Gameplay Affordance Matrix, & Mystery Density Model
* **Creature & Wildlife Bible V1.0** (`CW-001`) — Wildlife Philosophy, 16 Wildlife Laws, 10 Taxonomies, & 4-Tier Spectrum
* **Mystery & Lore Architecture Specification V1.0** (`ML-001`) — Mystery Architecture, 5 Mystery Layers, 20 Core Laws, & 7-Stage Revelations

Planned Creative / World Foundations:

* **Narrative Content Framework V1.0** (`NC-001`) — **NEXT CREATIVE SPECIFICATION TO DRAFT**

---

## Level 2 — World & Gameplay System Specifications

These define concrete world territories and individual major game systems.

### 2.1 World & Territory Contexts

* **Main Island Design Specification V1.0** (`MI-001`) — Shared Geography, 7–9 Regions, Landmarks, Wilderness
* **Personal Island Design Specification V1.0** (`PI-001`) — Private Sanctuary, Homestead Evolution, Preparation Hub [Specializes `BI-001`]
* **Regional World Specifications** (`RW-001`) — Planned
* **Town Social Structure Specification** (`TC-001`) — Planned
* **Major NPC / Character Roster Specification** (`CR-001`) — Planned
* **World Events & Festival Direction Specification** (`EV-001`) — Planned

### 2.2 Universal Gameplay Systems

* **Player Progression Specification V1.0** (`PR-001`)
* **Farming System Specification V1.0** (`FB-001`)
* **Livestock & Animal Husbandry Specification V1.0** (`LA-001`) — Planned
* **Hunting & Combat System Specification V1.0** (`HU-001`)
* **Fishing Specification V1.0** (`FI-001`) — Planned
* **Foraging & Wild Resources Specification V1.0** (`FR-001`) — Planned
* **Resource Gathering, Forestry & Mining Specification V1.0** (`RG-001`) — Planned
* **Cooking & Food Specification V1.0** (`CK-001`) — Planned
* **Building & Construction System Specification V1.0** (`BI-001`) — Universal Construction Framework
* **Inventory, Items, Tools & Crafting Specification V1.0** (`II-001`) — Planned
* **Exploration & Secrets Specification V1.0** (`EX-001`) — Planned
* **Transportation & Travel Specification V1.0** (`TR-001`) — Planned
* **Time, Day/Night & Simulation Specification V1.0** (`TS-001`) — Planned
* **Weather & Environmental Systems Specification V1.0** (`WE-001`) — Planned
* **NPCs, Dialogue & Quests Specification V1.0** (`NQ-001`) — Planned
* **Multiplayer & Social Systems Specification V1.0** (`MS-001`) — Cross-Cutting Social Systems
* **Economy Specification V1.0** (`EC-001`) — Planned
* **Story & Narrative Architecture Specification V1.0** (`ST-001`) — Planned

---

## Level 3 — Supporting Systems

These define systems that support gameplay presentation, accessibility, audio, and player configuration.

Current planned examples include:

* **UI / UX Specification** (`UI-001`) — Planned
* **Audio & Music Direction Bible** (`AU-001`) — Planned
* **Save System Specification** (`SV-001`) — Planned
* **Input Settings Specification** (`IS-001`) — Planned
* **Accessibility Specification** (`AX-001`) — Planned
* Supporting Runtime Specifications (Notifications, Loading/Transition Systems, Performance Budgets)

---

## Level 4 — Implementation & Governance Specifications

These documents translate approved system designs into concrete engineering requirements, production schedules, and quality gates.

Current documents include:

* **Implementation Architecture Specification V1.1** (`IA-001`) — REVIEW (Godot 4.x, GDScript Domain Structure, Input Actions, V0.1 Slice)
* **Production Plan & Vertical Slice Roadmap V1.0** (`PP-001`) — APPROVED (Phases 0–7, Vertical Slice Roadmap, Quality Gates)
* **QA & Testing Specification** (`QA-001`) — PLANNED

---

# 4. Document Registry Prefix Table

Every major specification receives a permanent Document ID. The canonical prefix registry is:

| Prefix | Document Category | Authority Level |
| :--- | :--- | :---: |
| `NS` | North Star | 0 |
| `CD` | Creative Direction | 0 |
| `AD` | Art Direction Bible | 0 |
| `WB` | World Bible | 0 |
| `AC` | Agent Constitution | 0 |
| `SR` | Specification Reconciliation | 0 |
| `MSI` | Master Specification Index | 0 |
| `FS` | Foundation Specification | 1 |
| `ETA` | Engine & Technical Architecture (`TA` superseded) | 1 |
| `CG` | Core Gameplay Systems | 1 |
| `PC` | Player Control, Movement & Interaction | 1 |
| `WM` | World & Map Architecture | 1 |
| `NB` | Narrative Bible | 1 |
| `CB` | Character Bible | 1 |
| `BE` | Biome & Environment Bible | 1 |
| `CW` | Creature & Wildlife Bible | 1 |
| `ML` | Mystery & Lore Architecture | 1 |
| `NC` | Narrative Content Framework | 1 |
| `MI` | Main Island Design | 2 |
| `PI` | Personal Island Design | 2 |
| `RW` | Regional World Specifications | 2 |
| `TC` | Town Social Structure | 2 |
| `CR` | Major NPC / Character Roster | 2 |
| `EV` | World Events & Festival Direction | 2 |
| `PR` | Player Progression | 2 |
| `FB` | Farming System | 2 |
| `LA` | Livestock & Animal Husbandry | 2 |
| `HU` | Hunting & Combat System | 2 |
| `FI` | Fishing | 2 |
| `FR` | Foraging & Wild Resources | 2 |
| `RG` | Resource Gathering, Forestry & Mining | 2 |
| `CK` | Cooking & Food | 2 |
| `BI` | Building & Construction System | 2 |
| `II` | Inventory, Items, Tools & Crafting | 2 |
| `EX` | Exploration & Secrets | 2 |
| `TR` | Transportation & Travel | 2 |
| `TS` | Time, Day/Night & Simulation | 2 |
| `WE` | Weather & Environmental Systems | 2 |
| `NQ` | NPCs, Dialogue & Quests | 2 |
| `MS` | Multiplayer & Social Systems | 2 |
| `EC` | Economy | 2 |
| `ST` | Story & Narrative Architecture | 2 |
| `UI` | UI / UX | 3 |
| `AU` | Audio & Music Direction Bible | 3 |
| `SV` | Save System | 3 |
| `AX` | Accessibility | 3 |
| `IS` | Input Settings | 3 |
| `IA` | Implementation Architecture | 4 |
| `PP` | Production Plan & Roadmap | 4 |
| `QA` | QA & Testing | 4 |

---

# 5. Versioning

Underhallow uses semantic document versioning:

### Minor Version
Represents clarification, refinement, or metadata reconciliations that do not fundamentally alter system rules. Example: `V1.0 → V1.1`.

### Major Version
Represents a fundamental design or architectural change. Example: `V1.1 → V2.0`. Major revisions require dependency review and validation of affected systems.

---

# 6. Document Statuses

Every specification must possess one of the following statuses:

* **PLANNED:** Identified in the roadmap; drafting has not yet begun. Implementation must not begin on un-drafted specifications.
* **DRAFT:** Actively being designed. Decisions represent design baselines but are subject to revision prior to lock.
* **REVIEW:** Substantially complete and undergoing cross-system dependency review.
* **APPROVED:** Formally reviewed and adopted as authoritative foundation architecture.
* **LOCKED:** Authoritative baseline. Governs all implementation; cannot be modified without formal change request.
* **DEPRECATED:** Intentionally retired. Preserved for historical context; must not guide new work.
* **SUPERSEDED:** Replaced by a newer specification. The replacement document must be explicitly cited.

---

# 7. Agent Access & Specification Requirements

All specialized agents must consult the Master Specification Index before beginning substantive work.

The agent must determine:
1. which system it is working on;
2. which specification governs that system;
3. which parent specifications apply;
4. which dependencies may be affected;
5. whether the relevant specification is DRAFT, REVIEW, or LOCKED;
6. whether implementation is currently authorized.

Agents are not expected to blindly read the entire documentation library for every task. Instead, the MSI provides the exact dependency path required for the task.

---

# 8. Parent Specification Requirement

Before modifying a system, an agent must read the specifications directly relevant to that system and the necessary parent specifications identified by the MSI.

### 8.1 Agent Mandatory Reading Matrices

To avoid unnecessary reading while ensuring absolute fidelity to established design, agents must follow these domain-specific reading paths:

| Domain / Work Area | Minimum Required Reading Sequence |
| :--- | :--- |
| **Creative / World / Lore** | `MSI-001` → `NS-001` → `CD-001` → `AD-001` → `WB-001` → `NB-001` → `ML-001` → `BE-001` → `CW-001` → `WM-001` / `MI-001` |
| **Character / Social / Quests** | `MSI-001` → `NS-001` → `CD-001` → `WB-001` → `NB-001` → `CB-001` → `ML-001` → `MI-001` → `NQ-001` / `MS-001` |
| **Main Island & Regional Exploration** | `MSI-001` → `NS-001` → `CD-001` → `AD-001` → `WB-001` → `NB-001` → `CB-001` → `BE-001` → `CW-001` → `ML-001` → `WM-001` → `CG-001` → `MI-001` |
| **Personal Island & Homestead** | `MSI-001` → `NS-001` → `CD-001` → `AD-001` → `WB-001` → `BE-001` → `CW-001` → `ML-001` → `CG-001` → `WM-001` → `BI-001` → `PI-001` (+ `FB-001`) |
| **Building & Construction Systems** | `MSI-001` → `NS-001` → `CD-001` → `AD-001` → `CG-001` → `ETA-001` → `PC-001` → `BI-001` (universal) → `PI-001` (personal context) |
| **Core Gameplay Loops (Farming, Hunting, Gathering)** | `MSI-001` → `NS-001` → `CG-001` → `PC-001` → `ETA-001` → `CW-001` → System Spec (`FB-001`, `HU-001`, etc.) → `PR-001` |
| **Engine, State & Persistence Engineering** | `MSI-001` → `NS-001` → `AC-001` → `SR-001` → `FS-001` → `ETA-001` → `CG-001` → `IA-001` → `PP-001` |
| **Presentation, Audio & UI/UX** | `MSI-001` → `NS-001` → `CD-001` → `AD-001` → `CG-001` → `PC-001` → `UI-001` / `AU-001` |

---

# 9. Task Specifications

Not every task requires its own formal document.

Task specifications are required for **complex, high-risk, cross-system, or architectural work**. Simple implementation tasks may operate directly from the relevant locked specification.

---

# 10. Definition of Done

Underhallow uses a **dual Definition of Done** model:
- **Universal Definition of Done:** Requirements applicable to all production work (spec compliance, tests pass, no regressions, docs updated).
- **System-Specific Definition of Done:** Additional completion criteria established by each major system.

> **Every system must satisfy both the universal project requirements and its own system-specific completion requirements.**

---

# 11. Agent Ownership

Every major specification should identify:
* **Primary Agent**
* **Supporting Agents**
* **Human Owner / Final Authority**

Primary ownership does not grant authority to violate higher-level specifications.

---

# 12. Agent Modification Authority

- **Ordinary implementation decisions:** Broad autonomy within the boundaries of the specification.
- **Isolated technical decisions:** Autonomy where there is no impact on authoritative game design or architecture.
- **Authoritative design changes:** Agents may propose changes but may not independently rewrite locked foundation decisions.

---

# 13. Cross-System Dependency Management

Any meaningful cross-system change requires a dependency impact check. The responsible agent must determine affected specifications, dependencies, tests, and documentation.

---

# 14. Change Request System

A formal Change Request mechanism exists for major changes, tracking Change ID, reason, current vs proposed behavior, affected specs, risks, approval, and version updates.

---

# 15. Decision Log

Underhallow maintains a permanent decision log recording Decision ID, date, decision, reasoning, alternatives considered, affected systems, and resulting specification changes.

---

# 16. Rejected Ideas Log

Underhallow maintains a lightweight rejected-ideas record to prevent future agents from repeatedly proposing the same rejected concept.

---

# 17. Experimental Systems

Underhallow explicitly supports an **EXPERIMENTAL** state for testing ideas before permanent adoption.

---

# 18. Experimental → Official Promotion

Process: **Experiment → Evaluation → Decision → Specification Update → Lock → Production**.

---

# 19. Archive Policy

Deprecated and superseded specifications are retained for historical context and traceability.

---

# 20. Open Questions

- **DRAFT / REVIEW:** May contain open questions, alternatives, assumptions, experiments.
- **LOCKED:** Must contain resolved authoritative decisions.

---

# 21. Design Freeze

Progressive design freezes:  
**Concept → Draft Specification → Prototype → Validation → Specification Refinement → Lock → Production**.

---

# 22. Prototype-First Philosophy

**Specify enough → Prototype → Learn → Refine → Lock → Build**.

---

# 23. Implementation Lifecycle

States:
1. **Concept**
2. **Designed**
3. **Specified**
4. **Prototyped**
5. **In Development**
6. **Implemented**
7. **Tested**
8. **Production Ready**

---

# 24. Agent Conflict Resolution

Resolution order:
1. Check specification hierarchy.
2. Determine governing authoritative document.
3. Check Master Index dependency structure.
4. Escalate if unresolved.
5. Human project authority resolves the issue.

> **Higher authority wins; unresolved conflicts escalate.**

---

# 25. QA Authority

QA is an independent authority and may reject implementations that violate specifications, fail tests, or introduce regressions.

---

# 26. QA Lifecycle

**Specification → Implementation → QA → Revision → QA → Acceptance**.

---

# 27. Master Specification Registry Structure

Maintains: Document ID, Document Name, Version, Status, Authority Level, Purpose, Parent Documents, Dependencies, Affected Systems, Primary Agent, Supporting Agents, Implementation Status, Open Questions, Last Decision, Change History.

---

# 28. Underhallow Specification Registry

The following table documents the active specification registry for the Underhallow repository:

| ID | Specification Name | Level | Status | Canonical File Link |
| :--- | :--- | :---: | :---: | :--- |
| **NS-001** | North Star | 0 | LOCKED | [docs/NORTH_STAR.md](file:///c:/Users/HP/Documents/Underhallow/docs/NORTH_STAR.md) |
| **CD-001** | Creative Direction | 0 | LOCKED | [docs/CREATIVE_DIRECTION.md](file:///c:/Users/HP/Documents/Underhallow/docs/CREATIVE_DIRECTION.md) |
| **AD-001** | Art Direction Bible | 0 | LOCKED | [docs/ART_DIRECTION_BIBLE.md](file:///c:/Users/HP/Documents/Underhallow/docs/ART_DIRECTION_BIBLE.md) |
| **WB-001** | World Bible | 0 | LOCKED | [docs/WORLD_BIBLE.md](file:///c:/Users/HP/Documents/Underhallow/docs/WORLD_BIBLE.md) |
| **AC-001** | Agent Constitution | 0 | LOCKED | [docs/AGENT_CONSTITUTION.md](file:///c:/Users/HP/Documents/Underhallow/docs/AGENT_CONSTITUTION.md) |
| **SR-001** | Specification Reconciliation | 0 | APPROVED | [docs/SPECIFICATION_RECONCILIATION.md](file:///c:/Users/HP/Documents/Underhallow/docs/SPECIFICATION_RECONCILIATION.md) |
| **MSI-001** | Master Specification Index & Build Governance | 0 | APPROVED | [docs/MASTER_SPECIFICATION_INDEX.md](file:///c:/Users/HP/Documents/Underhallow/docs/MASTER_SPECIFICATION_INDEX.md) |
| **FS-001** | Foundation Specification | 1 | APPROVED | [docs/FOUNDATION_SPECIFICATION.md](file:///c:/Users/HP/Documents/Underhallow/docs/FOUNDATION_SPECIFICATION.md) |
| **ETA-001** | Engine & Technical Architecture | 1 | APPROVED | [docs/ENGINE_TECHNICAL_ARCHITECTURE_SPECIFICATION.md](file:///c:/Users/HP/Documents/Underhallow/docs/ENGINE_TECHNICAL_ARCHITECTURE_SPECIFICATION.md) |
| **TA-001** | Technical Architecture (Browser/Phaser Prototype Baseline) | 1 | SUPERSEDED | [docs/TECHNICAL_ARCHITECTURE.md](file:///c:/Users/HP/Documents/Underhallow/docs/TECHNICAL_ARCHITECTURE.md) |
| **CG-001** | Core Gameplay Systems | 1 | LOCKED | [docs/CORE_GAMEPLAY_SYSTEMS_SPECIFICATION.md](file:///c:/Users/HP/Documents/Underhallow/docs/CORE_GAMEPLAY_SYSTEMS_SPECIFICATION.md) |
| **PC-001** | Player Control, Movement & Interaction | 1 | APPROVED | [docs/PLAYER_CONTROL_MOVEMENT_INTERACTION_SPECIFICATION.md](file:///c:/Users/HP/Documents/Underhallow/docs/PLAYER_CONTROL_MOVEMENT_INTERACTION_SPECIFICATION.md) |
| **WM-001** | World & Map Architecture | 1 | APPROVED | [docs/WORLD_MAP_ARCHITECTURE_SPECIFICATION.md](file:///c:/Users/HP/Documents/Underhallow/docs/WORLD_MAP_ARCHITECTURE_SPECIFICATION.md) |
| **NB-001** | Narrative Bible | 1 | DRAFT | [docs/NARRATIVE_BIBLE.md](file:///c:/Users/HP/Documents/Underhallow/docs/NARRATIVE_BIBLE.md) |
| **CB-001** | Character Bible | 1 | DRAFT | [docs/CHARACTER_BIBLE.md](file:///c:/Users/HP/Documents/Underhallow/docs/CHARACTER_BIBLE.md) |
| **BE-001** | Biome & Environment Bible | 1 | DRAFT | [docs/BIOME_ENVIRONMENT_BIBLE.md](file:///c:/Users/HP/Documents/Underhallow/docs/BIOME_ENVIRONMENT_BIBLE.md) |
| **CW-001** | Creature & Wildlife Bible | 1 | DRAFT | [docs/CREATURE_WILDLIFE_BIBLE.md](file:///c:/Users/HP/Documents/Underhallow/docs/CREATURE_WILDLIFE_BIBLE.md) |
| **ML-001** | Mystery & Lore Architecture | 1 | DRAFT | [docs/MYSTERY_LORE_ARCHITECTURE_SPECIFICATION.md](file:///c:/Users/HP/Documents/Underhallow/docs/MYSTERY_LORE_ARCHITECTURE_SPECIFICATION.md) |
| **NC-001** | Narrative Content Framework | 1 | PLANNED | Not yet drafted *(Next Creative Specification)* |
| **MI-001** | Main Island Design | 2 | DRAFT | [docs/MAIN_ISLAND_DESIGN_SPECIFICATION.md](file:///c:/Users/HP/Documents/Underhallow/docs/MAIN_ISLAND_DESIGN_SPECIFICATION.md) |
| **PI-001** | Personal Island Design | 2 | DRAFT | [docs/PERSONAL_ISLAND_DESIGN_SPECIFICATION.md](file:///c:/Users/HP/Documents/Underhallow/docs/PERSONAL_ISLAND_DESIGN_SPECIFICATION.md) |
| **RW-001** | Regional World Specifications | 2 | PLANNED | Not yet drafted |
| **TC-001** | Town Social Structure | 2 | PLANNED | Not yet drafted |
| **CR-001** | Major NPC / Character Roster | 2 | PLANNED | Not yet drafted |
| **EV-001** | World Events & Festival Direction | 2 | PLANNED | Not yet drafted |
| **PR-001** | Player Progression | 2 | DRAFT | [docs/PLAYER_PROGRESSION_SPECIFICATION.md](file:///c:/Users/HP/Documents/Underhallow/docs/PLAYER_PROGRESSION_SPECIFICATION.md) |
| **FB-001** | Farming System | 2 | DRAFT | [docs/FARMING_SYSTEM_SPECIFICATION.md](file:///c:/Users/HP/Documents/Underhallow/docs/FARMING_SYSTEM_SPECIFICATION.md) |
| **LA-001** | Livestock & Animal Husbandry | 2 | PLANNED | Not yet drafted |
| **HU-001** | Hunting & Combat System | 2 | DRAFT | [docs/HUNTING_COMBAT_SYSTEM_SPECIFICATION.md](file:///c:/Users/HP/Documents/Underhallow/docs/HUNTING_COMBAT_SYSTEM_SPECIFICATION.md) |
| **FI-001** | Fishing | 2 | PLANNED | Not yet drafted |
| **FR-001** | Foraging & Wild Resources | 2 | PLANNED | Not yet drafted |
| **RG-001** | Resource Gathering, Forestry & Mining | 2 | PLANNED | Not yet drafted |
| **CK-001** | Cooking & Food | 2 | PLANNED | Not yet drafted |
| **BI-001** | Building & Construction System | 2 | DRAFT | [docs/BUILDING_CONSTRUCTION_SYSTEM_SPECIFICATION.md](file:///c:/Users/HP/Documents/Underhallow/docs/BUILDING_CONSTRUCTION_SYSTEM_SPECIFICATION.md) |
| **II-001** | Inventory, Items, Tools & Crafting | 2 | PLANNED | Not yet drafted |
| **EX-001** | Exploration & Secrets | 2 | PLANNED | Not yet drafted |
| **TR-001** | Transportation & Travel | 2 | PLANNED | Not yet drafted |
| **TS-001** | Time, Day/Night & Simulation | 2 | PLANNED | Not yet drafted |
| **WE-001** | Weather & Environmental Systems | 2 | PLANNED | Not yet drafted |
| **NQ-001** | NPCs, Dialogue & Quests | 2 | PLANNED | Not yet drafted |
| **MS-001** | Multiplayer & Social Systems | 2 | DRAFT | [docs/MULTIPLAYER_SOCIAL_SYSTEMS_SPECIFICATION.md](file:///c:/Users/HP/Documents/Underhallow/docs/MULTIPLAYER_SOCIAL_SYSTEMS_SPECIFICATION.md) |
| **EC-001** | Economy | 2 | PLANNED | Not yet drafted |
| **ST-001** | Story & Narrative Architecture | 2 | PLANNED | Not yet drafted |
| **UI-001** | UI / UX | 3 | PLANNED | Not yet drafted |
| **AU-001** | Audio & Music Direction Bible | 3 | PLANNED | Not yet drafted |
| **SV-001** | Save System | 3 | PLANNED | Not yet drafted |
| **AX-001** | Accessibility | 3 | PLANNED | Not yet drafted |
| **IS-001** | Input Settings | 3 | PLANNED | Not yet drafted |
| **IA-001** | Implementation Architecture | 4 | REVIEW | [docs/IMPLEMENTATION_ARCHITECTURE_SPECIFICATION.md](file:///c:/Users/HP/Documents/Underhallow/docs/IMPLEMENTATION_ARCHITECTURE_SPECIFICATION.md) |
| **PP-001** | Production Plan & Vertical Slice Roadmap | 4 | APPROVED | [docs/PRODUCTION_PLAN.md](file:///c:/Users/HP/Documents/Underhallow/docs/PRODUCTION_PLAN.md) |
| **QA-001** | QA & Testing Specification | 4 | PLANNED | Not yet drafted |

---

# 29. Recommended Build Order

- **Phase 1 — Authority:** North Star (`NS-001`), Creative Direction (`CD-001`), Art Direction Bible (`AD-001`), World Bible (`WB-001`), Agent Constitution (`AC-001`), Master Specification Index (`MSI-001`), Specification Reconciliation (`SR-001`).
- **Phase 2 — Foundation Architecture & Creative Foundations:** Foundation Specification (`FS-001`), Engine & Technical Architecture (`ETA-001`), Core Gameplay (`CG-001`), Player Control (`PC-001`), World & Map Architecture (`WM-001`), Narrative Bible (`NB-001`), Character Bible (`CB-001`), Biome & Environment Bible (`BE-001`), Creature & Wildlife Bible (`CW-001`), Mystery & Lore Architecture (`ML-001`).
  - *Upcoming Creative Foundations:* Narrative Content Framework (`NC-001`).
- **Phase 3 — Player, World & Social Systems:** Main Island Design (`MI-001`), Personal Island Design (`PI-001`), Player Progression (`PR-001`), Farming (`FB-001`), Livestock & Animal Husbandry (`LA-001`), Hunting & Combat (`HU-001`), Fishing (`FI-001`), Foraging & Wild Resources (`FR-001`), Resource Gathering, Forestry & Mining (`RG-001`), Cooking & Food (`CK-001`), Building & Construction (`BI-001`), Inventory/Items/Tools/Crafting (`II-001`), Exploration & Secrets (`EX-001`), Transportation & Travel (`TR-001`), Time & Simulation (`TS-001`), Weather & Environmental Systems (`WE-001`), Multiplayer & Social Systems (`MS-001`).
- **Phase 4 — World Population & Communities:** NPCs, Dialogue & Quests (`NQ-001`), Story/Narrative Architecture (`ST-001`), Regional World Specifications (`RW-001`), Town Social Structure (`TC-001`), Major NPC / Character Roster (`CR-001`), World Events & Festival Direction (`EV-001`).
- **Phase 5 — Meta Systems:** Economy (`EC-001`), Save System (`SV-001`), UI/UX (`UI-001`), Audio & Music Direction Bible (`AU-001`), Accessibility (`AX-001`), Input/Settings (`IS-001`).
- **Phase 6 — Implementation Governance & Execution:** Implementation Specs (`IA-001`), Production Plan & Roadmap (`PP-001`), QA & Testing (`QA-001`), Performance, Production Readiness.

---

# 30. Documentation Dependency Principle

A specification should only be considered production-ready when its major dependencies are sufficiently defined.

### 30.1 Level 2 Core System Dependency Map

The following authoritative dependency mapping establishes the inter-system relationships across Underhallow's Level 2 gameplay systems:

```text
MI-001 (Main Island)
 ├── RG-001 (Resource Gathering, Forestry & Mining)
 ├── FR-001 (Foraging & Wild Resources)
 ├── WE-001 (Weather & Environmental Systems)
 └── TR-001 (Transportation & Travel)

FB-001 (Farming)
 ├── LA-001 (Livestock & Animal Husbandry)
 └── CK-001 (Cooking & Food)

RG-001 (Resource Gathering, Forestry & Mining)
 ├── BI-001 (Building & Construction)
 ├── II-001 (Inventory, Items, Tools & Crafting)
 ├── EC-001 (Economy)
 └── EX-001 (Exploration & Secrets)

FR-001 (Foraging & Wild Resources)
 ├── CK-001 (Cooking & Food)
 ├── EX-001 (Exploration & Secrets)
 └── EC-001 (Economy)

LA-001 (Livestock & Animal Husbandry)
 ├── FB-001 (Farming)
 ├── BI-001 (Building & Construction)
 ├── CK-001 (Cooking & Food)
 └── EC-001 (Economy)

WE-001 (Weather & Environmental Systems)
 ├── TS-001 (Time, Day/Night & Simulation)
 ├── FB-001 (Farming)
 ├── LA-001 (Livestock & Animal Husbandry)
 ├── FI-001 (Fishing)
 └── EX-001 (Exploration & Secrets)

TR-001 (Transportation & Travel)
 ├── WM-001 (World & Map Architecture)
 ├── MI-001 (Main Island Design)
 ├── PI-001 (Personal Island Design)
 └── MS-001 (Multiplayer & Social Systems)
```

---

### 30.2 Authoritative Creative & World Hierarchy Graph

The creative specifications form a coherent, top-down semantic chain. Downstream specifications inherit rules without duplicating or overriding upstream authorities:

```text
NS-001 (North Star — Vision & Immutable Principles)
 ├── CD-001 (Creative Direction — 65% Cozy / 35% Adventure, Creative Invariant 11)
 │    ├── AD-001 (Art Direction Bible — Fixed Isometric, Pixel Art, Invariant 12)
 │    │    ├── BE-001 (Biome & Environment Bible V1.1 — 16 Environmental Laws, 6-Tier Hierarchy, Invariant 19)
 │    │    ├── CW-001 (Creature & Wildlife Bible — 16 Wildlife Laws, Taxonomy, Invariant 20)
 │    │    └── AU-001 (Audio & Music Direction Bible — Planned)
 │    │
 │    └── WB-001 (World Bible — Three-Tier Balance, Ancient History, Invariant 13)
 │         ├── NB-001 (Narrative Bible — Mystery Progression, Ten Narrative Laws)
 │         │    ├── CB-001 (Character Bible — 30–50 NPCs, Living Memory, Invariant 15)
 │         │    │    ├── TC-001 (Town Social Structure — Planned)
 │         │    │    └── CR-001 (Major NPC / Character Roster — Planned)
 │         │    ├── ML-001 (Mystery & Lore Architecture — 20 Laws, 5 Layers, Invariant 21)
 │         │    └── NC-001 (Narrative Content Framework — NEXT CREATIVE SPEC)
 │         │
 │         ├── WM-001 (World & Map Architecture — Coordinate Geometry, Isometric Tiles)
 │         ├── MI-001 (Main Island Design — Shared World, 7–9 Regions, Invariant 16)
 │         │    ├── RW-001 (Regional World Specifications — Planned)
 │         │    └── EV-001 (World Events & Festival Direction — Planned)
 │         └── PI-001 (Personal Island Design — Sanctuary, Homestead, Invariant 18)
 │              └── [Specializes BI-001 Building & Construction System]
```

---

### 30.3 Cross-Cutting Architecture & Multiplayer Dependency Map

Technical architecture operates horizontally across gameplay systems to enforce server authority, data determinism, and persistent multiplayer safety:

```text
ETA-001 (Engine & Technical Architecture)
 ├── FS-001 (Foundation Specification)
 ├── SR-001 (Specification Reconciliation)
 ├── IA-001 (Implementation Architecture — GDScript, GameState/PlayerState, InputActions)
 ├── PP-001 (Production Plan & Vertical Slice Milestones)
 └── MS-001 (Multiplayer & Social Systems — Server Authority, Parties, Guilds)
      ├── BI-001 (Building & Construction — Command → Validation → Mutation → Event)
      ├── FB-001 (Farming — Grid Authority, Crop State, Tick Advancement)
      ├── HU-001 (Hunting & Combat — Non-lethal Defeat, Expedition Boundaries)
      └── TR-001 (Transportation & Travel — Seamless Zone Transitions, Boat System)
```

---

# 31. Change Propagation

When an authoritative specification changes, dependent specifications must be reviewed.

---

# 32. Specification Completeness

Required sections: Purpose, Design goals, Scope, Non-goals, Core rules, Player-facing behavior, System behavior, Dependencies, Data/state requirements, Edge cases, Failure cases, Integration requirements, UX requirements, Technical requirements, QA requirements, Open questions, Decision history, Version history.

---

# 33. What Agents Must Never Do

Agents must not:
* silently override locked specifications;
* create conflicting versions of the same rule;
* treat chat history as higher authority than the documented system;
* promote experiments into production without specification approval;
* make cross-system changes without checking dependencies;
* delete authoritative historical decisions;
* resolve specification conflicts by personal preference;
* introduce major systems simply because they appear technically convenient.

---

# 34. What Agents Are Encouraged to Do

Agents should identify contradictions, missing requirements, propose improvements, identify technical risks, suggest prototypes, and request clarification when ambiguous.

---

# 35. Master Specification Workflow

1. Identify system $\rightarrow$ 2. Register in MSI $\rightarrow$ 3. Identify parents $\rightarrow$ 4. Ask unresolved questions $\rightarrow$ 5. Draft Spec $\rightarrow$ 6. Review dependencies $\rightarrow$ 7. Prototype $\rightarrow$ 8. Refine spec $\rightarrow$ 9. Resolve open questions $\rightarrow$ 10. Lock spec $\rightarrow$ 11. Implementation tasks $\rightarrow$ 12. Implement $\rightarrow$ 13. QA $\rightarrow$ 14. Production Ready.

---

# 36. Master Specification as the Project Control Layer

The MSI is the primary navigation and governance layer for humans and AI agents.

---

# 37. Final Governance Rule

> **No important decision should exist only in someone's memory.**

---

# 38. Current Roadmap Status

- **NS-001 — North Star V1.0:** Locked project authority established at [`docs/NORTH_STAR.md`](file:///c:/Users/HP/Documents/Underhallow/docs/NORTH_STAR.md) (defines executive definition, creative vision, Windows PC platform per SR-001, single-player-first/multiplayer-native, and immutable design principles).
- **CD-001 — Creative Direction Specification V1.0:** Canonical Creative Foundation established and locked at [`docs/CREATIVE_DIRECTION.md`](file:///c:/Users/HP/Documents/Underhallow/docs/CREATIVE_DIRECTION.md) (defines 65% Cozy / 35% Adventure balance, 50-hour feeling, slow-burn mystery, handcrafted SNES-era retro foundation + modern detail art standard, readability vs atmosphere parity, house evolution, and Creative Invariant 11: *"Never let the mystery destroy the cozy life. Never let the cozy life erase the mystery."*).
- **AD-001 — Art Direction Bible V1.0:** Canonical Art Direction Specification established and locked at [`docs/ART_DIRECTION_BIBLE.md`](file:///c:/Users/HP/Documents/Underhallow/docs/ART_DIRECTION_BIBLE.md) (defines fixed isometric perspective, no camera rotation in V1.0, 16-bit foundation with modern pixel-art execution, cozy medieval-fantasy architecture, mixed architectural age, 3-tier house evolution, tiered NPC animations, subtle mystery creature language, handcrafted UI/typography/icons, six visual signatures, and the Underhallow visual evaluation rule).
- **WB-001 — World Bible V1.0:** Canonical World-Building Foundation established and locked at [`docs/WORLD_BIBLE.md`](file:///c:/Users/HP/Documents/Underhallow/docs/WORLD_BIBLE.md) (defines island geography, town and landmarks, layered history, ancient civilization and disappearance, 8-stage emotional arc, reality-breaking places, subtle strange wildlife, grandparent inheritance, personal island sanctuary, non-forced hunting processing, and the core philosophy: *"The player comes to love Underhallow before they understand it"*).
- **AC-001 — Agent Constitution V1.0:** Development governance baseline locked at [`docs/AGENT_CONSTITUTION.md`](file:///c:/Users/HP/Documents/Underhallow/docs/AGENT_CONSTITUTION.md) (defines agent roles, domain whitelists, Definition of Done, architecture plan requirements, and code modification rules).
- **SR-001 — Specification Reconciliation V1.0:** Approved baseline established at [`docs/SPECIFICATION_RECONCILIATION.md`](file:///c:/Users/HP/Documents/Underhallow/docs/SPECIFICATION_RECONCILIATION.md) (reconciled platform to Windows PC, engine to Godot, mode to single-player-first/multiplayer-native, added Guild Islands, fixed camera orientation, and updated MSI governance).
- **MSI-001 — Master Specification Index & Build Governance V1.1:** Approved baseline established at [`docs/MASTER_SPECIFICATION_INDEX.md`](file:///c:/Users/HP/Documents/Underhallow/docs/MASTER_SPECIFICATION_INDEX.md) (reconciled master registry, authority levels, reading matrices, and roadmap).
- **FS-001 — Foundation Specification V1.0:** Approved foundation product definition established at [`docs/FOUNDATION_SPECIFICATION.md`](file:///c:/Users/HP/Documents/Underhallow/docs/FOUNDATION_SPECIFICATION.md) (defines comprehensive system boundaries, core player loops, non-lethal defeat, no stamina, and product structure).
- **ETA-001 — Engine & Technical Architecture Specification V1:** Approved foundation architecture established at [`docs/ENGINE_TECHNICAL_ARCHITECTURE_SPECIFICATION.md`](file:///c:/Users/HP/Documents/Underhallow/docs/ENGINE_TECHNICAL_ARCHITECTURE_SPECIFICATION.md) (supersedes initial browser/Phaser baseline `TA-001`; establishes Godot + GDScript + Dedicated Game Servers + Supabase for Windows PC).
- **CG-001 — Core Gameplay Systems Specification V1.0:** Locked gameplay foundation established at [`docs/CORE_GAMEPLAY_SYSTEMS_SPECIFICATION.md`](file:///c:/Users/HP/Documents/Underhallow/docs/CORE_GAMEPLAY_SYSTEMS_SPECIFICATION.md) (defines primary gameplay loops, progression pillars, player agency, and gameplay invariants).
- **PC-001 — Player Control, Movement & Interaction Specification V1.0:** Approved foundation specification established at [`docs/PLAYER_CONTROL_MOVEMENT_INTERACTION_SPECIFICATION.md`](docs/PLAYER_CONTROL_MOVEMENT_INTERACTION_SPECIFICATION.md) (defines continuous 2D locomotion, diagonal normalization, strict no-sprint/no-stamina invariant, contextual resolution between Left Mouse Button and E, canonical interaction targeting hierarchy, 8-directional facing retention, action commitment matrix, mutually exclusive control states, fixed isometric camera with smooth tracking/zoom, footprint-based ground collision, non-lethal defeat expedition flow, and clean separation between player-facing control contract and ETA-001 technical implementation).
- **WM-001 — World & Map Architecture Specification V1.0:** Approved foundation specification established at [`docs/WORLD_MAP_ARCHITECTURE_SPECIFICATION.md`](docs/WORLD_MAP_ARCHITECTURE_SPECIFICATION.md) (defines canonical V1 two-island structure [Main Island and Personal Island], continuous primary landmass, medium world scale with travel-time constraints, layered natural gating, constrained Personal Island terrain editing, connected grid expansion, selective authored persistence, restrained verticality, and physical boat/dock transitions; Guild Islands deferred).
- **NB-001 — Narrative Bible V1.0:** Foundation narrative specification established at [`docs/NARRATIVE_BIBLE.md`](file:///c:/Users/HP/Documents/Underhallow/docs/NARRATIVE_BIBLE.md) (defines 6-phase mystery curve, player arrival and vague past, grandparent legacy, NPC living history, the Ten Narrative Laws, ending philosophy, and core narrative balance: *"Cozy surface. Mystical middle. Deep mystery underneath"*).
- **CB-001 — Character Bible V1.0:** Foundation character specification established at [`docs/CHARACTER_BIBLE.md`](file:///c:/Users/HP/Documents/Underhallow/docs/CHARACTER_BIBLE.md) (defines 30–50 memorable residents, 3-tier depth structure, independent routines, believable flaws, fragmented mystery knowledge, imperfect living memory, romance rules, and core philosophy: *"Underhallow's characters should feel like people who have their own lives, histories, and reasons for staying here rather than NPCs who exist only for the player"*).
- **BE-001 — Biome & Environment Bible V1.1:** Foundation specification established at [`docs/BIOME_ENVIRONMENT_BIBLE.md`](file:///c:/Users/HP/Documents/Underhallow/docs/BIOME_ENVIRONMENT_BIBLE.md) (defines 16 Canonical Environmental Laws, 6-tier hierarchy: Family → Biome → Sub-Biome → Ecotone → Micro-Environment → Landmark, 7-layer design model, Gameplay Affordance Matrix, 4-tier Mystery Density Model Level 0–3, 5-tier Landmark Hierarchy, "The Wrong Thing" principle, environmental memory, 13 core environmental families, ordinary vs strange balance, and Invariant 19: *"Underhallow's environments should feel like places, not levels. Beautiful first. Strange second"*).
- **CW-001 — Creature & Wildlife Bible V1.0:** Foundation specification established at [`docs/CREATURE_WILDLIFE_BIBLE.md`](file:///c:/Users/HP/Documents/Underhallow/docs/CREATURE_WILDLIFE_BIBLE.md) (defines 16 Core Wildlife Laws, 4-tier spectrum: Ordinary → Notable → Strange → Impossible, 10 creature taxonomies: Birds, Mammals, Reptiles, Amphibians, Fish, Insects, Domestic, Livestock, Strange, Impossible, hunting philosophy with optional processing and raw resource trading, observation as a valid non-extractive interaction, believable behavioral abstraction, field journal/bestiary framework, and Invariant 20: *"Wildlife should feel like the island has a life of its own, whether or not the player is there"*).
- **ML-001 — Mystery & Lore Architecture Specification V1.0:** Foundation specification established at [`docs/MYSTERY_LORE_ARCHITECTURE_SPECIFICATION.md`](file:///c:/Users/HP/Documents/Underhallow/docs/MYSTERY_LORE_ARCHITECTURE_SPECIFICATION.md) (defines 20 Core Mystery Laws, 5-layer mystery architecture: Ordinary, Local, Historical, Central Truth, Permanent Unknown, 5–8 major mystery families, 7-stage revelation progression, Grandparent's morally difficult decision, redundant clue paths, and Invariant 21: *"The mystery should make the world deeper, not make the world feel like a puzzle box. Understanding history is not the same thing as understanding Underhallow itself"*).
- **MI-001 — Main Island Design Specification V1.0:** Draft design baseline established at [`docs/MAIN_ISLAND_DESIGN_SPECIFICATION.md`](file:///c:/Users/HP/Documents/Underhallow/docs/MAIN_ISLAND_DESIGN_SPECIFICATION.md) (defines communal world identity, 7–9 major regional frameworks, ~50% early game accessibility, natural transitions, landmark navigation, intentional empty space/wilderness, non-lethal defeat returning to Personal Island, non-forced hunting processing, layered historical depth, and Invariant 16: *"The main island of Underhallow should feel like a place you could spend years getting to know rather than a map you are expected to complete"*).
- **PI-001 — Personal Island Design Specification V1.0:** Draft design baseline established at [`docs/PERSONAL_ISLAND_DESIGN_SPECIFICATION.md`](file:///c:/Users/HP/Documents/Underhallow/docs/PERSONAL_ISLAND_DESIGN_SPECIFICATION.md) (defines private sanctuary & emotional destination, functional inherited starting cottage with undeveloped land, gradual grid-based area expansion, organic 3-stage house evolution, balanced efficiency vs. expression, preserved wilderness without mandatory optimization, ecological wildlife attraction, persistent authoritative state, and Invariant 18: *"The Personal Island is where the player turns progress into place"*).
- **PR-001 — Player Progression Specification V1.0:** Drafted and established at [`docs/PLAYER_PROGRESSION_SPECIFICATION.md`](file:///c:/Users/HP/Documents/Underhallow/docs/PLAYER_PROGRESSION_SPECIFICATION.md).
- **FB-001 — Farming System Specification V1.0:** Drafted and established at [`docs/FARMING_SYSTEM_SPECIFICATION.md`](file:///c:/Users/HP/Documents/Underhallow/docs/FARMING_SYSTEM_SPECIFICATION.md).
- **HU-001 — Hunting & Combat System Specification V1.0:** Drafted and established at [`docs/HUNTING_COMBAT_SYSTEM_SPECIFICATION.md`](file:///c:/Users/HP/Documents/Underhallow/docs/HUNTING_COMBAT_SYSTEM_SPECIFICATION.md).
- **MS-001 — Multiplayer & Social Systems Specification V1.0:** Drafted and established at [`docs/MULTIPLAYER_SOCIAL_SYSTEMS_SPECIFICATION.md`](file:///c:/Users/HP/Documents/Underhallow/docs/MULTIPLAYER_SOCIAL_SYSTEMS_SPECIFICATION.md).
- **BI-001 — Building & Construction System Specification V1.0:** Drafted and established at [`docs/BUILDING_CONSTRUCTION_SYSTEM_SPECIFICATION.md`](file:///c:/Users/HP/Documents/Underhallow/docs/BUILDING_CONSTRUCTION_SYSTEM_SPECIFICATION.md) (defines universal construction framework, hybrid placement model with structured snapping & expressive placement, server authority over persistent state via Command → Validation → Mutation → Event, non-tedious construction duration, generous material recovery on demolition, soft builder specialization, distinct property authority contexts between Personal and Guild islands, data-driven construction definitions, and Invariant 17).
- **IA-001 — Implementation Architecture Specification V1.1:** Advanced to `REVIEW` status at [`docs/IMPLEMENTATION_ARCHITECTURE_SPECIFICATION.md`](file:///c:/Users/HP/Documents/Underhallow/docs/IMPLEMENTATION_ARCHITECTURE_SPECIFICATION.md) (defines decision classification framework, Godot 4.x + GDScript project structure, domain state boundaries, input actions, GameTime simulation, persistence abstraction, V0.1 dependency sequence, and Vertical Slice V0.1 "The First Day" scope).
- **PP-001 — Production Plan & Vertical Slice Roadmap V1.0:** Approved baseline implementation roadmap established at [`docs/PRODUCTION_PLAN.md`](file:///c:/Users/HP/Documents/Underhallow/docs/PRODUCTION_PLAN.md) (defines master phased progression from Phase 0 toolchain to Phase 7 production polish, vertical slice gates, and milestone acceptance criteria).

---

### 38.1 Next Planned Creative Specification

The next authoritative specification in the creative direction roadmap is:

> **NC-001 — Narrative Content Framework V1.0**

This document will define how narrative, lore, and mystery content are translated into concrete player experiences: quest archetypes, narrative beats, environmental storytelling rules, character dialogue structures, branching agency, and revelation delivery.

---

### 38.2 Sequenced Creative Roadmap

Following `ML-001`, creative and world authoring proceeds in the following sequential order:

1. **NC-001 — Narrative Content Framework V1.0** *(Next Specification)*
2. **RW-001 — Regional World Specifications V1.0**
3. **TC-001 — Town Social Structure Specification V1.0**
4. **CR-001 — Major NPC / Character Roster V1.0**
5. **EV-001 — World Events & Festival Direction V1.0**
6. **AU-001 — Audio & Music Direction Bible V1.0**

---

### 38.3 Planned Level 2 Gameplay Specifications

Following foundational creative definitions, remaining Level 2 gameplay specifications will be drafted per dependency readiness:

* **II-001 — Inventory, Items, Tools & Crafting Specification V1.0**
* **TS-001 — Time, Day/Night & Simulation Specification V1.0**
* **EX-001 — Exploration & Secrets Specification V1.0**
* **RG-001 — Resource Gathering, Forestry & Mining Specification V1.0**
* **FR-001 — Foraging & Wild Resources Specification V1.0**
* **LA-001 — Livestock & Animal Husbandry Specification V1.0**
* **CK-001 — Cooking & Food Specification V1.0**
* **WE-001 — Weather & Environmental Systems Specification V1.0**
* **TR-001 — Transportation & Travel Specification V1.0**
* **FI-001 — Fishing Specification V1.0**
* **NQ-001 — NPCs, Dialogue & Quests Specification V1.0**
* **EC-001 — Economy Specification V1.0**
* **ST-001 — Story & Narrative Architecture Specification V1.0**

---

# 39. Revision & Reconciliation History

| Version | Date | Status | Author | Summary of Changes | Authority & Rationale |
| :--- | :--- | :---: | :--- | :--- | :--- |
| **V1.0** | 2026-09-14 | DRAFT | System Architecture | Initial creation of Master Specification Index, build governance rules, and registry baseline. | Initial governance standard. |
| **V1.1** | 2026-09-16 | APPROVED | Gemini / Project Governance | Comprehensive MSI Reconciliation Pass. Reconciled complete specification library against current repository state; restored missing Level 1 and Level 4 specifications (`FS-001`, `PP-001`, `MSI-001`); registered complete creative pipeline with `BE-001` as next specification; established Section 8.1 Agent Mandatory Reading Matrices; integrated Section 30.2 Creative & World Hierarchy Graph; audited camera controls across all specs (fixed isometric, zoomable, no V1 rotation); no underlying game design decisions altered. | Approved baseline per MSI Reconciliation Pass. |
| **V1.2** | 2026-09-16 | APPROVED | Gemini / Project Governance | Integrated Biome & Environment Bible V1.0 (`BE-001`) into Level 1 Foundation registry, updated reading matrices, build order, and creative hierarchy tree; advanced creative roadmap to `CW-001` (Creature & Wildlife Bible V1.0). | Integrated BE-001 foundation baseline. |
| **V1.3** | 2026-09-16 | APPROVED | Gemini / Project Governance | Reconciled BE-001 to V1.1 Specification Pass (added 16 Canonical Environmental Laws, 6-tier Environmental Hierarchy, Gameplay Affordance Matrix, and 4-tier Mystery Density Model); acknowledged founder approval of PC-001 (Player Control, Movement & Interaction). | BE-001 V1.1 Specification Pass & PC-001 approval reconciliation. |
| **V1.4** | 2026-09-16 | APPROVED | Gemini / Project Governance | Integrated Creature & Wildlife Bible V1.0 (`CW-001`) into Level 1 Foundation registry, reading matrices, build order, and creative hierarchy tree; codified Invariant 20; advanced creative roadmap to `ML-001` (Mystery & Lore Architecture V1.0). | Integrated CW-001 foundation baseline. |
| **V1.5** | 2026-09-16 | APPROVED | Gemini / Project Governance | Integrated Mystery & Lore Architecture Specification V1.0 (`ML-001`) into Level 1 Foundation registry, reading matrices, build order, and creative hierarchy tree; codified Invariant 21; acknowledged founder approval of WM-001 (World & Map Architecture); advanced creative roadmap to `NC-001` (Narrative Content Framework V1.0). | Integrated ML-001 foundation baseline & WM-001 approval reconciliation. |
