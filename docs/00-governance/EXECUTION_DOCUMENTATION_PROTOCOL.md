# UNDERHALLOW — EXECUTION & DOCUMENTATION PROTOCOL

## Team Synchronization, Evidence Classification, & Operational Governance

**Document ID:** EDP-001  
**Status:** APPROVED (Project Governance Baseline)  
**Authority Level:** Level 4 — Implementation & Governance Protocol  
**Parent Specifications:**  
* [Underhallow Agent Constitution V1.0 (AC-001)](AGENT_CONSTITUTION.md)  
* [Master Specification Index & Build Governance V1.1 (MSI-001)](MASTER_SPECIFICATION_INDEX.md)  
* [Underhallow North Star V1.0 (NS-001)](../01-product/NORTH_STAR.md)  
* [Underhallow Production Plan & Vertical Slice Roadmap V1.0 (PP-001)](../01-product/PRODUCTION_PLAN.md)  

**Applies To:** Founder / Omni (Human Project Lead), GM1 — ChatGPT (Canonical Project Authority & Acceptance), GM2 — Claude Opus 4.6 (Execution Planning & Coordination GM), Owning Domain Teams, Specialized Coding Agents (Gemini & authorized implementers), QA Engineers, and all Development Contributors  
**Repository:** `Richiekey/Underhallow`  
**Storage Path:** `docs/00-governance/EXECUTION_DOCUMENTATION_PROTOCOL.md`  

---

## 1. Purpose & Scope

The **Execution & Documentation Protocol (EDP-001)** is the authoritative operational protocol governing how work moves from requirement to accepted implementation, and how documentation, reports, and repository states remain strictly synchronized across Underhallow development.

This protocol establishes a durable operating system that synchronizes:

```text
Founder / Human (Ultimate Project & Product Authority)
       ↕
GM1 — ChatGPT (Canonical Command, Cross-Team Coordination, & Acceptance)
       ↕
GM2 — Claude Opus 4.6 (Detailed Planning, Deep Inspection, Implementation Briefs, & Coordination)
       ↕
Owning Teams (Domain Thinking, System Architecture, Requirements, & Design Review)
       ↕
Gemini / Authorized Coding Agents / Human (Implementation, Implementer Testing, & Reporting)
       ↕
QA (Independent Verification & Regression Auditing)
```

### 1.1 Non-Supersession & Governance Scope
`EDP-001` is an operational execution and synchronization protocol. It exists at **Level 4 (Implementation & Governance)** under the project authority of the [Agent Constitution (AC-001)](AGENT_CONSTITUTION.md) and [Master Specification Index (MSI-001)](MASTER_SPECIFICATION_INDEX.md).

> **Crucial Rule:** `EDP-001` governs the *process of work and documentation synchronization*. It does **not** redefine, weaken, or override Level 0–3 authoritative product, architecture, gameplay, world, narrative, or art specifications.

---

## 2. Governing Authority Boundaries

Development in Underhallow enforces strict separation of responsibilities across the multi-agent development organization:

```text
HUMAN / FOUNDER
Ultimate Project Authority → Product Direction → Final Arbiter

GM1 — CHATGPT
Canonical Project Coordination → Specification Interpretation → Accept / Reject → Direct Synchronization

GM2 — CLAUDE OPUS 4.6
Deep Repository Inspection → Execution Planning → Implementation Brief Authoring → Coordination & Escalation

OWNING TEAMS
Domain Thinking → Research → System Architecture → Design Review

GEMINI / CODING AGENT / HUMAN IMPLEMENTER
Implementation → Implementer Testing → Commit → Implementation Report

QA
Independent Verification (Isolated Environments & Dedicated Runtime Scenarios)
```

