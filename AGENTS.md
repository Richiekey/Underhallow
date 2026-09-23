# Underhallow Agent Directives

## Authoritative Documentation Hierarchy

Refer to the authoritative documentation hierarchy:
1. **Layer 1 (Project Authority):** [docs/01-product/NORTH_STAR.md](docs/01-product/NORTH_STAR.md) (Vision & Immutable Principles), [docs/06-art/CREATIVE_DIRECTION.md](docs/06-art/CREATIVE_DIRECTION.md) (Canonical Creative Foundation — CD-001), [docs/06-art/ART_DIRECTION_BIBLE.md](docs/06-art/ART_DIRECTION_BIBLE.md) (Canonical Art Direction Specification — AD-001), & [docs/04-world/WORLD_BIBLE.md](docs/04-world/WORLD_BIBLE.md) (Canonical World-Building Foundation — WB-001)
2. **Layer 2 (Foundation Specifications):** [docs/01-product/FOUNDATION_SPECIFICATION.md](docs/01-product/FOUNDATION_SPECIFICATION.md) (Product & System Definition), [docs/05-narrative/NARRATIVE_BIBLE.md](docs/05-narrative/NARRATIVE_BIBLE.md) (Narrative Bible — NB-001), [docs/05-narrative/CHARACTER_BIBLE.md](docs/05-narrative/CHARACTER_BIBLE.md) (Character Bible — CB-001), [docs/04-world/BIOME_ENVIRONMENT_BIBLE.md](docs/04-world/BIOME_ENVIRONMENT_BIBLE.md) (Biome & Environment Bible — BE-001), [docs/04-world/CREATURE_WILDLIFE_BIBLE.md](docs/04-world/CREATURE_WILDLIFE_BIBLE.md) (Creature & Wildlife Bible — CW-001), [docs/05-narrative/MYSTERY_LORE_ARCHITECTURE_SPECIFICATION.md](docs/05-narrative/MYSTERY_LORE_ARCHITECTURE_SPECIFICATION.md) (Mystery & Lore Architecture — ML-001), [docs/04-world/MAIN_ISLAND_DESIGN_SPECIFICATION.md](docs/04-world/MAIN_ISLAND_DESIGN_SPECIFICATION.md) (Main Island Design Specification — MI-001), & [docs/04-world/PERSONAL_ISLAND_DESIGN_SPECIFICATION.md](docs/04-world/PERSONAL_ISLAND_DESIGN_SPECIFICATION.md) (Personal Island Design Specification — PI-001)
3. **Core Gameplay Spec:** [docs/03-gameplay/CORE_GAMEPLAY_SYSTEMS_SPECIFICATION.md](docs/03-gameplay/CORE_GAMEPLAY_SYSTEMS_SPECIFICATION.md) (Loops, Pillars, Agency, & Gameplay Invariants)
4. **Layer 3:** [docs/02-architecture/ENGINE_TECHNICAL_ARCHITECTURE_SPECIFICATION.md](docs/02-architecture/ENGINE_TECHNICAL_ARCHITECTURE_SPECIFICATION.md) (Engine, State, & Data Architecture — Godot / Dedicated Server / Supabase)
5. **Layer 4 (Governance & Protocols):** [docs/00-governance/AGENT_CONSTITUTION.md](docs/00-governance/AGENT_CONSTITUTION.md) (Agent Roles, Domains, Tasks, & DoD), [docs/00-governance/EXECUTION_DOCUMENTATION_PROTOCOL.md](docs/00-governance/EXECUTION_DOCUMENTATION_PROTOCOL.md) (Execution, Evidence, & Synchronization Protocol — EDP-001), & [docs/00-governance/MASTER_SPECIFICATION_INDEX.md](docs/00-governance/MASTER_SPECIFICATION_INDEX.md) (Master Specification Index & Registry — MSI-001)

---

## Multi-Agent Organization & Operational Directives (EDP-001)

