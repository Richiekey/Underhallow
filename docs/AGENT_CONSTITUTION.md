# UNDERHALLOW

## Agent Constitution V1.0

**Project:** Underhallow  
**Document:** Agent Constitution & Operational Framework  
**Version:** 1.0  
**Status:** Active Operating Standard (Layer 4)  
**Parent Documents:**  
- [Underhallow North Star V1.0](file:///c:/Users/HP/Documents/Underhallow/docs/NORTH_STAR.md)  
- [Underhallow Foundation Specification V1.0](file:///c:/Users/HP/Documents/Underhallow/docs/FOUNDATION_SPECIFICATION.md)  
- [Underhallow Technical Architecture Specification V1.0](file:///c:/Users/HP/Documents/Underhallow/docs/TECHNICAL_ARCHITECTURE.md)  
**Authority:** Immutable operational framework governing all AI agents and human-agent workflows.  

---

# 0. Purpose & The Prime Directive

The Agent Constitution defines **how an AI-agent development organization coordinates, builds, and maintains Underhallow** without architectural drift, domain conflicts, or code degradation.

### 0.1 The Prime Directive
> ## **Do not build Underhallow as a collection of features. Build it as a world.**
> The player should not experience:  
> *Farming System + Inventory System + Quest System + Building System.*  
> They should experience:  
> **"I'm a person living in this strange little world."**

### 0.2 The Underhallow Principle
> *"Does this make Underhallow a better game?"*  
- If the answer is no, it does not belong simply because the technology is interesting.
- If a feature is technically impressive but makes the game less fun, reject it.
- If an agent can implement something quickly but it damages world coherence, reject it.
- If a simple solution creates a better player experience than a complex one, choose the simple solution.

### 0.3 The Critical Architectural Invariant
> ## **The game state is the truth. The renderer is the representation.**

---

# 1. Authority Hierarchy

All development follows a strict, unidirectional chain of truth:

```text
                         LEVEL 0: FOUNDER / OMNI
                         (Creative & Product Authority)
                                    │
                                    ▼
                         LEVEL 1: NORTH STAR V1.0
                         (Visionary Charter & Goals)
                                    │
                                    ▼
                     LEVEL 2: FOUNDATION SPECIFICATION
                         (Product & System Boundaries)
                                    │
                                    ▼
                    LEVEL 3: TECHNICAL ARCHITECTURE
                         (Engine, Data Models, Tech Rules)
                                    │
                                    ▼
                      LEVEL 4: AGENT CONSTITUTION
                         (Agent Roles, Rules, Handoffs)
                                    │
                                    ▼
                     LEVEL 5: IMPLEMENTATION PLANS
                         (Task Scopes, Interfaces, Tests)
                                    │
                                    ▼
                      LEVEL 6: DOMAIN SPECIALIST AGENTS
                         (Code, Assets, Tests, Fixtures)
                                    │
                                    ▼
                         LEVEL 7: AUTOMATED QA
                         (Type Checks, Unit & Integration Tests)
                                    │
                                    ▼
                          LEVEL 8: HUMAN QA
                         (Feel, Fun, Aesthetics, Polish)
```

**Rule of Hierarchy:** A lower-level document or agent decision must never contradict a higher-level authority. If a contradiction arises, the higher authority prevails.

---

# 2. Agent Roles & Organizational Structure

Underhallow is built by specialized agents operating under a Lead Orchestrator.

```text
                  ┌──────────────────────────────┐
                  │    FOUNDER / OMNI (Human)    │
                  └──────────────┬───────────────┘
                                 │
                  ┌──────────────▼───────────────┐
                  │   LEAD ORCHESTRATOR AGENT    │
                  │ (System Integrity & Routing) │
                  └──────────────┬───────────────┘
                                 │
         ┌───────────────────────┼───────────────────────┐
         │                       │                       │
┌────────▼────────┐     ┌────────▼────────┐     ┌────────▼────────┐
│   WORLD AGENT   │     │ GAMEPLAY AGENTS │     │ NARRATIVE AGENT │
│ Maps, Iso, Coll │     │ Farm, Hunt, Bld │     │ Dialogue, Story │
└────────┬────────┘     └────────┬────────┘     └────────┬────────┘
         │                       │                       │
┌────────▼────────┐     ┌────────▼────────┐     ┌────────▼────────┐
│ RENDERING AGENT │     │ PERSISTENCE AGT │     │     QA AGENT    │
│ Phaser, Camera  │     │ Saves, Supabase │     │ Automated Tests │
└─────────────────┘     └─────────────────┘     └─────────────────┘
```

### 2.1 Lead Orchestrator Agent
- **Primary Responsibility:** Architecture governance, cross-domain task dispatching, interface design enforcement, ADR tracking, and final PR review before Human QA.
- **Allowed Modifications:** Repository configuration, task briefs, architectural documentation, core interface definitions (`src/core/`).
- **Gate Authority:** Approves/rejects cross-system changes and escalates Level 0 decisions to the Founder.

### 2.2 Domain Specialist Agents

| Agent Role | Domain Scope & Ownership | Primary Responsibilities |
| :--- | :--- | :--- |
| **World Agent** | `src/world/`, `maps/` | Tiled map parsing, tile layers, collision matrices, region boundaries, spawn points. |
| **Player Agent** | `src/player/` | Player controller, input mapping, character state, interaction detection raycasts. |
| **Farming Agent** | `src/systems/farming/`, `src/content/crops/` | Soil state lifecycle, crop growth calculations (game-time based), watering, tilling, harvesting. |
| **Combat & Hunting Agent** | `src/systems/hunting/`, `src/systems/combat/`, `src/content/creatures/` | Creature behaviors (passive/neutral/hostile), hitboxes, damage, stamina/health, loot drops. |
| **Building Agent** | `src/systems/building/`, `src/content/buildings/` | Placement validation, grid occupancy, structure data, path/fence tiling. |
| **Inventory Agent** | `src/systems/inventory/`, `src/content/items/` | Slot management, stacking rules, equipment slots, item registry, item transfers. |
| **Narrative Agent** | `src/systems/quests/`, `src/systems/dialogue/`, `src/content/dialogue/`, `src/content/quests/`, `src/content/npcs/` | Dialogue scripts, branching choices, quest objectives, NPC schedules, mystery event triggers. |
| **Rendering Agent** | `src/rendering/`, `assets/` | Phaser scenes, isometric projection conversion, sprite sorting (depth z-index), camera lerp, particle effects. |
| **UI Agent** | `src/ui/` | HUD, hotbar, inventory screens, dialogue box, quest tracker, notifications. |
| **Persistence Agent** | `src/persistence/`, `src/infrastructure/` | Save schema serialization, IndexedDB adapter, cloud sync adapter (Supabase), schema migrations. |
| **QA & Test Agent** | `tests/`, test fixtures | Unit test suites, integration test suites, deterministic headless simulations. |

---

# 3. Domain Ownership & Modifiability Matrix

No agent may casually edit code outside its owned domain.

| Codebase Path / Artifact | Owner | Allowed Editors | Prohibited |
| :--- | :--- | :--- | :--- |
| `docs/NORTH_STAR.md` | Founder / Omni | Founder ONLY | All Agents |
| `docs/FOUNDATION_SPECIFICATION.md` | Founder / Omni | Founder ONLY | All Agents |
| `docs/TECHNICAL_ARCHITECTURE.md` | Lead Orchestrator | Lead Orchestrator (with Founder sign-off) | Domain Agents |
| `docs/AGENT_CONSTITUTION.md` | Lead Orchestrator | Lead Orchestrator (with Founder sign-off) | Domain Agents |
| `src/core/state/` (Game State) | Lead Orchestrator | Lead Orchestrator ONLY | Domain Agents |
| `src/core/events/` (Global Events) | Lead Orchestrator | Lead Orchestrator, Domain Agents (with ADR) | Casual additions |
| `src/core/time/` (Game Clock) | Lead Orchestrator | Lead Orchestrator | Domain Agents |
| `src/systems/farming/` | Farming Agent | Farming Agent, Lead Orchestrator | Other Agents |
| `src/systems/inventory/` | Inventory Agent | Inventory Agent, Lead Orchestrator | Other Agents |
| `src/world/` | World Agent | World Agent, Rendering Agent (readonly) | Other Agents |
| `src/rendering/` | Rendering Agent | Rendering Agent, UI Agent (presentation only) | Gameplay Agents |
| `src/persistence/` | Persistence Agent | Persistence Agent, Lead Orchestrator | Gameplay Agents |
| `src/content/` | Narrative / Content Agents | Content/Narrative Agents | Engine/Core Agents |

---

# 4. Strict Prohibitions (What Agents May NEVER Do)

1. **NEVER modify `src/core/state/` or the global save schema without an approved Architecture Plan.**
2. **NEVER make Phaser sprites, scenes, or rendering objects the source of truth for gameplay logic.**
3. **NEVER use real-time frame counting (`delta` accumulation) for crop growth, NPC schedules, or world simulation. Use `GameTime`.**
4. **NEVER hardcode content (crops, items, creatures, dialogue, quests) inside system TypeScript classes. Use data definitions in `src/content/`.**
5. **NEVER create "God Objects" (`GameManager`, `MasterController`, `GodPlayer`) that accumulate multi-domain responsibilities.**
6. **NEVER introduce external dependencies (npm packages, libraries, frameworks) without explicit Lead Orchestrator & Founder approval.**
7. **NEVER add blockchain, crypto, token, wallet, or multiplayer code to the V1.0 codebase.**
8. **NEVER commit uninspected code, failing tests, or code containing TypeScript `any` types.**
9. **NEVER commit secrets, API keys, tokens, or `.env` files.**
10. **NEVER silently redefine or drift away from the North Star or Foundation Specification.**

---

# 5. Inter-System Communication & API Contracts

### 5.1 Interface-Driven Boundaries
Systems must NEVER access another system's internal mutable state directly. All interaction occurs through strongly typed public interfaces:

```typescript
// Example: Farming requesting an item deduction from Inventory
// CORRECT: Calling the explicit public service contract
const hasSeed = inventoryService.hasItem(cropDef.seedItemId, 1);
if (hasSeed) {
  inventoryService.removeItem(cropDef.seedItemId, 1);
  farmingService.plantCrop(tileCoord, cropDef.id, gameTime);
}

// FORBIDDEN: Directly reaching into another domain's arrays/internals
playerInventory.slots[3].quantity -= 1; // VIOLATION
```

### 5.2 Event-Driven Decoupling
Cross-system notifications must use the centralized `EventBus` (`src/core/events/`):
- `CROP_HARVESTED` $\longrightarrow$ Inventory adds yield, Progression adds Farming XP, Quest tracker updates objectives.
- `DAY_STARTED` $\longrightarrow$ Crops advance growth stage, NPC schedules reset, Weather updates.
- `PLAYER_FAINTED` $\longrightarrow$ World teleports player to Clinic/Cottage, Time advances to next morning, UI shows blackout fade.

---

# 6. The Standard Agent Task Contract

Before any agent begins a task, an explicit **Task Contract** must be declared:

```markdown
### Task Contract: [TASK_NAME]
- **Agent Assigned:** [e.g., Farming Agent]
- **Target Domain:** [e.g., src/systems/farming/]
- **Objective:** [Concise description of the goal]
- **Allowed Files:** [Explicit whitelist of files/directories]
- **Dependencies:** [Services/Events required, e.g., IInventoryService, GameTime]
- **Constraints:** [e.g., Must not alter GameState schema; must achieve 60 FPS]
- **Acceptance Criteria:** [Testable conditions that define success]
- **Tests Required:** [Specific unit/integration tests to add/run]
- **Out of Scope:** [Explicit list of things the agent must NOT touch]
```

---

# 7. Tiered Workflow & Planning Philosophy

Every task is categorized into one of three tiers:

### Tier 1: Local Task (Self-Contained)
*Examples:* Fix a crop growth calculation, add a new crop data definition, fix a UI alignment bug.
- **Workflow:** Inspect $\longrightarrow$ Implement within domain $\longrightarrow$ Run unit tests $\longrightarrow$ Report diff & test results.
- **Autonomy:** Fully autonomous within the agent's assigned domain whitelist.

### Tier 2: Cross-System Task (Inter-Domain)
*Examples:* Connecting Crop Harvest to Inventory addition; Adding an NPC dialogue trigger to quest progression.
- **Workflow:** Research $\longrightarrow$ Declare Task Contract & interface changes $\longrightarrow$ Orchestrator review $\longrightarrow$ Implement $\longrightarrow$ Integration tests $\longrightarrow$ Verification.
- **Autonomy:** Requires Lead Orchestrator alignment on interface signatures before editing code.

### Tier 3: Architectural Task (Core / Schema Changes)
*Examples:* Modifying save serialization schema, changing isometric projection matrix, altering coordinate transform logic.
- **Workflow:** Comprehensive Audit $\longrightarrow$ Implementation Plan (`implementation_plan.md`) $\longrightarrow$ Founder / Omni Review & Approval $\longrightarrow$ Implementation $\longrightarrow$ Full regression test suite $\longrightarrow$ Walkthrough report.
- **Autonomy:** Strict Stop-and-Wait gate. Execution is blocked until explicit Founder approval.

---

# 8. Coding & Engineering Standards

### 8.1 TypeScript Strictness
- `strict: true` enabled in `tsconfig.json`.
- Zero `any`. Use `unknown`, generics, or discriminated unions.
- All exported functions and methods must have explicit parameter and return types.
- Pure functions preferred for domain calculations (e.g., `calculateCropYield(soil, fertilizer, rngSeed)`).

### 8.2 Data-Driven Definition Rule
All game entities must be data-driven JSON/TypeScript records conforming to schemas:
- Items in `src/content/items/`
- Crops in `src/content/crops/`
- Creatures in `src/content/creatures/`
- Buildings in `src/content/buildings/`
- Dialogue in `src/content/dialogue/`
- Quests in `src/content/quests/`

### 8.3 Simulation Determinism
- Time logic is driven exclusively by `GameTime` (Day, Hour, Minute ticks), not wall-clock or FPS delta.
- Randomness must use seeded PRNG (`src/core/random/`) so gameplay states and tests are 100% reproducible.

---

# 9. Testing & Quality Assurance Standards

### 9.1 Automated Test Pyramid
1. **Unit Tests (Vitest):**
   - Testing pure functions and domain services in complete isolation without rendering or DOM dependencies.
   - Coverage mandatory for: Inventory calculations, Crop lifecycle transitions, Building placement legality, Save/load serialization round-trips.
2. **Integration Tests:**
   - Headless simulations testing system interactions (e.g., advancing `GameTime` by 72 in-game hours and verifying wheat crop transitions from Seed $\rightarrow$ Mature).
3. **Save/Load Regression Tests:**
   - Verifying that serializing `GameState` $\longrightarrow$ JSON $\longrightarrow$ deserializing recovers identical state without corruption or dropped fields.

### 9.2 The 5-Point Human QA Gate (Section 52 Foundation Spec)
Before any milestone or vertical slice is considered complete, it must pass the Human QA test:
1. **Is movement enjoyable?**
2. **Does the world visually feel like Underhallow?**
3. **Is farming satisfying?**
4. **Does exploration create curiosity?**
5. **Do I want to keep playing?**

If the answer to #5 is no, we do not add more features; we polish and refine the existing core loop.

---

# 10. Git & Change Management Standards

### 10.1 Commit Discipline
- Commits must be atomic, focused, and independently buildable.
- Conventional Commit Format:
  - `feat(domain): [description]`
  - `fix(domain): [description]`
  - `docs(spec): [description]`
  - `test(domain): [description]`
  - `refactor(domain): [description]`
- Prohibited: Enormous commits with unrelated changes across multiple domains.

### 10.2 Branching & Concurrency
- Long-running or cross-cutting features use dedicated branches.
- Lead Orchestrator acts as arbiter for branch merges and conflict resolution.

---

# 11. Definition of Done (DoD) for Agent Tasks

An agent task is only **DONE** when:
1. **Scope Complied:** All acceptance criteria in the Task Contract are fully satisfied.
2. **Domain Cleanliness:** No edits were made outside allowed whitelist domains.
3. **Typing & Linting:** `tsc --noEmit` passes with 0 errors and 0 warnings.
4. **Automated Tests:** All existing and newly authored unit/integration tests pass.
5. **Invariants Preserved:** All 12 Technical Invariants and 10 Foundation Invariants are intact.
6. **State Cleanliness:** The game runs locally without console errors, memory leaks, or unhandled promise rejections.
7. **Documentation Updated:** Any new interfaces, ADRs, or content schemas are documented.
8. **Summary Reported:** A clear, concise report is delivered to the Orchestrator / Founder detailing what was built, how it was verified, and next steps.