### 2.1 The Direct Repository Modification Boundary
* **Owning Teams, GM1, and GM2 must never directly modify repository implementation artifacts** (`src/**`, `scenes/**`, `data/**`, `tests/**`, or engine configurations). They direct work strictly through Inspection, Planning, Implementation Briefs, and Review.
* **Only Coding Agents or the Human Implementer** are authorized to modify repository implementation artifacts within their assigned domain whitelists. Gemini is the designated coding agent for this workflow; other coding agents or the human may implement when explicitly authorized.
* **QA independently verifies implementation** against specifications and briefs. QA never implements production code, never repairs implementation defects, and never grants executive acceptance.
* **GM1 provides canonical executive coordination, acceptance decisions, and documentation synchronization**, but does not write production implementation code.
* **GM2 provides execution planning, repository inspection, brief authoring, and report review**, but never writes implementation code and never declares GM1 acceptance.

| Role | Operational Scope | Implementation Authority | Direct Repo Modification |
| :--- | :--- | :---: | :---: |
| **Founder / Human** | Ultimate Project & Product Authority | Complete | YES |
| **GM1 — ChatGPT** | Canonical Coordination, Scope Acceptance, & Sync | Governance / Briefs / Sync | NO (Direct code) |
| **GM2 — Claude Opus 4.6** | Execution Planning, Deep Inspection, Briefs & Review | Governance / Plans / Briefs | NO (Direct code) |
| **Owning Teams** | Research, Domain Architecture, & Design Review | Specifications / Requirements | NO (Direct code) |
| **Gemini / Coding Agents** | Implementation & Implementer Testing | Assigned Whitelist Only | YES (Authorized work) |
| **QA Engineers** | Independent Verification & Regression | Verification Reports | NO (Production code) |

---

## 3. The Canonical Work Lifecycle

Every development task in Underhallow advances through the formal multi-agent lifecycle:

```text
HUMAN
  │
  ▼
GM1 — ChatGPT
Canonical command / project coordination / acceptance
  │
  ▼
GM2 — Claude Opus 4.6
Detailed planning / repository inspection / implementation briefs
  │
  ▼
Gemini / Authorized Coding Agent
Repository implementation within domain whitelists
  │
  ▼
Implementer Testing
Unit, integration, and headless test suite execution
  │
  ▼
Owning Team Review
Domain design & architectural conformance review
  │
  ▼
QA Independent Verification
Isolated runtime verification scenarios (QA-00x)
  │
  ▼
GM2 Review / Coordination Report
Evidence review, defect routing, escalation, and synthesis to GM1
  │
  ▼
GM1 Final Acceptance
GSP-001 review session and formal disposition
  │
  ▼
Synchronization
Permanent documentation, MSI, and status synchronization
```

### 3.1 Lifecycle Stage Responsibilities

1. **Understand (GM1 / Team):** The responsible team or GM1 determines the actual requirement directly from authoritative specifications (Levels 0–3) and the current production plan.
2. **Inspect (GM2):** GM2 performs deep inspection of the active repository, existing codebase, git status, and relevant documentation to establish current ground truth before authoring briefs.
3. **Cross-Check (GM2 / Team):** GM2 and owning teams evaluate cross-cutting implications:
   * System ownership and domain whitelisting
   * Neighboring gameplay systems and state boundaries
   * Architectural contracts (state vs. representation)
   * Persistence, schema, and database implications
   * Multiplayer and dedicated server synchronization
   * QA testability and verification criteria
   * Documentation index and link integrity implications
4. **Plan (GM2 / Team):** GM2 authors a detailed implementation plan and records planning decisions in `docs/08-reports/gm2/`.
5. **Brief (GM2):** GM2 authors a formal **Implementation Brief** conforming to §16 for Gemini (or authorized coding agent), establishing explicit scope, reference commits, constraints, acceptance criteria, and tests.
6. **Implement (Gemini / Implementer):** The assigned coding agent or human implementer executes the work strictly within their assigned domain whitelist. No unauthorized systems are touched.
7. **Test (Implementer):** The implementer executes relevant unit, integration, and headless runtime test suites, capturing actual execution metrics and output.
8. **Review (Owning Team):** The owning domain team inspects the code diff for architectural and design conformance.
9. **Verify (Independent QA):** QA independently verifies the build in an isolated verification scenario, generating independent verification evidence (`QA-00x`). QA never repairs implementation code.
10. **Coordinate & Report (GM2):** GM2 reviews the implementation report, team review, and QA verification evidence, preparing a structured review report for GM1 conforming to §18.
11. **Accept (GM1):** GM1 reviews all evidence against acceptance criteria under [GSP-001](../08-reports/gm/GM_SESSION_RECORD_PROTOCOL.md), rendering an explicit disposition (`🟢 ACCEPTED`, `🟡 ACCEPTED WITH CONDITIONS`, `🔴 REJECTED`, or `🔄 RETEST REQUIRED`). GM2 cannot declare acceptance.
12. **Synchronize (GM1 / Coding Agent):** Documentation, status registries, MSI entries, and team tracking are brought into total agreement with the accepted implementation.

