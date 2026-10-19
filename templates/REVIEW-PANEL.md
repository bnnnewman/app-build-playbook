# REVIEW PANEL: pre-build expert review (Phase R)

> **For Claude Code.** Before any app code is written (or, for an adopted app, before more is written), run an expert review of `PLAN.md` and `SPEC.md` with <n> Sonnet subagents, each a different specialist. Then synthesise their findings, get <owner>'s decisions, and apply only the changes <owner> accepts.
>
> The reviewers advise. **<Owner> decides.** No reviewer edits any file.

---

## 1. The panel

| Agent | Code | Kind | Remit | Tools |
|---|---|---|---|---|
| `logic-auditor` | SA | core | Consistency, invariants, unsafe paths, edge cases, test gaps | Read, Grep, Glob (+ Bash for probes at build stages only; none at stage R) |
| `adherence-reviewer` | AD | core | Friction, framing, real-life use, disruptions, notifications | Read, Grep, Glob, WebSearch, WebFetch |
| `data-reviewer` | DA | core if the app reads sensors or APIs | Data validity, thresholds, missing-data behaviour | + web |
| `privacy-reviewer` | PV | core if personal data is involved | What leaves the device, storage, logs, consent | + web |
| `<domain>-reviewer` | <2 letters> | domain (from `panels/<pack>/`) | … | + web |

Domain agents live in `.claude/agents/` (project scope), copied from the panel pack and tailored with the **Context** block below. Run `/agents` to confirm they are loaded.

**Owner context** (pasted into every domain agent's Context block):
- <3–6 facts each reviewer needs: history, constraints, current numbers, equipment, budget, schedule>

**Hard constraints** (every proposal must respect these):
- <e.g. budget, time per day, equipment, platform>

## 2. Before the run (R0)

- [ ] SPEC §3 invariants written.
- [ ] Data spike done, or marked not applicable.
- [ ] Scope frozen. Rechecks scheduled.
- [ ] **Precedence for conflicts:**
  1. `logic-auditor` and `<harm-domain expert>` on safety;
  2. `<expert>` on `<area>`;
  3. …
  4. others within their remit.

## 3. Orchestration

**R1. Brief** (same for everyone; paste the Owner context and Hard constraints from §1 into it, because the core agents have no Context block of their own):
> "Review `PLAN.md` (and `SPEC.md` where it touches your remit) from your specialist view. Owner context: <paste>. Hard constraints: <paste>. Follow your focus areas and constraints. Use the template in `review-output.md`, with finding IDs `R-<your code>0-nn`. Keep it under 900 words. Verify each citation with a web search, or tag it `[unverified]`. Save nothing; return the review."

The `logic-auditor` gets the same brief, except: use `AUDIT.md`, IDs `R-SA0-nn`, no word cap, and no Bash at this stage.

**R2. Run in parallel.** The panel is round 0. Save each output to `reviews/R-<code>0.md` (e.g. `R-AD0.md`, `R-SA0.md`).

**R3. Synthesise.** The main session writes `reviews/SUMMARY.md` from `templates/SUMMARY.md`.

**R4. <Owner> decides.** Accept / reject / modify for each ID, via `/playbook:decide`. Don't proceed until every Critical and Major item has a decision.

**R5. Apply** only the accepted IDs, with the fix-impact checklist. Bump the versions. Write a CHANGELOG entry listing each ID. Then run the audit loop (`/playbook:audit`).

**R6. Rechecks** (round 1, `reviews/R-<code>1.md`): <which expert, after what event>.

## 4. Guardrails

- Reviewers never edit files.
- Never weaken a safety rule without <owner>'s explicit, separate confirmation (⚠).
- Every proposal respects the hard constraints.
- Evidence (with a verified source) is kept separate from professional opinion.
- No diagnosis. Say "recommend getting X checked".

## 5. Done when

- [ ] `reviews/` has every reviewer file and `SUMMARY.md`.
- [ ] Every Critical and Major ID has a decision in `DECISIONS.md`.
- [ ] Accepted changes are applied, versions are bumped and the CHANGELOG is updated.
- [ ] The audit loop is closed at 0 Critical, 0 Major.
- [ ] Rechecks are done.
