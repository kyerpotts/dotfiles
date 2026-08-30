---
name: job-full-application
description: Orchestrates an end-to-end job application from intake and fit analysis through required drafts, human voice editing, final review, and optional archival. Use when the user wants a complete application package.
---

# Full application

Read [the shared workflow](../../references/WORKFLOW.md).

## Contract

**Requires:** advertisement/JDF and application instructions.  
**Produces:** fit analysis and every required application document in dependency order.  
**Next:** submission and optional archive.

## Steps

1. Request the advertisement/JDF, target role, organisation, deadline, required documents, limits/formats, output location, and the user's reason for applying when a cover letter is required. Accept paths, documents, URLs, or pasted text.
2. Ask whether recent responsibilities, achievements, skills, or corrected facts are missing from the repository. If yes, run `../achievement-capture/SKILL.md` before analysis.
3. Run `../fit-analysis/SKILL.md`. Present the recommendation, anchor evidence, gaps, and clarification questions.
4. Confirm which documents to prepare after the user sees the fit analysis.
5. Run only the required draft workflows:
   - resume: `../resume/SKILL.md`;
   - selection criteria: `../selection-criteria/SKILL.md`;
   - cover letter: `../cover-letter/SKILL.md`.
6. Preserve each workflow's human editing gate. Resume bullets remain factual working copy; selection criteria and cover letters move from outline to prose only after user input.
7. Run `../finalise/SKILL.md` across the complete package.
8. Archive only when the user confirms submission.

Track phase completion in a short checklist so interrupted work can resume without repeating completed analysis. Completion: every required document has passed fit mapping, human voice editing, and final factual review.
