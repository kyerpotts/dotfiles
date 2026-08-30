---
name: job-management
description: Interactive router for job-application work.
disable-model-invocation: true
---

# Job management

Read [the workflow graph](references/WORKFLOW.md), then ask what the user wants to do.

Use a structured question with these first-level choices:

1. **Full application** — assess fit, prepare required documents, review, and optionally archive.
2. **Draft document** — resume, selection criteria, or cover letter.
3. **Assess role** — requirement extraction, evidence mapping, and gap analysis.
4. **Manage evidence** — capture an achievement or finalise/archive an application.

If the user selects a category containing several workflows, ask one follow-up question and then read only the selected workflow skill:

- Full application → `workflows/full-application/SKILL.md`
- Assess role → `workflows/fit-analysis/SKILL.md`
- Capture achievement → `workflows/achievement-capture/SKILL.md`
- Resume → `workflows/resume/SKILL.md`
- Selection criteria → `workflows/selection-criteria/SKILL.md`
- Cover letter → `workflows/cover-letter/SKILL.md`
- Final review or archive → `workflows/finalise/SKILL.md`

Follow the selected workflow to completion. Return to this menu only when the user asks for another task.