---

## 4. Formal Execution State Model

Every feature, task, or surgical pass exists in exactly one execution state:

```text
PLANNED
   ↓
TASKED
   ↓
IMPLEMENTING
   ↓
IMPLEMENTED
   ↓
IMPLEMENTER-TESTED
   ↓
TEAM-REVIEWED
   ↓
QA-VERIFIED
   ↓
GM-ACCEPTED
   ↓
DOCUMENTED / SYNCHRONIZED
```

### 4.1 State Definitions
* **`PLANNED`:** A requirement has been identified and scheduled, but no implementation brief has been issued.
* **`TASKED`:** An implementation brief has been authored and assigned to an implementer.
* **`IMPLEMENTING`:** The implementer is actively drafting code or documentation.
* **`IMPLEMENTED`:** Code modifications are complete and compiled, but implementer test runs have not been concluded.
* **`IMPLEMENTER-TESTED`:** The implementer has successfully run internal tests and verified the feature runs without local regressions.
* **`TEAM-REVIEWED`:** The owning domain team has reviewed the implementation diff for design conformance.
* **`QA-VERIFIED`:** An independent QA pass has executed runtime verification and generated a formal QA report.
* **`GM-ACCEPTED`:** GM/PM has reviewed all evidence and formally accepted the milestone or slice.
* **`DOCUMENTED / SYNCHRONIZED`:** All specifications, MSI registries, and report records are updated and committed.

### 4.2 Immutable Non-Conflation Axioms
Underhallow strictly enforces four non-conflation axioms:

$$\text{PLANNED} \neq \text{IMPLEMENTED}$$
$$\text{IMPLEMENTED} \neq \text{TESTED}$$
$$\text{TESTED} \neq \text{QA-VERIFIED}$$
$$\text{QA-VERIFIED} \neq \text{GM-ACCEPTED}$$

* A plan must **never** be cited as proof of implementation.
* Completed code must **never** be assumed working without test execution evidence.
* Implementer test passes must **never** be cited as independent QA verification.
* A passing QA report must **never** be assumed to constitute GM/PM acceptance.

---

## 5. Formal Evidence Model

Every claim regarding work status must be supported by appropriate evidence. Underhallow recognizes distinct evidence classes:

| Evidence Class | Produced By | Valid Artifact Examples | Invalid Substitutions |
| :--- | :--- | :--- | :--- |
| **1. Planning Evidence** | GM2 / Owning Teams | GM2 planning records (`docs/08-reports/gm2/`), team design specs, architecture plans | Implementation claims, unreviewed chat notes |
| **2. Tasking Evidence** | GM2 / GM1 / Team | Formal Implementation Briefs conforming to §16 | Informal prompts, verbal instructions |
| **3. Implementation Evidence** | Coding Agent / Human | Git commit SHA, git diff stat, modified file lists | Planned task lists, brief requirements |
| **4. Implementer Test Evidence** | Coding Agent / Human | Test runner output, pass/fail counts, exit codes | Claims of "working correctly" without output |
| **5. Team Review Evidence** | Owning Domain Team | Design conformance notes, architectural sign-off | Implementer self-assessment |
| **6. Independent Verification Evidence** | QA Engineers | Formal QA report (`QA-00x`), isolated runtime logs, regression checklists | Implementer test logs, self-certifications |
| **7. Coordination Evidence** | GM2 — Claude Opus 4.6 | GM2 Coordination / Review Reports to GM1 conforming to §18 | Acceptance claims, QA replacements |
| **8. Acceptance Evidence** | GM1 — ChatGPT / Founder | Formal GM Session Record (`GM_SESSION_*.md`), signed milestone disposition | QA PASS status, GM2 review notes |

