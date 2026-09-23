# Underhallow — GM2 Reporting & Coordination Archive

**Authority:** GM2 — Claude Opus 4.6 (Execution Planning & Coordination GM)  
**Parent Specifications:**
* [Agent Constitution V1.0 (AC-001)](../../00-governance/AGENT_CONSTITUTION.md)
* [Execution & Documentation Protocol V1.0 (EDP-001)](../../00-governance/EXECUTION_DOCUMENTATION_PROTOCOL.md)
* [GM Session Record Protocol V1.0 (GSP-001)](../gm/GM_SESSION_RECORD_PROTOCOL.md)
* [Master Specification Index & Build Governance V1.1 (MSI-001)](../../00-governance/MASTER_SPECIFICATION_INDEX.md)

---

## 1. Purpose & Scope

This directory serves as the durable repository storage and communication layer for **GM2 — Claude Opus 4.6** within the Underhallow multi-agent development workflow.

In accordance with [EDP-001 §18](../../00-governance/EXECUTION_DOCUMENTATION_PROTOCOL.md), GM2 is the execution-planning, deep repository-inspection, brief-authoring, and coordination layer. This directory houses:
1. **GM2 Planning Records:** Session planning, dependency analyses, and repository inspection audits.
2. **GM2 Implementation Briefs (Archived):** Permanent records of implementation briefs authored for Gemini or authorized coding agents.
3. **GM2 Coordination & Review Reports:** Structured reports submitted to **GM1 (ChatGPT)** summarizing completed implementation cycles, QA verification statuses, open blockers, cross-team dependencies, and recommendations for canonical GM1 acceptance.

---

## 2. Directory Separation & Invariant Boundaries

* **`docs/08-reports/gm/`** is reserved exclusively for **GM1 (ChatGPT) / Founder** formal GM Session Records, milestone gates, and post-acceptance synchronization records ([GSP-001](../gm/GM_SESSION_RECORD_PROTOCOL.md)).
* **`docs/08-reports/gm2/`** is reserved for **GM2 (Claude Opus 4.6)** execution planning, coordination records, and reporting back to GM1.
* Neither GM2 nor Gemini may declare GM1 acceptance. GM2 reports record facts, review statuses, and recommendations, preserving the strict governance boundary where canonical acceptance is the exclusive prerogative of GM1 (or the Human Project Authority).

---

## 3. Naming Conventions

All artifacts committed to this directory must adhere to standard repository naming conventions:

* **GM2 Planning Records:** `GM2_PLAN_<YYYYMMDD>_<TOPIC_SLUG>.md`
  * *Example:* `GM2_PLAN_20260925_MINING_SYSTEM_SLICE.md`
* **GM2 Coordination / Review Reports to GM1:** `GM2_REPORT_<YYYYMMDD>_<TOPIC_SLUG>.md`
  * *Example:* `GM2_REPORT_20260925_CLEMENTINE_FOLLOWUP.md`
* **GM2 Archived Implementation Briefs:** `GM2_BRIEF_<TASK_ID>_<TOPIC_SLUG>.md`
  * *Example:* `GM2_BRIEF_TSK-042_TERRAIN_COLLISION.md`

All committed internal links must use standard **repository-relative paths** in accordance with [EDP-001 §14](../../00-governance/EXECUTION_DOCUMENTATION_PROTOCOL.md). Machine-specific absolute paths are strictly prohibited.
