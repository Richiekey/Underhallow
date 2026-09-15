# Underhallow Agent Directives

Refer to the authoritative documentation hierarchy:
1. **Layer 1 (Project Authority):** [docs/NORTH_STAR.md](file:///c:/Users/HP/Documents/Underhallow/docs/NORTH_STAR.md) (Vision & Immutable Principles), [docs/CREATIVE_DIRECTION.md](file:///c:/Users/HP/Documents/Underhallow/docs/CREATIVE_DIRECTION.md) (Canonical Creative Foundation — CD-001), [docs/ART_DIRECTION_BIBLE.md](file:///c:/Users/HP/Documents/Underhallow/docs/ART_DIRECTION_BIBLE.md) (Canonical Art Direction Specification — AD-001), & [docs/WORLD_BIBLE.md](file:///c:/Users/HP/Documents/Underhallow/docs/WORLD_BIBLE.md) (Canonical World-Building Foundation — WB-001)
2. **Layer 2 (Foundation Specifications):** [docs/FOUNDATION_SPECIFICATION.md](file:///c:/Users/HP/Documents/Underhallow/docs/FOUNDATION_SPECIFICATION.md) (Product & System Definition), [docs/NARRATIVE_BIBLE.md](file:///c:/Users/HP/Documents/Underhallow/docs/NARRATIVE_BIBLE.md) (Narrative Bible — NB-001), & [docs/CHARACTER_BIBLE.md](file:///c:/Users/HP/Documents/Underhallow/docs/CHARACTER_BIBLE.md) (Character Bible — CB-001)
3. **Core Gameplay Spec:** [docs/CORE_GAMEPLAY_SYSTEMS_SPECIFICATION.md](file:///c:/Users/HP/Documents/Underhallow/docs/CORE_GAMEPLAY_SYSTEMS_SPECIFICATION.md) (Loops, Pillars, Agency, & Gameplay Invariants)
4. **Layer 3:** [docs/ENGINE_TECHNICAL_ARCHITECTURE_SPECIFICATION.md](file:///c:/Users/HP/Documents/Underhallow/docs/ENGINE_TECHNICAL_ARCHITECTURE_SPECIFICATION.md) (Engine, State, & Data Architecture — Godot / Dedicated Server / Supabase)
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
10. **PC & Multiplayer-Native Standard:** 60 FPS on target hardware, responsive keyboard/mouse/gamepad controls, integer pixel-art scaling, Godot client presentation, authoritative dedicated servers, and resilient Supabase / local persistence.
11. **The Creative Rule (Invariant 11):** *"Never let the mystery destroy the cozy life. Never let the cozy life erase the mystery."* Discovery is an invitation, not an obligation. Emotional balance: ~65% Cozy / 35% Adventure with mystery underlying both.
12. **Visual & World Crafting Standard (Invariant 12):** Highly detailed modern pixel art built on a classic 16-bit foundation presented via fixed isometric perspective (no camera rotation in V1.0). Equal priority between readability and beauty. Intentional detail over visual noise. Six visual signatures: Cozy Lighting, Pixel-Art Density, Natural/Inviting Color Palette, Cozy Medieval-Fantasy Architecture, Rare Mystical Elements, and Strange Environmental Details. Evaluate all art against: *"Would this look natural in the cozy world of Underhallow?"* and *"Would this be intriguing because it feels slightly wrong, rather than obvious because it looks like a monster?"*
13. **World Balance & Narrative Invariant (Invariant 13):** Three-tier world balance: *Cozy surface, mystical middle, deep mystery underneath*. The player comes to love Underhallow before they understand it. Discovery rewards curiosity without punishing indifference. Role freedom: hunters are never forced to process kills (selling raw resources is fully supported).
14. **The Ten Narrative Laws (Invariant 14):** 1. Life comes first; 2. Mystery emerges; 3. People matter (history lives through people, not just documents); 4. No simple villains; 5. The player is not the chosen one; 6. The world existed before the player; 7. Not everything connects; 8. Not everything is explained; 9. Choices matter locally; 10. Home is the emotional destination (*"Home can still be home even when you don't understand everything beneath it."*).
15. **Character & Living Community Standard (Invariant 15):** Characters are residents living independent lives, not quest machines. Population is structured into 30–50 memorable NPCs with tiered depth (Major, Minor, Background), distinct silhouettes, independent routines, believable flaws, and imperfect living memory. Acceptance follows *Warmth first, trust second, belonging later*. The player is not the center of every NPC's life.




