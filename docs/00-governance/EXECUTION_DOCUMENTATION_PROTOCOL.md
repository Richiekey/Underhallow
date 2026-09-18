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

**Applies To:** Founder / Omni (Human Project Lead), Game Masters (GM), Product Managers (PM), Owning Domain Teams, Specialized Coding Agents, QA Engineers, and all Development Contributors  
**Repository:** `Richiekey/Underhallow`  
**Storage Path:** `docs/00-governance/EXECUTION_DOCUMENTATION_PROTOCOL.md`  

---

## 1. Purpose & Scope

The **Execution & Documentation Protocol (EDP-001)** is the authoritative operational protocol governing how work moves from requirement to accepted implementation, and how documentation, reports, and repository states remain strictly synchronized across Underhallow development.

This protocol establishes a durable operating system that synchronizes:

```text
GM / PM (Executive Direction, Scope Acceptance, & Synchronization)
   ↕
Owning Teams (Inspection, Analysis, Planning, Tasking, & Review)
   ↕
Coding Agents / Human (Implementation, Implementer Testing, & Reporting)
   ↕
QA (Independent Verification & Regression Auditing)
```

### 1.1 Non-Supersession & Governance Scope
`EDP-001` is an operational execution and synchronization protocol. It exists at **Level 4 (Implementation & Governance)** under the project authority of the [Agent Constitution (AC-001)](AGENT_CONSTITUTION.md) and [Master Specification Index (MSI-001)](MASTER_SPECIFICATION_INDEX.md).

> **Crucial Rule:** `EDP-001` governs the *process of work and documentation synchronization*. It does **not** redefine, weaken, or override Level 0–3 authoritative product, architecture, gameplay, world, narrative, or art specifications.

---

## 2. Governing Authority Boundaries

Development in Underhallow enforces strict separation of responsibilities:

```text
OWNING TEAMS
Inspect → Analyze → Plan → Task (Brief) → Review

CODING AGENT / HUMAN IMPLEMENTER
Implement → Test (Implementer) → Report → Commit

QA
Independently Verify (Independent Environment & Scenarios)

GM / PM
Coordinate → Review → Accept / Reject → Synchronize
```

### 2.1 The Direct Repository Modification Boundary
* **Owning Teams and GM/PM must never directly modify repository implementation artifacts** (`src/**`, `scenes/**`, `data/**`, `tests/**`, or engine configurations). Teams and GM/PM direct work through Inspection, Planning, Implementation Briefs, and Review.
* **Only Coding Agents or the Human Implementer** are authorized to modify repository implementation artifacts within their assigned domain whitelists.
* **QA independently verifies implementation** against specifications and briefs. QA never implements production code and never grants executive acceptance.
* **GM/PM provides executive coordination, acceptance decisions, and documentation synchronization**, but does not write production implementation code.

| Role | Authority Scope | Implementation Authority | Direct Repo Modification |
| :--- | :--- | :---: | :---: |
| **Founder / Human** | Ultimate Project & Product Authority | Complete | YES |
| **GM / PM** | Coordination, Scope Acceptance, & Sync | Governance / Briefs | NO (Direct code) |
| **Owning Teams** | Research, System Architecture, & Review | Specifications / Briefs | NO (Direct code) |
| **Coding Agents** | Implementation & Implementer Testing | Assigned Whitelist Only | YES (Authorized work) |
| **QA Engineers** | Independent Verification & Regression | Verification Reports | NO (Production code) |

---

## 3. The Canonical Work Lifecycle

Every development task in Underhallow must advance through the 11-stage canonical lifecycle:

```text
UNDERSTAND → INSPECT → CROSS-CHECK → PLAN → ASSIGN → IMPLEMENT → TEST → VERIFY → REPORT → ACCEPT → SYNCHRONIZE
```

### 3.1 Lifecycle Stage Responsibilities

1. **Understand:** The responsible team determines the actual requirement directly from authoritative specifications (Levels 0–3) and the current production plan.
2. **Inspect:** The team inspects the active repository, existing codebase, and relevant documentation to establish current ground truth.
3. **Cross-Check:** The team evaluates cross-cutting implications:
   * System ownership and domain whitelisting
   * Neighboring gameplay systems and state boundaries
   * Architectural contracts (state vs. representation)
   * Persistence, schema, and database implications
   * Multiplayer and dedicated server synchronization
   * QA testability and verification criteria
   * Documentation index and link integrity implications