Conflating these evidence classes—such as treating implementer test output as independent QA evidence, or claiming GM acceptance based on GM2 review or QA approval—is a direct governance violation.

### 5.1 Explicit Status Attribution
In accordance with Underhallow governance, reports must provide **explicit status attribution** indicating which canonical states have actually occurred for that task or session:
$$\text{Planned} \rightarrow \text{Implemented} \rightarrow \text{Implementer-Tested} \rightarrow \text{Team-Reviewed} \rightarrow \text{QA-Verified} \rightarrow \text{GM-Accepted} \rightarrow \text{Documented/Synchronized}$$
A report must explicitly identify its active status without artificially forcing unperformed lifecycle stages into the record.

---

## 6. Standard Reporting Protocol Chain

The canonical sequence of reporting artifacts follows this durable closed loop:

```text
1. Team Session Assignment / Requirement
           ↓
2. GM2 Repository Inspection & Detailed Plan (docs/08-reports/gm2/)
           ↓
3. GM2 Implementation Brief (GM2 → Gemini)
           ↓
4. Gemini Implementation Report (Gemini → Repository)
           ↓
5. Owning Team Review
           ↓
6. QA Independent Verification Report (docs/08-reports/qa/QA-00x.md)
           ↓
7. GM2 Coordination & Review Report (docs/08-reports/gm2/GM2_REPORT_*.md → GM1)
           ↓
8. GM1 Review Session & Acceptance Disposition (GSP-001)
           ↓
9. GM1 Post-Acceptance Report (docs/08-reports/gm/GM_SESSION_*.md)
           ↓
10. Documentation Synchronization Commit
```

---

## 7. GM Post-Acceptance Report Protocol

Following every meaningful accepted implementation or milestone gate, the GM/PM creates (or directs the creation of) a permanent post-acceptance reporting artifact for repository archival in `docs/08-reports/gm/`.

### 7.1 Required Structure
The post-acceptance report must explicitly distinguish six categories of reality:

1. **Planned:** What the team originally requested in the implementation brief.
2. **Implemented:** What the coding agent or human actually changed in the commit.
3. **Tested:** What tests the implementer actually executed, including test counts and exit codes.
4. **Independently Verified:** What QA or independent reviewers verified in runtime testing.
5. **Accepted:** What GM/PM explicitly accepted for production integration.
6. **Remaining:** Anything intentionally deferred, constrained, or remaining for future passes.

### 7.2 Mandatory Report Metadata
Every post-acceptance report must record:
* Session Identifier (e.g., `GM-YYYYMMDD-###`)
* Feature / Milestone Identifier
* Target Implementation Commit SHA and Parent Commit SHA
* Participating Teams and Implementer Identity
* Implementer Test Evidence Summary
* Independent QA Verification Reference
* Explicit Acceptance Decision (`🟢 ACCEPTED`, `🟡 ACCEPTED WITH CONDITIONS`, etc.)
* Explicit list of remaining limitations and follow-up tasks
* Relevant parent and downstream specifications

---

## 8. Report Storage Locations

All reporting artifacts must reside strictly in their designated categorized reporting directories:

```text
docs/08-reports/
├── qa/               # Independent QA execution reports (QA-001, QA-002, etc.)
├── architecture/     # Architectural audits, boundary reviews, and state audits
├── gameplay/         # Gameplay balance logs, tuning notes, and playtest audits
├── infrastructure/   # Server load tests, deployment audits, and DB migrations
├── narrative/        # Story consistency audits and dialogue reviews
├── world/            # Level geometry, collision, and coordinate validation logs
├── gm/               # Formal GM1 Session Records, Post-Acceptance Reports, & GSP-001
└── gm2/              # GM2 Planning Records, Archived Briefs, & Review Reports to GM1
```

