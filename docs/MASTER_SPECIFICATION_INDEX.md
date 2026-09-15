# UNDERHALLOW

## Master Specification Index & Build Governance

### Version 1.0 — Draft

**Document ID:** MSI-001  
**Status:** DRAFT  
**Authority Level:** Project Governance  
**Applies To:** All Underhallow design, specification, implementation, testing, and agent workflows  

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

1. **North Star**
2. **Foundation Specifications**
3. **System Specifications**
4. **Implementation Specifications**
5. **Agent Task Specifications**

An agent must not resolve an authority conflict by simply choosing whichever document is more convenient.

---

### 2.3 Human Authority Through the Master Specification

The ultimate project authority is the human project owner.

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

Underhallow documentation is divided into four primary levels.

## Level 0 — Project Authority

These documents establish the fundamental identity and rules of Underhallow.

Current documents include:

* **North Star V1.0** (`NS-001`)
* **Creative Direction V1.0** (`CD-001`)
* **Art Direction Bible V1.0** (`AD-001`)
* **World Bible V1.0** (`WB-001`)
* **Agent Constitution V1.0** (`AC-001`)

These documents have the highest project-level authority.

---

## Level 1 — Foundation Specifications

Foundation specifications define the structural rules of the game.

Current documents include:

* **Engine & Technical Architecture Specification V1** (`ETA-001`) — Approved Foundation (supersedes `TA-001`)
* **Core Gameplay Specifications V1.0** (`CG-001`)
* **Player Control, Movement & Interaction Specification V1.0** (`PC-001`)
* **World & Map Architecture Specification V1.0** (`WM-001`)
* **Narrative Bible V1.0** (`NB-001`)
* **Character Bible V1.0** (`CB-001`)

Additional foundation documents may be added when necessary.

---

## Level 2 — Gameplay System Specifications

These define individual major game systems.

Planned examples include:

* Player Progression (`PR-001`)
* Farming (`FB-001`)
* Hunting & Combat (`HU-001`)
* Multiplayer & Social Systems (`MS-001`)
* Building & Personal Island (`BI-001`)
* NPCs, Dialogue & Quests (`NQ-001`)
* Exploration & Secrets (`EX-001`)
* Inventory, Items, Tools & Crafting (`II-001`)
* Fishing (`FI-001`)
* Time, Day/Night & Simulation (`TS-001`)
* Economy (`EC-001`)
* Story/Narrative Architecture (`ST-001`)

---

## Level 3 — Supporting Systems

These define systems that support gameplay but do not necessarily determine the game's primary fantasy.

Examples include:

* UI/UX (`UI-001`)
* Audio (`AU-001`)
* Save System (`SV-001`)
* Settings (`IS-001`)
* Accessibility (`AX-001`)
* Input Configuration
* Notifications
* Loading/Transition Systems
* Performance
* Analytics
* Error Handling

---

## Level 4 — Implementation Specifications

These documents translate approved system designs into implementation-level requirements.

Examples:

* Database schemas
* API contracts
* Component architecture
* Data models
* Save-state structures
* Asset pipelines
* State machines
* Technical interfaces
* Performance budgets
* Testing specifications (`QA-001`)

---

# 4. Document Registry

Every major specification receives a permanent Document ID.

The recommended format is:

| Prefix | Document Type |
| :--- | :--- |
| `NS` | North Star |
| `CD` | Creative Direction |
| `AD` | Art Direction Bible |
| `WB` | World Bible |
| `AC` | Agent Constitution |
| `SR` | Specification Reconciliation |
| `ETA` | Engine & Technical Architecture (`TA` superseded) |
| `CG` | Core Gameplay |
| `PC` | Player Control |
| `WM` | World & Map |
| `NB` | Narrative Bible |
| `CB` | Character Bible |
| `PR` | Player Progression |
| `FB` | Farming |
| `HU` | Hunting & Combat |
| `MS` | Multiplayer & Social Systems |
| `BI` | Building & Personal Island |
| `NQ` | NPC / Quest |
| `EX` | Exploration |
| `II` | Inventory / Items |
| `FI` | Fishing |
| `TS` | Time / Simulation |
| `EC` | Economy |
| `ST` | Story / Narrative |
| `UI` | UI / UX |
| `AU` | Audio |
| `SV` | Save System |
| `AX` | Accessibility |
| `IS` | Input Settings |
| `QA` | QA & Testing |
| `IA` | Implementation Architecture |