Underhallow enforces a strict separation of development boundaries across its multi-agent development organization:
* **Founder / Human:** Ultimate project, product, and governance authority.
* **GM1 — ChatGPT:** Canonical project-level coordination, specification interpretation, cross-team reconciliation, and final milestone acceptance authority.
* **GM2 — Claude Opus 4.6:** Execution planning, deep repository inspection, implementation brief authoring, coordination, report review, and defect escalation.
* **Owning Teams:** Think, inspect, analyze, plan, and review. Owning teams, GM1, and GM2 **never directly modify repository implementation artifacts**.
* **Gemini / Coding Agents / Human:** Gemini is the designated coding and implementation agent for this workflow; other coding agents or the human implement when explicitly authorized. Implement, test, commit, and report strictly within assigned domain whitelists.
* **QA Engineers:** Independently verify implementation in dedicated test scenarios. QA never implements production code and never repairs defects under test.

### 17 Mandatory Operational Rules for Coding Agents
1. **Inspect Before Implementation:** Thoroughly inspect the active codebase, MSI, and relevant specifications before writing or proposing code.
2. **Read Authoritative Specifications:** Base all changes on locked and approved specifications, never on assumptions or conversational memory.
3. **Follow Domain Boundaries:** Adhere strictly to domain whitelists defined in [AC-001](docs/00-governance/AGENT_CONSTITUTION.md). Never touch `src/core/state/` or global save schemas without an approved Architecture Plan.
4. **Follow the Implementation Brief:** Execute exactly what is authorized in the implementation brief authored by GM2 (or GM1/Team). Do not add unrequested features or unsolicited refactorings.
5. **Preserve Architecture & Product Scope:** Never redefine system architecture, product scope, or gameplay invariants.
6. **Stop on Contradiction:** Stop and escalate immediately if requirements, specifications, or architectural patterns conflict.
7. **Implement Only Authorized Work:** Confine all changes strictly to the assigned task.
8. **Run Appropriate Tests:** Always execute the relevant test suites (e.g. `godot --headless -s tests/core/test_runner.gd`) and record actual test metrics after modifying code.
9. **Report Actual Test Evidence:** Document exact test counts, pass/fail counts, and exit codes. Never claim tests passed without running them.
10. **Report Changed Files:** Provide an exhaustive list of all created, modified, and deleted files.
11. **Report Documentation Changes:** Detail all updates to specifications, MSI registries, and index documents.
12. **Report Risks & Blockers:** Disclose any technical debt, architectural friction, performance concerns, or follow-up risks.
13. **Distinguish Implementation from QA:** Never represent implementer test results as independent QA verification.
14. **Commit Completed Implementation Separately:** Create focused git commits with descriptive messages, separating documentation work from runtime code.
15. **Provide Commit Hash:** Provide the exact commit SHA to GM2 / GM1 upon completion.
16. **Never Claim QA or GM Acceptance:** A coding agent can only state what was implemented and tested; acceptance is the sole prerogative of GM1 (or Human Project Authority).
17. **Current Repository is Ground Truth:** Never treat past conversations, outdated reports, or temporary scratch files as authoritative over the active repository.

### Mandatory Status Attribution in Implementation Reports
Every implementation report must explicitly record which canonical states have actually occurred for that task or session, avoiding artificial conflation:
* **Planned:** Citing the active brief from GM2 / Team.
* **Implemented:** Citing the exact commit SHA and modified files.
* **Implementer-Tested:** Citing actual test commands, pass counts, and exit codes.
* **Team-Reviewed:** Citing domain team review findings (when conducted).
* **QA-Verified:** Only cite if an independent QA report (e.g. `QA-00x`) was formally produced.
* **GM-Accepted:** Only cite if formal GM1 acceptance was explicitly granted under [GSP-001](docs/08-reports/gm/GM_SESSION_RECORD_PROTOCOL.md).

### Stop & Escalation Conditions
In accordance with the Escalation Matrix in [EDP-001 §19](docs/00-governance/EXECUTION_DOCUMENTATION_PROTOCOL.md), stop and report immediately if:
* An implementation brief contradicts a locked or approved specification.
* A required change requires touching code outside your assigned domain whitelist.
* An architectural pattern would cause illegal mutations to `src/core/state/` or state/presentation separation.
* A specification requirement is ambiguous or missing.
* Implementation friction appears to tempt altering a product invariant.

