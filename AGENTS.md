# Underhallow Agent Directives

Refer to the authoritative documentation hierarchy:
1. **Layer 1:** [docs/NORTH_STAR.md](file:///c:/Users/HP/Documents/Underhallow/docs/NORTH_STAR.md) (Vision & Immutable Principles)
2. **Layer 2:** [docs/FOUNDATION_SPECIFICATION.md](file:///c:/Users/HP/Documents/Underhallow/docs/FOUNDATION_SPECIFICATION.md) (Product & System Definition)
3. **Core Gameplay Spec:** [docs/CORE_GAMEPLAY_SYSTEMS_SPECIFICATION.md](file:///c:/Users/HP/Documents/Underhallow/docs/CORE_GAMEPLAY_SYSTEMS_SPECIFICATION.md) (Loops, Pillars, Agency, & Gameplay Invariants)
4. **Layer 3:** [docs/TECHNICAL_ARCHITECTURE.md](file:///c:/Users/HP/Documents/Underhallow/docs/TECHNICAL_ARCHITECTURE.md) (Engine, State, & Data Architecture)
5. **Layer 4:** [docs/AGENT_CONSTITUTION.md](file:///c:/Users/HP/Documents/Underhallow/docs/AGENT_CONSTITUTION.md) (Agent Roles, Domains, Tasks, & DoD)

---

### Core Operating Invariants:
1. **The Prime Directive:** *"Do not build Underhallow as a collection of features. Build it as a world. The player should experience: 'I'm a person living in this strange little world.'"*
2. **Founder Authority:** Founder / Omni is the ultimate creative and product authority.
3. **The Underhallow Principle:** *"Does this make Underhallow a better game?"*
4. **The Architectural Invariant:** *"The game state is the truth. The renderer is the representation."*
5. **No Stamina System (Invariant 4):** Player activity is not artificially restricted by an energy or stamina meter. Constraints are inventory capacity, time, and expedition risk.
6. **Non-Lethal Defeat & Expedition Loss (Invariant 6):** Defeat costs resources gathered during the current expedition and time, returning player to Personal Island. Permanent progression is NEVER lost.
7. **Domain Whitelisting:** Agents only modify code within their assigned domain whitelist. Never touch `src/core/state/` or global save schemas without an approved Architecture Plan.
8. **Data-Driven Rule:** Game content (crops, items, creatures, buildings, dialogue, quests) is authored as data definitions, never hardcoded into engine classes.
9. **Simulation Time:** World simulation (crop growth, schedules) runs on deterministic `GameTime`, never real-time frame delta accumulation.
10. **Browser-First Standard:** 60 FPS, responsive keyboard/mouse/gamepad controls, integer pixel-art scaling, and resilient local IndexedDB persistence.