Each document receives a permanent numeric identifier. Example: `WM-001 — World & Map Architecture Specification`.  
The ID remains permanent even if the document is revised.

---

# 5. Versioning

Underhallow uses semantic document versioning.

### Minor Version
A minor version represents clarification, refinement, or limited changes that do not fundamentally alter the system.  
Example: `V1.0 → V1.1`

### Major Version
A major version represents a fundamental design change.  
Example: `V1.1 → V2.0`  
Major changes may require dependency review and revalidation of affected systems.

---

# 6. Document Statuses

Every specification must have one of the following statuses:

* **PLANNED:** The document is identified in the roadmap but drafting has not yet begun. Implementation must not begin on un-drafted specifications.
* **DRAFT:** The document is actively being designed. Its decisions are not yet fully authoritative.
* **REVIEW:** The document is substantially complete and undergoing review. Production implementation should not begin unless explicitly authorized.
* **APPROVED:** The document has been formally reviewed and approved as authoritative baseline architecture, ready to guide system design and implementation.
* **LOCKED:** The document is authoritative. Agents must follow it unless an approved change process modifies it.
* **DEPRECATED:** The document has been intentionally retired. It remains available for historical reference but must not guide new implementation.
* **SUPERSEDED:** The document has been replaced by a newer specification. The replacement document must be identified.

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

Agents are not expected to blindly read the entire documentation library for every task. Instead, the MSI provides the dependency path required for the task.

---

# 8. Parent Specification Requirement

Before modifying a system, an agent must read the specifications directly relevant to that system and the necessary parent specifications identified by the MSI.

For example:
> Farming Agent → Farming Specification → Core Gameplay → Player Control where relevant → Technical Architecture where relevant.

This prevents agents from making technically correct changes that violate higher-level game design.

---

# 9. Task Specifications

Not every task requires its own formal document.

Task specifications are required for **complex, high-risk, cross-system, or architectural work**.  
Simple implementation tasks may operate directly from the relevant locked specification.

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

# 28. Initial Underhallow Registry