* **`docs/08-reports/gm/`** is reserved exclusively for **GM1 (ChatGPT) / Founder** formal GM Session Records, milestone gates, and post-acceptance synchronization records ([GSP-001](../08-reports/gm/GM_SESSION_RECORD_PROTOCOL.md)).
* **`docs/08-reports/gm2/`** is reserved for **GM2 (Claude Opus 4.6)** execution planning records, archived implementation briefs, and coordination reports to GM1.
* Design specifications must **never** be placed in `docs/08-reports/`.
* Reports must **never** be placed in flat root directories or mixed with specification bibles.

---

## 9. Reconciliation with GSP-001

[GSP-001 (GM Session Record Protocol)](../08-reports/gm/GM_SESSION_RECORD_PROTOCOL.md) and `EDP-001` are complementary governance documents with distinct jurisdictions:

* **`GSP-001` governs the Game Master Review Session:** It defines how experiential playtests, creative audits against North Star invariants (Invariant 1, Invariant 11, etc.), and executive sign-off meetings are conducted and logged.
* **`EDP-001` governs the Overall Execution & Synchronization Lifecycle:** It defines the cross-team progression of work from requirement to implementation, evidence classification, state transitions, and repository documentation synchronization.

`GSP-001` review sessions operationalize Stage 10 (**Accept**) of the `EDP-001` lifecycle. Neither protocol may contradict the other.

---

## 10. Operational Directives for Coding Agents

When executing work in the Underhallow repository, coding agents (including designated implementation agent Gemini and any authorized implementers) must adhere strictly to these 17 operational directives:

1. **Inspect Before Implementation:** Inspect the active codebase, MSI, and relevant specifications before proposing or writing code.
2. **Read Authoritative Specifications:** Base all work on the Master Specification Index and locked specifications, never on assumptions or conversational memory.
3. **Follow Domain Boundaries:** Adhere strictly to domain whitelists defined in the [Agent Constitution (AC-001)](AGENT_CONSTITUTION.md). Never touch `src/core/state/` or global schemas without an approved Architecture Plan.
4. **Follow the Implementation Brief:** Execute exactly what is authorized in the implementation brief authored by GM2 (or GM1/Team). Do not add unrequested features or unsolicited refactorings.
5. **Preserve Architecture & Product Scope:** Never redefine system architecture, product pillars, or gameplay scope.
6. **Stop on Contradiction:** Stop and escalate immediately if requirements, specifications, or architectural patterns contradict one another.
7. **Implement Only Authorized Work:** Confine all changes strictly to the assigned task.
8. **Run Appropriate Tests:** Always execute the relevant test suites (e.g. `godot --headless -s tests/core/test_runner.gd`) and record actual test metrics after making changes.
9. **Report Actual Test Evidence:** Document exact test counts, pass/fail numbers, and exit codes. Never claim tests passed without executing them.
10. **Report Changed Files:** Provide an exhaustive list of all modified, created, and deleted files.
11. **Report Documentation Changes:** Detail all updates to specifications, MSI registries, and index documents.
12. **Report Risks & Blockers:** Disclose any technical debt, architectural friction, performance concerns, or follow-up risks.
13. **Distinguish Implementation from QA:** Never represent implementer test results as independent QA verification.
14. **Commit Completed Work Separately:** Create focused git commits with descriptive messages conforming to repository standards, separating documentation from runtime code.
15. **Provide Commit Hash:** Provide the exact commit SHA to GM2 / GM1 upon completion.
16. **Never Claim QA or GM Acceptance:** A coding agent can only state what was implemented and tested; acceptance is the sole prerogative of GM1 (or Human Project Authority).
17. **Current Repository is Ground Truth:** Never treat past conversations, outdated reports, or temporary scratch files as authoritative over the active repository.

---

## 11. Documentation Authority Hierarchy

When evaluating requirements, development decisions follow this strict hierarchy:

