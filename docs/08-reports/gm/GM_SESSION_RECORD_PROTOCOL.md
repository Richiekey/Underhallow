# UNDERHALLOW — GM SESSION RECORD PROTOCOL

## Game Master & Executive Review Standard Operating Procedure

**Document ID:** GSP-001  
**Status:** APPROVED (Project Governance & Reporting Protocol)  
**Authority Level:** Level 4 — Implementation & Governance Protocol  
**Parent Specifications:**  
* [Underhallow Agent Constitution V1.0 (AC-001)](file:///c:/Users/HP/Documents/Underhallow/docs/00-governance/AGENT_CONSTITUTION.md)  
* [Master Specification Index & Build Governance V1.1 (MSI-001)](file:///c:/Users/HP/Documents/Underhallow/docs/00-governance/MASTER_SPECIFICATION_INDEX.md)  
* [Underhallow North Star V1.0 (NS-001)](file:///c:/Users/HP/Documents/Underhallow/docs/01-product/NORTH_STAR.md)  
* [Underhallow Production Plan & Vertical Slice Roadmap V1.0 (PP-001)](file:///c:/Users/HP/Documents/Underhallow/docs/01-product/PRODUCTION_PLAN.md)  

**Applies To:** Founder / Omni (Human Project Lead), Game Masters (GM), Lead QA, Systems Architects, and all Specialized AI Agents  
**Repository:** `Richiekey/Underhallow`  
**Storage Directory:** `docs/08-reports/gm/`  

---

## 1. Purpose & Scope

The **Game Master (GM) Session Record Protocol** establishes the formal verification, review, and acceptance procedure for all vertical slice iterations, milestone gates, and surgical correction passes in Underhallow.

While automated test runners and QA verification passes confirm technical conformance (e.g., zero regression, command validation, leak checks), the **GM Review Session** provides the definitive executive bridge between mechanical implementation and creative vision:

> **"Does this make Underhallow a better game, and does it feel like a living, strange little world?"**

No milestone release, major feature slice, or vertical roadmap progression is marked complete without a corresponding, signed **GM Session Record** archived in `docs/08-reports/gm/`.

---

## 2. Review Hierarchy & Workflow

```text
       SPECIALIZED IMPLEMENTATION AGENTS
           (Feature / Domain Work)
                      │
                      ▼
        QA VERIFICATION PASS (QA-00x)
    (Automated Tests, Invariant Verification)
                      │
                      ▼ "READY FOR GM/PM ACCEPTANCE"
         GM REVIEW SESSION (GSP-001)
 (Experiential Playtest, Creative Audit, Sign-off)
                      │
        ┌─────────────┴─────────────┐
        ▼                           ▼
[🟢 / 🟡 ACCEPTED]            [🔴 REJECTED / 🔄 RETEST]
Release / Advance Milestone   Return to Agents with Action Items
```

### 2.1 Trigger Pre-Conditions
A GM Review Session may only be conducted when:
1. **Target Commit Pinned:** The target commit SHA is explicitly recorded and matches a clean git working tree.
2. **QA Pre-requisite Satisfied:** A formal QA report (e.g., in `docs/08-reports/qa/`) exists with disposition **"READY FOR GM/PM ACCEPTANCE"**.
3. **Headless Test Suite Green:** The canonical test suite (`godot --headless -s tests/core/test_runner.gd`) reports 100% pass rate (0 failed assertions).

---

## 3. Evaluation Criteria

Every GM Session must audit the build across three rigorous dimensions:

### 3.1 Experiential & Vision Invariants (The Creative Audit)
* **The Prime Directive (Invariant 1):** Does the experience feel like *living in a strange little world*, rather than operating an isolated collection of game mechanics?
* **Emotional Balance (Invariant 11):** Is the ratio maintained at ~65% Cozy life / 35% Adventure with mystery underlying both? Discovery must remain an invitation, never an oppressive chore.
* **Visual Craftsmanship (Invariant 12):** Does the visual density, cozy lighting, medieval-fantasy architecture, and pixel art feel handcrafted, clear, and intentional rather than noisy?
* **Pacing & Restraint:** Are animations, transitions, and interactions calm, deliberate, and satisfying?

### 3.2 Systemic & Gameplay Invariants
* **No Stamina System (Invariant 4):** Confirm that player movement, farming, tool usage, and construction are unrestricted by arbitrary stamina or energy bars.
* **Non-Lethal Defeat (Invariant 6):** Ensure defeat resets expedition state and returns the player to the Personal Island sanctuary without destroying permanent progression or home structures.
* **Role Freedom (Invariant 13 & 20):** Verify players are never forced into unwanted secondary loops (e.g., hunters may sell raw carcasses without mandatory butchering/tanning; farming is self-paced).
* **Footprint & Interaction Authority:** Confirm physical footprint alignment, non-overlapping structures, and deterministic interaction priority.

### 3.3 Technical & Architectural Invariants
* **State vs. Presentation Separation (Invariant 4):** Game state must be the absolute truth; visual nodes (`BuildingDisplay`, sprites, particles) must remain strictly reactive representations.
* **Deterministic Simulation Time:** Confirm simulation progresses via discrete `GameTime` ticks, never frame delta accumulation.
* **Zero Architectural Drift:** Verify that no gameplay agent touched unauthorized domain directories outside their whitelist without an approved architecture plan.

---

## 4. Formal Session Dispositions

At the conclusion of each GM review, the session must be assigned one of four canonical dispositions:

| Disposition | Symbol | Definition & Consequence |
| :--- | :---: | :--- |
| **Accepted & Signed Off** | `🟢` | All functional and experiential requirements met. Feature or slice is approved for production baseline integration. |
| **Accepted With Conditions** | `🟡` | Core experience approved. Minor visual/polish defects noted; non-blocking action items scheduled for the next sprint/pass. |
| **Rejected / Changes Required** | `🔴` | Core design violation, severe experiential friction, or invariant breach identified. Build blocked from milestone advance; returned to development agents. |
| **Retest Required** | `🔄` | Environmental inconsistency, unverified edge case, or QA discrepancy discovered during review. Returned to QA team for re-run. |

---

## 5. Storage & Naming Standard

* All GM Session Records must be stored in:
  `docs/08-reports/gm/`
* Filename convention:
  `GM_SESSION_<YYYYMMDD>_<TOPIC_SLUG>.md`
  * Example: `GM_SESSION_20260918_PHASE4_HUNTING_CONSTRUCTION.md`
  * Example: `GM_SESSION_20260925_CLEMENTINE_NARRATIVE_SLICE.md`
* Immutability: Once signed and committed, GM Session Records are historical audit logs and must not be retroactively edited (any follow-up must be a new session record or addendum).

---

## 6. Canonical GM Session Record Template

When executing and logging a GM Review Session, copy the template below into a new file in `docs/08-reports/gm/`:

```markdown
# UNDERHALLOW — GM SESSION RECORD

**Session ID:** GM-YYYYMMDD-###  
**Review Topic:** [e.g. Phase 4 Vertical Slice — Hunting & Construction Acceptance]  
**Lead Reviewer / GM:** [Founder / Omni / Designated GM]  
**Execution Timestamp:** YYYY-MM-DD HH:MM:SS UTC  
**Target Commit:** [`<COMMIT_SHA>`](file:///c:/Users/HP/Documents/Underhallow)  
**Engine Baseline:** Godot 4.7.2.stable.official.ed1daf0bf (Windows PC x86_64)  
**Pre-requisite QA Report:** [docs/08-reports/qa/QA_...md](file:///c:/Users/HP/Documents/Underhallow/docs/08-reports/qa/...)  
**Final GM Disposition:** [🟢 ACCEPTED / 🟡 ACCEPTED WITH CONDITIONS / 🔴 REJECTED / 🔄 RETEST]  

---

## 1. Executive Summary

[Concise 2–3 paragraph overview of what was evaluated, the overall experiential feel, and the core finding of the session.]

---

## 2. Runtime & Environment Baseline

| Parameter | Required Value | Actual Runtime Value | Status |
| :--- | :--- | :--- | :---: |
| **Target Commit** | `<COMMIT_SHA>` | `<ACTUAL_SHA>` | ✅ MATCH |
| **Working Tree** | Clean | Clean (0 modified / 0 untracked) | ✅ CLEAN |
| **Automated Suite** | 100% Pass | 601 / 601 Passed | ✅ PASS |
| **QA Sign-off Status**| READY FOR GM/PM | Verified via QA-00x | ✅ SATISFIED |

---

## 3. Invariant & Experiential Audit

| Invariant / Standard | Evaluation & Observations | Compliance |
| :--- | :--- | :---: |
| **Invariant 1: Prime Directive** | *"Build a world, not a feature list."* [Notes on world feel, coherence, immersion] | 🟢 / 🟡 / 🔴 |
| **Invariant 4: No Stamina** | [Verification that movement and tools have no stamina bar] | 🟢 COMPLIANT |
| **Invariant 6: Non-Lethal Defeat** | [Defeat returns to island with expedition loss, home safe] | 🟢 COMPLIANT |
| **Invariant 11: Cozy/Mystery Balance**| [Evaluating ~65% Cozy / 35% Adventure ratio] | 🟢 / 🟡 / 🔴 |
| **Invariant 12: Modern Pixel Art** | [Handcrafted clarity, lighting warmth, no visual noise] | 🟢 / 🟡 / 🔴 |
| **Domain Whitelist Authority** | [Zero unauthorized state mutations detected] | 🟢 COMPLIANT |

---

## 4. Gameplay & Feature Evaluation

### 4.1 [Feature / Mechanic Name]
* **Observation:** [Detailed notes on responsiveness, animations, feedback, sound cues]
* **Game Feel:** [Evaluation of pacing, weights, friction]
* **Friction Points:** [Any moments where the player felt confused or frustrated]

### 4.2 [Feature / Mechanic Name]
* **Observation:** ...
* **Game Feel:** ...
* **Friction Points:** ...

---

## 5. Identified Issues & Polish Items

| ID | Severity | Category | Description | Recommended Fix |
| :--- | :---: | :---: | :--- | :--- |
| **ISS-01** | Low / Med / High | Visual / Gameplay / Audio | [Description of issue] | [Recommended action] |

---

## 6. Action Items & Agent Assignments

- [ ] **[AI Agent Role: Gameplay / Systems]:** [Task description and target domain files]
- [ ] **[AI Agent Role: Presentation / Art]:** [Task description and target domain files]
- [ ] **[AI Agent Role: QA]:** [Verification criteria for subsequent pass]

---

## 7. Final Sign-off & Milestone Disposition

* **Milestone Progress:** [e.g. Phase 4 Milestone Approved / Blocked]
* **Next Authorized Task:** [Task title and target specification]
* **Sign-off:**  
  *Reviewer:* [Founder / Omni]  
  *Date:* YYYY-MM-DD  
  *Disposition:* **🟢 ACCEPTED & SIGNED OFF**
```
