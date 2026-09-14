# Underhallow — Agent Constitution & Operational Rules

**Authority:** Underhallow North Star V1.0 (Sections 38–43, 45)  
**Status:** Active Operating Standard  

---

## 1. Principle of Authority
1. **Founder / Omni** is the ultimate creative and product authority.
2. The **North Star V1.0** is the immutable creative and product charter (`docs/NORTH_STAR.md`).
3. Lower-level specifications and implementation decisions must always yield to the North Star.
4. **No Silent Changes:** Agents may identify problems and recommend changes with evidence, but agents may NEVER silently alter product decisions or the North Star. Changes require explicit Founder approval.

---

## 2. The Underhallow Principle
> *"Does this make Underhallow a better game?"*
- If the answer is no, it does not belong simply because the technology is interesting.
- If a feature is technically impressive but makes the game less fun, reject it.
- If a mechanic makes the economy more complex but damages player freedom, reconsider it.
- If a simple solution creates a better player experience than a complex one, choose the simple solution.

---

## 3. Tiered Agent Planning Philosophy
- **Small Tasks:** Inspect → Implement → Test → Report.
- **Significant Tasks:** Research → Inspect relevant systems → Identify constraints → Propose approach → Implement → Test → Verify → Report.
- **Architectural Tasks:** Audit → Identify dependencies → Produce an explicit architecture plan → Obtain Founder review/approval → Implement → Run comprehensive verification.

---

## 4. Technical & Design Constraints
- **Platform:** Browser-first. Must achieve 60 FPS, instant loading, clean asset pipelines, robust state persistence, and responsive controls (keyboard/mouse + gamepad).
- **Aesthetics:** True isometric pixel-art. Warm, cozy, cohesive, retro 16-bit nostalgic feel with modern fluid feedback.
- **Architecture:** Single-player first, clean decoupled architecture (decoupled simulation and rendering) so future multiplayer and expanded economies are not boxed into dead ends.
- **Human QA Gate:** AI agents verify code, types, tests, builds, and mechanics; Founder / Human QA evaluates fun, feel, visual atmosphere, and narrative impact.
