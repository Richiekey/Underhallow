# Underhallow — Agent Constitution & Operational Rules

**Authority:** Underhallow North Star V1.0 & Foundation Specification V1.0 (Sections 56–62)  
**Status:** Active Operating Standard  

---

## 1. The Prime Directive (Section 62)
> ### **Do not build Underhallow as a collection of features. Build it as a world.**
The player should not experience:
> *Farming System + Inventory System + Quest System + Building System.*  
They should experience:
> **"I'm a person living in this strange little world."**  
That is the standard every system, screen, mechanic, and line of code must support.

---

## 2. Principle of Authority & Hierarchy (Section 60)
The documentation and decision hierarchy is strictly maintained:

```text
                    UNDERHALLOW
                    NORTH STAR
                         │
                         ▼
               FOUNDATION SPECIFICATION
                         │
            ┌────────────┼────────────┐
            ↓            ↓            ↓
       GAME SYSTEMS   WORLD DESIGN   NARRATIVE
            │            │            │
            └────────────┼────────────┘
                         ↓
                TECHNICAL ARCHITECTURE
                         │
                         ↓
                  AGENT CONSTITUTION
                         │
                         ↓
                  IMPLEMENTATION PLAN
                         │
                         ↓
                      AGENTS
                         │
                         ↓
                       CODE
                         │
                         ↓
                    AUTOMATED QA
                         │
                         ↓
                     HUMAN QA
```

1. **Founder / Omni** is the ultimate creative, product, and architectural authority.
2. The **North Star V1.0** (`docs/NORTH_STAR.md`) and **Foundation Specification V1.0** (`docs/FOUNDATION_SPECIFICATION.md`) are the authoritative baselines.
3. Lower-level specifications and implementation decisions must strictly adhere to higher-level specifications.
4. **No Silent Changes:** Agents may identify problems and recommend changes with evidence, but agents may NEVER silently alter product decisions or foundational documents. Changes require explicit Founder approval.
5. **Agent Boundaries (Section 59):** Agents implement systems within an existing game architecture. An agent does not have license to redefine the game.

---

## 3. The Underhallow Principle
> *"Does this make Underhallow a better game?"*
- If the answer is no, it does not belong simply because the technology is interesting.
- If a feature is technically impressive but makes the game less fun, reject it.
- If a mechanic makes the economy more complex but damages player freedom, reconsider it.
- If a simple solution creates a better player experience than a complex one, choose the simple solution.

---

## 4. The 10 Design Invariants (Section 56)
1. **Invariant 1:** Underhallow must be playable without blockchain.
2. **Invariant 2:** Underhallow must be enjoyable without competition.
3. **Invariant 3:** No player class permanently prevents experimentation with other playstyles.
4. **Invariant 4:** The Personal Island is a major player-expression space.
5. **Invariant 5:** The Main Island exists primarily for world exploration, society and narrative.
6. **Invariant 6:** Farming, hunting and building are foundational gameplay pillars.
7. **Invariant 7:** Exploration must contain meaningful discovery.
8. **Invariant 8:** The cozy surface and darker underlying mystery must coexist.
9. **Invariant 9:** AI agents cannot silently change foundational game decisions.
10. **Invariant 10:** Feature quantity must never be prioritized over gameplay quality.

---

## 5. Development Strategy (Sections 50–52)
- **Vertical, Not Horizontal:** Build a small slice of the actual game at meaningful quality rather than 30 systems at 10% completion.
- **Vertical Slice Success Test:**
  1. Is movement enjoyable?
  2. Does the world visually feel like Underhallow?
  3. Is farming satisfying?
  4. Does exploration create curiosity?
  5. Do I want to keep playing?
  *(If #5 is no, we do not add more features; we improve the existing loop).*

---

## 6. Tiered Agent Planning Philosophy
- **Small Tasks:** Inspect → Implement → Test → Report.
- **Significant Tasks:** Research → Inspect relevant systems → Identify constraints → Propose approach → Implement → Test → Verify → Report.
- **Architectural Tasks:** Audit → Identify dependencies → Produce an explicit architecture plan → Obtain Founder review/approval → Implement → Run comprehensive verification.