```text
1. Human Project Authority (Founder / Omni)
       ↓
2. Agent Constitution (AC-001)
       ↓
3. Master Specification Index (MSI-001)
       ↓
4. Authoritative Specifications (Levels 0–3)
       ↓
5. Governance & Execution Protocols (EDP-001, GSP-001)
       ↓
6. Implementation Briefs & Task Plans
       ↓
7. Implementation Code & Assets
       ↓
8. Reports & Evidence Artifacts
```

* An implementation brief cannot override an authoritative specification.
* A report records history; it cannot retroactively authorize an unapproved architecture change.

---

## 12. Specification Integrity & Immutability

* **Locked Specifications:** Specifications marked `LOCKED` (e.g. `NS-001`, `CG-001`) represent immutable project foundations. They cannot be altered without formal Founder review.
* **Approved Specifications:** Specifications marked `APPROVED` can only evolve through formal reconciliation passes.
* **No Implementation Rewrites:** Implementation difficulty is **never** a valid justification for rewriting a specification requirement. If implementation encounters difficulty, escalate to the owning team.
* **Draft Specifications:** Evolve through structured team review and MSI registration.

---

## 13. Documentation Synchronization Model

Documentation synchronization is a first-class project state (`DOCUMENTED / SYNCHRONIZED`).

Following every accepted implementation:

$$\text{Implementation} \longleftrightarrow \text{Specification} \longleftrightarrow \text{MSI} \longleftrightarrow \text{Reports} \longleftrightarrow \text{Production Plan}$$

### 13.1 Synchronization Rule
> **Update every repository artifact whose truth, status, ownership, dependency, or implementation state was altered by the accepted work.**

* Avoid unnecessary documentation churn: do not rewrite specifications merely for stylistic consistency.
* Maintain link integrity: ensure all newly added or moved files are registered in [MSI-001](MASTER_SPECIFICATION_INDEX.md) and [docs/README.md](../README.md).

---

## 14. Repository-Relative Linking Standards

To ensure documentation remains fully portable across different developer machines, operating systems, and remote repositories:

* **Prohibited:** Machine-specific paths such as `file:///C:/Users/...`, `file:///c:/Users/...`, or absolute Windows drive letters `C:\...` are strictly forbidden in committed documentation navigation links.
* **Mandatory:** All internal documentation links must use standard **repository-relative paths** resolving from the source document to the target document:
  ```markdown
  <!-- Example from docs/00-governance/ -->
  [North Star](../01-product/NORTH_STAR.md)

  <!-- Example from docs/README.md -->
  [Agent Constitution](00-governance/AGENT_CONSTITUTION.md)

  <!-- Example from AGENTS.md -->
  [North Star](docs/01-product/NORTH_STAR.md)
  ```
* **Historical Terminal Output Exception:** Historical terminal logs in QA reports (e.g. `PS C:\Users\...` command output) record verbatim runtime evidence and must be preserved as historical artifacts, not rewritten.

---

## 15. Session Assignment Standard

Every team session assignment authored by GM1, GM2, or Owning Teams must adhere to this standardized schema, ensuring complete contextual continuity:

```markdown
# Underhallow — Team Session Assignment

**Session ID:** SES-YYYYMMDD-###  
**Team:** [e.g., Gameplay Systems / World Architecture / Narrative / Infrastructure]  
**Assignment:** [Short descriptive title]  
**Assignment Authority:** [GM1 — ChatGPT / GM2 — Claude Opus 4.6 / Human]  
**Status:** [PLANNED / TASKED / IN PROGRESS / COMPLETED]  

### 1. Objective
[Concise description of the objective and desired outcome.]

### 2. Relevant Specifications
* [Spec Title (ID)](../relative/path/to/spec.md)

### 3. Current Implementation State
[Actual state of repository implementation discovered during active inspection.]

### 4. Dependencies & Constraints
* **Dependencies:** [Upstream systems or prerequisites]
* **Constraints:** [Domain boundaries, architecture invariants, persistence limits]

### 5. Expected Deliverables
* [Deliverable 1]
* [Deliverable 2]

### 6. Acceptance Criteria
1. [Observable requirement 1]
2. [Observable requirement 2]

### 7. Required Tests
* [Test command / scenario 1]

### 8. Known Risks & Technical Debt
* [Risk or technical debt to monitor]

### 9. Documentation Requirements
* [Index updates, MSI updates, or permanent records required]
```