| ID | Specification | Level | Status | File Link |
| :--- | :--- | :---: | :--- | :--- |
| **NS-001** | North Star | 0 | LOCKED | [docs/NORTH_STAR.md](file:///c:/Users/HP/Documents/Underhallow/docs/NORTH_STAR.md) |
| **CD-001** | Creative Direction | 0 | LOCKED | [docs/CREATIVE_DIRECTION.md](file:///c:/Users/HP/Documents/Underhallow/docs/CREATIVE_DIRECTION.md) |
| **AD-001** | Art Direction Bible | 0 | LOCKED | [docs/ART_DIRECTION_BIBLE.md](file:///c:/Users/HP/Documents/Underhallow/docs/ART_DIRECTION_BIBLE.md) |
| **WB-001** | World Bible | 0 | LOCKED | [docs/WORLD_BIBLE.md](file:///c:/Users/HP/Documents/Underhallow/docs/WORLD_BIBLE.md) |
| **AC-001** | Agent Constitution | 0 | LOCKED | [docs/AGENT_CONSTITUTION.md](file:///c:/Users/HP/Documents/Underhallow/docs/AGENT_CONSTITUTION.md) |
| **SR-001** | Specification Reconciliation | 0 | APPROVED | [docs/SPECIFICATION_RECONCILIATION.md](file:///c:/Users/HP/Documents/Underhallow/docs/SPECIFICATION_RECONCILIATION.md) |
| **ETA-001** | Engine & Technical Architecture | 1 | APPROVED | [docs/ENGINE_TECHNICAL_ARCHITECTURE_SPECIFICATION.md](file:///c:/Users/HP/Documents/Underhallow/docs/ENGINE_TECHNICAL_ARCHITECTURE_SPECIFICATION.md) |
| **TA-001** | Technical Architecture (Browser/Phaser Prototype Baseline) | 1 | SUPERSEDED | [docs/TECHNICAL_ARCHITECTURE.md](file:///c:/Users/HP/Documents/Underhallow/docs/TECHNICAL_ARCHITECTURE.md) |
| **CG-001** | Core Gameplay | 1 | LOCKED | [docs/CORE_GAMEPLAY_SYSTEMS_SPECIFICATION.md](file:///c:/Users/HP/Documents/Underhallow/docs/CORE_GAMEPLAY_SYSTEMS_SPECIFICATION.md) |
| **PC-001** | Player Control, Movement & Interaction | 1 | DRAFT | [docs/PLAYER_CONTROL_MOVEMENT_INTERACTION_SPECIFICATION.md](file:///c:/Users/HP/Documents/Underhallow/docs/PLAYER_CONTROL_MOVEMENT_INTERACTION_SPECIFICATION.md) |
| **WM-001** | World & Map Architecture | 1 | DRAFT | [docs/WORLD_MAP_ARCHITECTURE_SPECIFICATION.md](file:///c:/Users/HP/Documents/Underhallow/docs/WORLD_MAP_ARCHITECTURE_SPECIFICATION.md) |
| **NB-001** | Narrative Bible | 1 | DRAFT | [docs/NARRATIVE_BIBLE.md](file:///c:/Users/HP/Documents/Underhallow/docs/NARRATIVE_BIBLE.md) |
| **CB-001** | Character Bible | 1 | DRAFT | [docs/CHARACTER_BIBLE.md](file:///c:/Users/HP/Documents/Underhallow/docs/CHARACTER_BIBLE.md) |
| **PR-001** | Player Progression | 2 | DRAFT | [docs/PLAYER_PROGRESSION_SPECIFICATION.md](file:///c:/Users/HP/Documents/Underhallow/docs/PLAYER_PROGRESSION_SPECIFICATION.md) |
| **FB-001** | Farming | 2 | DRAFT | [docs/FARMING_SYSTEM_SPECIFICATION.md](file:///c:/Users/HP/Documents/Underhallow/docs/FARMING_SYSTEM_SPECIFICATION.md) |
| **HU-001** | Hunting & Combat | 2 | DRAFT | [docs/HUNTING_COMBAT_SYSTEM_SPECIFICATION.md](file:///c:/Users/HP/Documents/Underhallow/docs/HUNTING_COMBAT_SYSTEM_SPECIFICATION.md) |
| **MS-001** | Multiplayer & Social Systems | 2 | DRAFT | [docs/MULTIPLAYER_SOCIAL_SYSTEMS_SPECIFICATION.md](file:///c:/Users/HP/Documents/Underhallow/docs/MULTIPLAYER_SOCIAL_SYSTEMS_SPECIFICATION.md) |
| **BI-001** | Building & Personal Island | 2 | PLANNED | Not yet drafted |
| **NQ-001** | NPC, Dialogue & Quest | 2 | PLANNED | Not yet drafted |
| **EX-001** | Exploration & Secrets | 2 | PLANNED | Not yet drafted |
| **II-001** | Inventory, Items, Tools & Crafting | 2 | PLANNED | Not yet drafted |
| **FI-001** | Fishing | 2 | PLANNED | Not yet drafted |
| **TS-001** | Time, Day/Night & Simulation | 2 | PLANNED | Not yet drafted |
| **EC-001** | Economy | 2 | PLANNED | Not yet drafted |
| **ST-001** | Story & Narrative Architecture | 2 | PLANNED | Not yet drafted |
| **UI-001** | UI / UX | 3 | PLANNED | Not yet drafted |
| **AU-001** | Audio | 3 | PLANNED | Not yet drafted |
| **SV-001** | Save System | 3 | PLANNED | Not yet drafted |
| **AX-001** | Accessibility | 3 | PLANNED | Not yet drafted |
| **IS-001** | Input Settings | 3 | PLANNED | Not yet drafted |
| **IA-001** | Implementation Architecture | 4 | REVIEW | [docs/IMPLEMENTATION_ARCHITECTURE_SPECIFICATION.md](file:///c:/Users/HP/Documents/Underhallow/docs/IMPLEMENTATION_ARCHITECTURE_SPECIFICATION.md) |
| **QA-001** | QA & Testing Specification | 4 | PLANNED | Not yet drafted |

---

# 29. Recommended Build Order

- **Phase 1 — Authority:** North Star (`NS-001`), Creative Direction (`CD-001`), Art Direction Bible (`AD-001`), World Bible (`WB-001`), Agent Constitution (`AC-001`), Master Specification Index (`MSI-001`), Specification Reconciliation (`SR-001`).
- **Phase 2 — Foundation:** Engine & Technical Architecture (`ETA-001`), Core Gameplay (`CG-001`), Player Control (`PC-001`), World & Map Architecture (`WM-001`), Narrative Bible (`NB-001`), Character Bible (`CB-001`).
- **Phase 3 — Player, World & Social Systems:** Player Progression (`PR-001`), Farming (`FB-001`), Hunting & Combat (`HU-001`), Multiplayer & Social Systems (`MS-001`), Building & Personal Island (`BI-001`), Inventory/Items/Tools/Crafting (`II-001`), Exploration & Secrets (`EX-001`), Time & Simulation (`TS-001`).
- **Phase 4 — World Population:** NPC/Dialogue/Quest (`NQ-001`), Story/Narrative (`ST-001`), Fishing (`FI-001`).
- **Phase 5 — Meta Systems:** Economy (`EC-001`), Save System (`SV-001`), UI/UX (`UI-001`), Audio (`AU-001`), Accessibility (`AX-001`), Input/Settings (`IS-001`).
- **Phase 6 — Implementation Governance:** Implementation Specs (`IA-001`), QA & Testing (`QA-001`), Performance, Production Readiness.

---

# 30. Documentation Dependency Principle

A specification should only be considered production-ready when its major dependencies are sufficiently defined.

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

## 38. Current Roadmap Status

- **CD-001 — Creative Direction Specification V1.0:** Canonical Creative Foundation established and locked at [`docs/CREATIVE_DIRECTION.md`](file:///c:/Users/HP/Documents/Underhallow/docs/CREATIVE_DIRECTION.md) (defines the 65% Cozy / 35% Adventure balance, the 50-hour feeling, non-intrusive slow-burn mystery, handcrafted SNES-era retro foundation + modern detail art standard, readability vs atmosphere parity, house evolution, and the supreme creative invariant: *"Never let the mystery destroy the cozy life. Never let the cozy life erase the mystery."*).
- **AD-001 — Art Direction Bible V1.0:** Canonical Art Direction Specification established and locked at [`docs/ART_DIRECTION_BIBLE.md`](file:///c:/Users/HP/Documents/Underhallow/docs/ART_DIRECTION_BIBLE.md) (defines the fixed isometric perspective, no camera rotation in V1.0, 16-bit foundation with modern pixel-art execution, cozy medieval-fantasy architecture, mixed architectural age, 3-tier house evolution, tiered NPC animations, subtle mystery creature language, handcrafted UI/typography/icons, six visual signatures, and the Underhallow visual evaluation rule).
- **WB-001 — World Bible V1.0:** Canonical World-Building Foundation established and locked at [`docs/WORLD_BIBLE.md`](file:///c:/Users/HP/Documents/Underhallow/docs/WORLD_BIBLE.md) (defines the island's geography, the town and landmarks, layered history, ancient civilization and disappearance, 8-stage emotional arc, reality-breaking places, subtle strange wildlife, grandparent inheritance, personal island sanctuary, non-forced hunting processing, and the core philosophy: *"The player comes to love Underhallow before they understand it"*).
- **NB-001 — Narrative Bible V1.0:** Foundation narrative specification established at [`docs/NARRATIVE_BIBLE.md`](file:///c:/Users/HP/Documents/Underhallow/docs/NARRATIVE_BIBLE.md) (defines the 6-phase mystery curve, player arrival and vague past, grandparent investigation legacy, NPC living history, the Ten Narrative Laws, ending philosophy, and core narrative balance: *"Cozy surface. Mystical middle. Deep mystery underneath"*).
- **CB-001 — Character Bible V1.0:** Foundation character specification established at [`docs/CHARACTER_BIBLE.md`](file:///c:/Users/HP/Documents/Underhallow/docs/CHARACTER_BIBLE.md) (defines 30–50 memorable residents, 3-tier depth structure, independent routines, believable flaws, fragmented mystery knowledge, imperfect living memory, romance rules, and core philosophy: *"Underhallow's characters should feel like people who have their own lives, histories, and reasons for staying here rather than NPCs who exist only for the player"*).
- **SR-001 — Specification Reconciliation V1.0:** Approved baseline established at [`docs/SPECIFICATION_RECONCILIATION.md`](file:///c:/Users/HP/Documents/Underhallow/docs/SPECIFICATION_RECONCILIATION.md) (reconciled platform to Windows PC, engine to Godot, mode to single-player-first/multiplayer-native, added Guild Islands, fixed camera orientation, and updated MSI governance).
- **ETA-001 — Engine & Technical Architecture Specification V1:** Approved foundation architecture established at [`docs/ENGINE_TECHNICAL_ARCHITECTURE_SPECIFICATION.md`](file:///c:/Users/HP/Documents/Underhallow/docs/ENGINE_TECHNICAL_ARCHITECTURE_SPECIFICATION.md) (supersedes initial browser/Phaser baseline `TA-001`; establishes Godot + GDScript + Dedicated Game Servers + Supabase for Windows PC).
- **WM-001 — World & Map Architecture Specification V1.0:** Drafted and established at [`docs/WORLD_MAP_ARCHITECTURE_SPECIFICATION.md`](file:///c:/Users/HP/Documents/Underhallow/docs/WORLD_MAP_ARCHITECTURE_SPECIFICATION.md).
- **PR-001 — Player Progression Specification V1.0:** Drafted and established at [`docs/PLAYER_PROGRESSION_SPECIFICATION.md`](file:///c:/Users/HP/Documents/Underhallow/docs/PLAYER_PROGRESSION_SPECIFICATION.md).
- **FB-001 — Farming System Specification V1.0:** Drafted and established at [`docs/FARMING_SYSTEM_SPECIFICATION.md`](file:///c:/Users/HP/Documents/Underhallow/docs/FARMING_SYSTEM_SPECIFICATION.md).
- **HU-001 — Hunting & Combat System Specification V1.0:** Drafted and established at [`docs/HUNTING_COMBAT_SYSTEM_SPECIFICATION.md`](file:///c:/Users/HP/Documents/Underhallow/docs/HUNTING_COMBAT_SYSTEM_SPECIFICATION.md).
- **MS-001 — Multiplayer & Social Systems Specification V1.0:** Drafted and established at [`docs/MULTIPLAYER_SOCIAL_SYSTEMS_SPECIFICATION.md`](file:///c:/Users/HP/Documents/Underhallow/docs/MULTIPLAYER_SOCIAL_SYSTEMS_SPECIFICATION.md).
- **IA-001 — Implementation Architecture Specification V1.1:** Advanced to `REVIEW` status at [`docs/IMPLEMENTATION_ARCHITECTURE_SPECIFICATION.md`](file:///c:/Users/HP/Documents/Underhallow/docs/IMPLEMENTATION_ARCHITECTURE_SPECIFICATION.md) (defines decision classification framework, Godot 4.x + GDScript project structure, domain state boundaries, input actions, GameTime simulation, persistence abstraction, V0.1 dependency sequence, and Vertical Slice V0.1 "The First Day" scope).
- **Next Planned Specification (Phase 3):**
  - **II-001 — Inventory, Items, Tools & Crafting Specification V1.0**
  - **BI-001 — Building & Personal Island Specification V1.0**
  - **TS-001 — Time, Day/Night & Simulation Specification V1.0**

