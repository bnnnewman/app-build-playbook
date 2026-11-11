# Panel packs

A pack is a set of **domain expert reviewers** for one kind of project. The core reviewers ship with the plugin and
suit anything: `logic-auditor`, `adherence-reviewer`, `data-reviewer`, `privacy-reviewer`, `security-reviewer`, `design-reviewer`,
`automation-reviewer`, `finding-verifier`. A pack adds the specialists a domain needs.

Pack agents are **templates**. `/playbook:panel` copies the ones you choose into the project's `.claude/agents/` and
fills in the `<<…>>` placeholders. That tailoring is most of why reviews come back specific and useful.

| Pack | Status | For |
|---|---|---|
| `health-fitness/` | Used on First Light (Oct–Nov 2026), many times | Training, rehab, nutrition, wearables |
| `plant-care/` | Used on Flobbadob (Oct 2026): 6 reviewers and a recheck; all 3 Criticals came from the dog | Plant care, pests, soil, pets |
| `governance/` | Used on a work policy tracker (Oct 2026) | Policy registers, committees, compliance tracking |
| `design/` | Roles used across First Light's design panels | Visual design, accessibility, flow, copy |

## What every tailored reviewer gets (learned the hard way)

1. **One shared owner-context block**, written once in the project's `REVIEW-PANEL.md` and pasted into every agent:
   who it's for, the real numbers, what it is and is not, hard constraints, the time budget.
2. **"Unknown: ask if it matters (max 3 questions)"** inside that block. When five of six reviewers ask the same
   thing, that question belongs in the start interview: add it to the pack README's "Ask the owner first" list.
3. **Focus questions that quote the project's real values and section numbers**, not "are the schedules right?".
4. **"Read `OWNER.md`, `DECISIONS.md` and `AS-IS.md` first, and say that you did."** Three reviewers once skipped
   them and reopened settled points.
5. **Cross-deference:** who wins on what. The reviewer closest to the worst harm holds precedence, and the others
   say they defer to it.
6. **A recheck** when the owner's answers change a reviewer's facts.
7. **Hard limits for the role** (no product names, no diagnosis, no legal rulings: "recommend confirming with …").

## Designing a new pack

1. **List the ways the product could hurt or mislead** someone (or their pets, plants, money, standing). Each harm
   needs an owner on the panel.
2. **List the decisions the product makes.** Each family needs someone who makes those decisions in real life.
3. Add the data reviewer if it reads outside data; the automation reviewer if anything runs unattended.
4. **Size the panel** (Light about 3; Standard 5–6; Full 6–8, with verifiers), core reviewers included.
5. Write each agent from `_TEMPLATE.md`, with a two-letter code for finding IDs.
6. Write the precedence order before the run.
7. **After the project,** promote what the tailoring taught back into the pack (`/playbook:retro sync`).
