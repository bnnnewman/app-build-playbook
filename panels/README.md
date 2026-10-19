# Panel packs

A panel pack is a set of **domain expert reviewers** for one kind of app. The core reviewers (`logic-auditor`, `adherence-reviewer`, `data-reviewer`, `privacy-reviewer`) ship with the plugin and suit any app. A pack adds the 3–6 specialists a domain needs.

Pack agents are **templates**. `/playbook:panel` copies the ones you choose into the project's `.claude/agents/` and fills in the `<<…>>` placeholders with the owner's context. Each reviewer then knows the person it is reviewing for. That tailoring is a big part of why the Running-App reviews were specific and useful.

| Pack | Status | Built for |
|---|---|---|
| `health-fitness/` | Used in anger (Running-App, Oct 2026) | Training, rehab, nutrition, wearables |
| `plant-care/` | **Draft**: tailor and validate on Flobbadob | Plant care, garden, pests, environment, toxicity |

## Designing a new pack

1. **List the ways the app could hurt or mislead** the user (or their plants, pets or money). Each harm needs an owner on the panel. The expert who "holds precedence on harm" is the one closest to the worst outcome: the physio in Running-App; the plant pathologist and the toxicity reviewer in plant care.
2. **List the decisions the app makes.** Each family of decisions needs an expert who programs those decisions in real life (the running coach for run load; the horticulturist for watering).
3. **Add the data reviewer** if the app reads sensors or APIs. Its thresholds are provisional until the data spike.
4. **Size the panel to the project** (PLAYBOOK "Sizing the process"): 3 agents for Light, 5–6 for Standard, 6–8 for Full, including the core ones.
5. **Write each agent with this shape** (copy `_TEMPLATE.md`):
   - **Code:** a two-letter code for finding IDs (e.g. `PH` → `R-PH0-03`). List it in the pack README.
   - **Persona:** a specific sub-specialty, not just "an expert".
   - **Context:** `<<OWNER_CONTEXT>>`, the 3–6 facts this role needs.
   - **Review focus:** 5–7 pointed, numbered questions tied to PLAN sections. Ask for exact values, protocols and sources.
   - **Constraints:** role-specific hard limits (e.g. "no product prescriptions; refer to a specialist") plus the owner's constraints.
   - **Tools:** Read, Grep, Glob, WebSearch, WebFetch. Never Write or Edit. Model: sonnet.
6. **Write the precedence order** for conflicts in `REVIEW-PANEL.md` §2 before the run.
7. **After the project,** promote the tailored agents back into the pack, with placeholders, and mark the pack "used in anger".