---

## 16. GM2 Implementation Brief Standard

Every non-trivial implementation brief authored by **GM2 — Claude Opus 4.6** for Gemini (or authorized coding agent) must contain the following mandatory 13 sections:

```markdown
# UNDERHALLOW — GM2 CODING AGENT IMPLEMENTATION BRIEF

**Task ID:** TSK-###  
**Session ID:** SES-YYYYMMDD-###  
**Prepared by:** GM2 — Claude Opus 4.6  
**Implementation Owner:** Gemini (or authorized coding agent / human)  
**Planning Authority:** GM2 — Claude Opus 4.6  
**Canonical Project Authority:** GM1 — ChatGPT  
**Date:** YYYY-MM-DD  
**Status:** APPROVED FOR IMPLEMENTATION  

---

## 1. Objective
[Exactly what the implementer is expected to accomplish.]

## 2. Owner & Affected Teams
* **Implementation Owner:** Gemini (Designated Coding Agent)
* **Affected Teams:** [List of affected domain teams]

## 3. Relevant Specifications
* [Authoritative Specification](../relative/path/to/spec.md) (Inspected prior to brief authoring)

## 4. Current Implementation Context
[Ground truth discovered via active repository inspection; never conversational assumptions.]

## 5. Required Changes
[Concrete, itemized implementation requirements.]

## 6. Constraints & Domain Boundaries
* Domain whitelist: [Allowed directories per AC-001]
* Preserved invariants: [Applicable invariants from AGENTS.md]
* Direct modification rule: [Restricted directories]

## 7. Expected Files / Systems
* [Target files expected to be created or modified]

## 8. Must Not Change
* [Explicit out-of-scope files, systems, contracts, or behavior]

## 9. Acceptance Criteria
1. [Observable criterion 1]
2. [Observable criterion 2]

## 10. Required Tests
* Implementer test command: [e.g., godot --headless -s tests/core/test_runner.gd]
* Link verification command: [Portable repository relative check]

## 11. Dependencies
* [Upstream/downstream coordination dependencies]

## 12. Known Risks
* [Known technical, architectural, or performance risks]

## 13. Documentation Requirements
* [Implementation report, MSI update, or walkthrough required]
```

---

## 17. Report Attribution & Implementation Reporting Standard

To ensure agent responsibilities and evidence chains are fully auditable, all implementation reports submitted by Gemini or authorized implementers must provide explicit status attribution:

```markdown
# IMPLEMENTATION REPORT

**Task ID:** TSK-###  
**Session ID:** SES-YYYYMMDD-###  
**Planned by:** GM2 — Claude Opus 4.6  
**Implemented by:** Gemini (Designated Coding Agent)  
**Implementation Commit:** `<COMMIT_SHA>`  

### Canonical Status Attribution
* **Planned:** YES (Brief TSK-###)
* **Implemented:** YES (Commit `<COMMIT_SHA>`)
* **Implementer-Tested:** YES (Exit code 0, X tests passed)
* **Team-Reviewed:** [PENDING / REVIEWED by Owning Team]
* **QA-Verified:** [PENDING QA REVIEW / VERIFIED in QA-00x]
* **GM-Accepted:** [PENDING GM1 REVIEW / ACCEPTED by GM1]

### 1. Implemented Changes
* Exhaustive list of created, modified, and deleted files with rationale.

### 2. Implementer Test Evidence
* Actual command executed: `godot --headless -s tests/core/test_runner.gd`
* Total tests executed, pass count, fail count, and exit code.

### 3. Link & Documentation Validation
* Portable link validation command output confirming 0 broken links and 0 machine-specific paths.

### 4. Risks, Blockers, & Follow-up Items
* Technical debt, friction, or unresolved edge cases disclosed.
```

---

## 18. GM2 Reporting to GM1 Standard

When GM2 — Claude Opus 4.6 completes a planning, briefing, or implementation review cycle, it authors a structured report in `docs/08-reports/gm2/` communicating status and recommendations to **GM1 — ChatGPT**:

