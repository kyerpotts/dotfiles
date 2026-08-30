# Job-application workflow graph

## Sources of truth

Locate these in the current directory or nearest parent; ask for their location only when they cannot be found:

- `Work Achievements Repository.md` — facts, status, ownership, metrics, skills.
- `Professional Voice Guide.md` — drafting and editing voice.
- `Generic Resume Template.md` — resume structure.
- `submitted_applications/` — historical examples only.

When submitted material conflicts with the repository, use the repository and surface the conflict.

## Graph

```text
achievement-capture ───────┐
                           v
job advertisement/JDF -> fit-analysis -> resume --------┐
                                ├-----> selection-criteria├-> finalise -> submitted_applications
                                └-----> cover-letter -----┘

full-application = intake -> fit-analysis -> required drafts -> human voice edit -> finalise
```

## Contracts

| Workflow | Requires | Produces | Natural next step |
|---|---|---|---|
| Achievement capture | User account; repository | Confirmed repository update | Fit analysis |
| Fit analysis | Advertisement/JDF; repository | Requirement/evidence map, gaps, recommendation | Capture missing evidence or draft |
| Resume | Fit analysis; advertisement/JDF; repository | Base responsibilities plus tailored achievement draft | Human edit or cover letter |
| Selection criteria | Criteria/JDF; fit analysis; repository | Evidence outline, then confirmed prose | Human edit and finalise |
| Cover letter | Advertisement; fit analysis; repository | Evidence outline, then confirmed draft | Human edit and finalise |
| Finalise | Advertisement/JDF; all required drafts | Fact/voice/coverage review; optional archive | Submission |
| Full application | Advertisement/JDF; required-document list | All applicable outputs in dependency order | Finalise |

A downstream workflow may create a missing fit analysis rather than stopping, but it must not silently skip requirement mapping.

## Intake

Accept information as pasted text, file paths, PDFs, office documents, URLs, or a mixture. Read supplied material completely. Ask only for inputs that change the result:

- target role and organisation;
- complete advertisement, JDF, or criteria;
- required documents and format/length limits;
- deadline;
- output location;
- reasons for applying or organisation context when a cover letter needs them.

Default working location: `working_applications/<organisation>_<role>/`. Ask before creating it when the user has not named an output location.

## Drafting gates

1. Map requirements to evidence before prose.
2. Surface gaps, contradictions, weak evidence, and delivery-status ambiguity.
3. Produce factual outlines for selection criteria and cover letters.
4. Obtain the user's wording or confirmation before polished prose.
5. Apply `Professional Voice Guide.md` in a restrained edit.
6. Archive only after the user confirms the application was submitted.

## Output rules

- Preserve official titles and Australian English.
- Separate routine responsibilities from additional value.
- Keep proposals, proofs of concept, prototypes, active development, and production outcomes distinct.
- Preserve shared ownership and exact metrics.
- Leave unsupported requirements as gaps.
- Use plain Markdown working files unless the user requires another format.