4. **Plan:** The owning team authors the smallest safe implementation plan that satisfies the requirement without architectural drift.
5. **Assign:** The team or GM/PM authors a formal **Implementation Brief** for the coding agent or human implementer, establishing explicit scope, reference commits, constraints, and acceptance criteria.
6. **Implement:** The assigned coding agent or human implementer executes the work within their assigned domain whitelist. No unauthorized systems are touched.
7. **Test (Implementer):** The implementer executes relevant unit, integration, and headless runtime test suites, capturing actual execution metrics and output.
8. **Verify (Independent):** Owning teams inspect the code diff, and QA independently tests the build in an isolated verification pass, generating independent verification evidence.
9. **Report:** The implementer submits an Implementation Report, and QA submits an Independent Verification Report (e.g. `QA-00x`).
10. **Accept:** GM/PM reviews implementation and verification evidence against acceptance criteria, rendering an explicit disposition (`🟢 ACCEPTED`, `🟡 ACCEPTED WITH CONDITIONS`, `🔴 REJECTED`, or `🔄 RETEST REQUIRED`).
11. **Synchronize:** Documentation, status registries, MSI entries, and team tracking are brought into total agreement with the accepted implementation.

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

Every claim regarding work status must be supported by appropriate evidence. Underhallow recognizes five distinct evidence classes:

| Evidence Class | Produced By | Valid Artifact Examples | Invalid Substitutions |
| :--- | :--- | :--- | :--- |
| **1. Planning Evidence** | Owning Teams / GM | Team design specs, architecture plans, implementation briefs | Implementation claims, unreviewed chat notes |
| **2. Implementation Evidence** | Coding Agent / Human | Git commit SHA, git diff stat, modified file lists | Planned task lists, prompt briefs |
| **3. Implementer Test Evidence** | Coding Agent / Human | Test runner output, pass/fail counts, exit codes | Claims of "working correctly" without output |
| **4. Independent Verification Evidence** | QA Engineers / Independent Reviewer | Formal QA report (`QA-00x`), independent runtime logs, regression checklists | Implementer test logs, self-certifications |
| **5. Acceptance Evidence** | GM / PM / Founder | Formal GM Session Record (`GM_SESSION_*.md`), signed milestone disposition | QA PASS status, implementer completion notes |

Conflating these evidence classes—such as treating implementer test output as independent QA evidence, or claiming GM acceptance based solely on QA approval—is a direct governance violation.

---

## 6. Standard Reporting Protocol Chain

The canonical sequence of reporting artifacts follows this closed loop:

```text
1. Owning Team Inspection / Plan
           ↓
2. Implementation Brief (GM/PM or Team)
           ↓
3. Implementation Report (Coding Agent / Implementer)
           ↓
4. Owning Team Review
           ↓
5. QA Independent Verification Report (QA Team)
           ↓
6. GM Review Session & Acceptance Disposition (GSP-001)
           ↓
7. GM Post-Acceptance Report (Archival Record)
           ↓
8. Documentation Synchronization Commit
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
└── gm/               # Formal GM Session Records, Post-Acceptance Reports, & GSP-001
```

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

When executing work in the Underhallow repository, coding agents must adhere strictly to these 17 operational directives:

1. **Inspect Before Implementation:** Inspect the active codebase, MSI, and relevant specifications before proposing or writing code.
2. **Read Authoritative Specifications:** Base all work on the Master Specification Index and locked specifications, never on assumptions or conversational memory.
3. **Follow Domain Boundaries:** Adhere strictly to domain whitelists defined in the [Agent Constitution (AC-001)](AGENT_CONSTITUTION.md). Never touch `src/core/state/` or global schemas without an approved Architecture Plan.
4. **Follow the Implementation Brief:** Execute exactly what is authorized in the implementation brief. Do not add unrequested features or unsolicited refactorings.
5. **Preserve Architecture & Product Scope:** Never redefine system architecture, product pillars, or gameplay scope.
6. **Stop on Contradiction:** Stop and escalate immediately if requirements, specifications, or architectural patterns contradict one another.
7. **Implement Only Authorized Work:** Confine all changes strictly to the assigned task.
8. **Run Appropriate Tests:** Always execute the relevant test suites (e.g. `godot --headless -s tests/core/test_runner.gd`) after making changes.
9. **Report Actual Test Evidence:** Document exact test counts, pass/fail numbers, and exit codes. Never claim tests passed without executing them.
10. **Report Changed Files:** Provide an exhaustive list of all modified, created, and deleted files.
11. **Report Documentation Changes:** Detail all updates to specifications, MSI registries, and index documents.
12. **Report Risks & Blockers:** Disclose any technical debt, architectural friction, performance concerns, or follow-up risks.
13. **Distinguish Implementation from QA:** Never represent implementer test results as independent QA verification.
14. **Commit Completed Work Separately:** Create focused git commits with descriptive messages conforming to repository standards, separating documentation from runtime code.
15. **Provide Commit Hash:** Provide the exact commit SHA to the requesting team upon completion.
16. **Never Claim QA or GM Acceptance:** A coding agent can only state what was implemented and tested; acceptance is the sole prerogative of GM/PM.
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