---

## Core Operating Invariants

1. **The Prime Directive:** *"Do not build Underhallow as a collection of features. Build it as a world. The player should experience: 'I'm a person living in this strange little world.'"*
2. **Founder Authority:** Founder / Omni is the ultimate creative and product authority.
3. **The Underhallow Principle:** *"Does this make Underhallow a better game?"*
4. **The Architectural Invariant:** *"The game state is the truth. The renderer is the representation."*
5. **No Stamina System (Invariant 4):** Player activity is not artificially restricted by an energy or stamina meter. Constraints are inventory capacity, time, and expedition risk.
6. **Non-Lethal Defeat & Expedition Loss (Invariant 6):** Defeat costs resources gathered during the current expedition and time, returning player to Personal Island. Permanent progression is NEVER lost.
7. **Domain Whitelisting:** Agents only modify code within their assigned domain whitelist. Never touch `src/core/state/` or global save schemas without an approved Architecture Plan.
8. **Data-Driven Rule:** Game content (crops, items, creatures, buildings, dialogue, quests) is authored as data definitions, never hardcoded into engine classes.
9. **Simulation Time:** World simulation (crop growth, schedules) runs on deterministic `GameTime`, never real-time frame delta accumulation.
10. **PC & Multiplayer-Native Standard:** 60 FPS on target hardware, responsive keyboard/mouse/gamepad controls, integer pixel-art scaling, Godot client presentation, authoritative dedicated servers, and resilient Supabase / local persistence.
11. **The Creative Rule (Invariant 11):** *"Never let the mystery destroy the cozy life. Never let the cozy life erase the mystery."* Discovery is an invitation, not an obligation. Emotional balance: ~65% Cozy / 35% Adventure with mystery underlying both.
12. **Visual & World Crafting Standard (Invariant 12):** Highly detailed modern pixel art built on a classic 16-bit foundation presented via fixed isometric perspective (no camera rotation in V1.0). Equal priority between readability and beauty. Intentional detail over visual noise. Six visual signatures: Cozy Lighting, Pixel-Art Density, Natural/Inviting Color Palette, Cozy Medieval-Fantasy Architecture, Rare Mystical Elements, and Strange Environmental Details. Evaluate all art against: *"Would this look natural in the cozy world of Underhallow?"* and *"Would this be intriguing because it feels slightly wrong, rather than obvious because it looks like a monster?"*
13. **World Balance & Narrative Invariant (Invariant 13):** Three-tier world balance: *Cozy surface, mystical middle, deep mystery underneath*. The player comes to love Underhallow before they understand it. Discovery rewards curiosity without punishing indifference. Role freedom: hunters are never forced to process kills (selling raw resources is fully supported).
14. **The Ten Narrative Laws (Invariant 14):** 1. Life comes first; 2. Mystery emerges; 3. People matter (history lives through people, not just documents); 4. No simple villains; 5. The player is not the chosen one; 6. The world existed before the player; 7. Not everything connects; 8. Not everything is explained; 9. Choices matter locally; 10. Home is the emotional destination (*"Home can still be home even when you don't understand everything beneath it."*).
15. **Character & Living Community Standard (Invariant 15):** Characters are residents living independent lives, not quest machines. Population is structured into 30–50 memorable NPCs with tiered depth (Major, Minor, Background), distinct silhouettes, independent routines, believable flaws, and imperfect living memory. Acceptance follows *Warmth first, trust second, belonging later*. The player is not the center of every NPC's life.
16. **Main Island Standard (Invariant 16):** *"The main island of Underhallow should feel like a place you could spend years getting to know rather than a map you are expected to complete."* Communal world, 7–9 major regional frameworks with organic transitions, ~50% accessible in early game, landmark navigation, intentional empty space/wilderness, non-lethal defeat returning to Personal Island, non-forced hunting processing, layered historical depth, and non-checklist experiential discovery. Main Island pulls outward (*"What is out there?"*); Personal Island pulls home (*"This is mine."*).
17. **Building & Construction Standard (Invariant 17):** *"Building in Underhallow should allow players to create a place that feels uniquely theirs, while turning creativity and investment into meaningful gameplay."* ([BI-001](docs/03-gameplay/BUILDING_CONSTRUCTION_SYSTEM_SPECIFICATION.md)). Constructible objects are data-driven definitions, state is strictly authoritative independently of presentation (Command → Validation → Mutation → Event), server-authoritative over persistent multiplayer state, hybrid placement model (structured snapping for major buildings, expressive placement for furniture/decorations), non-tedious construction duration, generous material recovery on demolition to encourage redesign, no oppressive maintenance/decay loops, soft builder specialization, and strict separation between the universal construction framework (BI-001) and specific property contexts (Personal Islands PI-001, Guild Islands).
18. **Personal Island Standard (Invariant 18):** *"The Personal Island of Underhallow should feel like a home the player slowly creates and grows into rather than a farm they are simply trying to optimize."* ([PI-001](docs/04-world/PERSONAL_ISLAND_DESIGN_SPECIFICATION.md)). Private sanctuary and emotional destination (*"This is mine."*), functional inherited starting cottage with undeveloped land, gradual grid-based area expansion, organic 3-stage house evolution (Cottage → Homestead → Estate), balanced efficiency vs. expression, preserved wilderness without mandatory optimization, ecological wildlife attraction, persistent authoritative state, and subtle non-oppressive mystery: *"Home can still be home even when you don't understand everything beneath it."*
19. **Biome & Environmental Standard (Invariant 19):** *"Underhallow's environments should feel like places, not levels. Beautiful first. Strange second."* ([BE-001](docs/04-world/BIOME_ENVIRONMENT_BIBLE.md)). 16 Canonical Environmental Laws (Place Before Level, Geography Precedes Labeling, Ecology Supports Visuals, Gameplay Emerges Naturally, Physical Transitions, Ordinary Stays Ordinary, Mystery Retains Meaning, Beauty Allowed Without Mechanics, Not Everything Needs Lore/Explanation, Bounded Terraforming, Readability Over Density, Navigation Landmarks, Anti-Biome Proliferation, Strangeness Enriches Believability), 6-tier hierarchy (Family → Biome → Sub-Biome → Ecotone → Micro-Environment → Landmark), 7-layer design model, Gameplay Affordance Matrix, 4-tier Mystery Density Model (Level 0 Ordinary to Level 3 Impossible), subtle environmental wrongness ("The Wrong Thing" principle), and environmental memory. Home remains home even as depth reveals itself.
20. **Creature & Wildlife Standard (Invariant 20):** *"Wildlife should feel like the island has a life of its own, whether or not the player is there."* ([CW-001](docs/04-world/CREATURE_WILDLIFE_BIBLE.md)). 16 Core Wildlife Laws, 4-tier spectrum (Ordinary → Notable → Strange → Impossible), 10 creature taxonomies (Birds, Mammals, Reptiles, Amphibians, Fish, Insects & Small Creatures, Domestic Animals, Livestock, Strange Wildlife, Impossible Wildlife), hunting ethics ("Hunting is an activity within nature, not the reason nature exists; processing is optional; raw resource selling fully supported"), observation as a valid non-extractive interaction ("Wildlife is not primarily loot"), believable behavioral abstraction, autonomous daily routines, and dynamic personal island ecological attraction (Building → Nature → Wildlife → Home).
21. **Mystery & Lore Architecture Standard (Invariant 21):** *"The mystery should make the world deeper, not make the world feel like a puzzle box. Understanding history is not the same thing as understanding Underhallow itself."* ([ML-001](docs/05-narrative/MYSTERY_LORE_ARCHITECTURE_SPECIFICATION.md)). 20 Core Mystery Laws, 5-layer mystery architecture (Ordinary Mysteries, Local Mysteries, Historical Mysteries, Central Truth, Permanent Unknown), 5–8 major mystery families, 7-stage revelation progression (Ordinary → Strange → Connected → Historical → Personal → Central → Permanent Unknown), grandparent's morally complicated decision, redundant discovery paths for critical truths, recontextualization over retcons, and strict separation between Development Truth, Player Truth, and Player Interpretation. Discovery enriches home without turning the world into a spreadsheet.