```markdown
# UNDERHALLOW — GM2 COORDINATION & REVIEW REPORT

**Report ID:** GM2-REP-YYYYMMDD-###  
**Session / Task ID:** SES-YYYYMMDD-### / TSK-###  
**Author:** GM2 — Claude Opus 4.6  
**Addressed To:** GM1 — ChatGPT (Canonical Project Authority)  
**Date:** YYYY-MM-DD  
**Topic:** [e.g., Clementine Harvest Provenance Implementation Review]  

---

## 1. Executive Summary
[High-level overview of the cycle: what was planned, what was implemented, and current status.]

## 2. Repository Areas & Specifications Inspected
* **Specifications Inspected:** [List of relative spec links]
* **Codebase Surfaces Inspected:** [List of inspected directories/files]

## 3. Implementation Status (Reported Facts)
* **Implementer:** Gemini
* **Commit SHA:** `<COMMIT_SHA>`
* **Files Modified:** [List of files]
* **Implementer Tests Reported:** [Exact test counts and exit codes reported]

## 4. Owning Team Review Status
* [Summary of domain team findings, or PENDING]

## 5. Independent QA Verification Status
* **QA Report Reference:** [e.g., docs/08-reports/qa/QA-004.md or PENDING QA]
* **QA Findings:** [Summary of independent QA results]

## 6. Open Blockers & Cross-Team Dependencies
* [Active blockers, domain boundary conflicts, or inter-team dependencies]

## 7. Escalations & Items Requiring Decision
* **Items Requiring GM1 Decision:** [Ambiguities, scope questions, or acceptance recommendations]
* **Items Requiring Human Decision:** [Product or high-level architecture decisions]

## 8. GM2 Recommendations (Explicitly Distinguished from Facts)
* [GM2 recommendation on acceptance disposition: 🟢 ACCEPT, 🟡 ACCEPT WITH CONDITIONS, 🔴 REJECT, or 🔄 RETEST]
* [Recommended follow-up tasks for upcoming briefs]
```

> **Mandatory Rule:** GM2 reports must strictly distinguish **reported facts** from **GM2 recommendations**. GM2 must never represent an unverified implementer report as QA verification, and must never declare GM1 acceptance.

---

## 19. Escalation Rules Matrix

When ambiguity, conflicts, or roadblocks arise during planning or implementation, GM2, Gemini, and Owning Teams must adhere strictly to the following escalation criteria:

| Trigger Condition | Escalation Target | Required Action |
| :--- | :---: | :--- |
| Ownership or domain boundaries are ambiguous | **GM1** | STOP work; request GM1 domain assignment. |
| Two owning teams have conflicting requirements | **GM1** | Present conflict; request GM1 architectural ruling. |
| Implementation conflicts with accepted architecture | **GM1** | STOP implementation; escalate architectural discrepancy. |
| Authoritative specifications conflict | **GM1** | Escalate contradictory requirements for reconciliation. |
| Product scope or feature requirement is unclear | **GM1** | Request scope clarification before briefing coding agent. |
| New architectural pattern or system is required | **GM1** | Draft proposal; await GM1 approval before tasking. |
| Implementation brief requires modifying locked spec | **GM1** | Escalate to GM1 for formal reconciliation review. |
| QA verification evidence contradicts implementer report | **GM1** | Route defect to GM1/Team; do not silently re-implement. |
| Product vision, theme, or core invariant decision required | **Human** | Escalate directly to Project Owner / Founder. |
| Architectural impasse unresolvable via existing authority | **Human** | Escalate to Project Owner for executive determination. |
| Previously accepted project baseline must be overridden | **Human** | Require explicit Human Project Authority approval. |
| Governance, Constitution, or MSI hierarchy alteration | **Human** | Require explicit Human Project Authority authorization. |

> **Stop & Escalate Axiom:** If any trigger condition above is met, agents must **STOP → REPORT BLOCKER → ESCALATE**. Neither GM2 nor Gemini may invent unauthorized solutions.
