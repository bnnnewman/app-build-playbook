# Phase <n> handoff: <deliverable>

*Written <date> at the end of the Phase <n-1> session. Start from branch `<branch>`, built on `<parent>` (PR <link>). The step plan goes in `phases/P<n>-PLAN.md`.*

## Where things stand

- **Done:** Phases <…> are done in code. <N> tests pass on Linux. CI: <status, last run, any trigger change the next session must make>.
- **Reviews closed:** <files>, final 0 Critical / 0 Major. Known open Minors: <IDs>.
- **Read first, in order:**
  1. `DECISIONS.md` (latest rows);
  2. this file;
  3. SPEC §<list>;
  4. PLAN §<list>.
- **Size:** <Light/Standard/Full>. **Environment:** <local/cloud/both>.
- **Sources of truth:** PLAN v<a>, SPEC v<b>. <Owner>'s decisions are final; don't reopen them. If PLAN and SPEC disagree, ask.
- **Where <owner> is:** <at a desk / on the phone, so ask by short text / away until …>. What they are setting up separately: <…>.

## Goal (SPEC §12)

> <The "Done when" sentence, verbatim.>

## Architecture (follow it)

- Module responsibilities: <pure logic> → <data/sync> → <app-state, pure> → <UI, holds no rules>.
- The single write path: <…>.
- Schema evolution for new stored fields: <rule>.
- Time and clock rule: <rule>.

## The platform split

*Skip this section if the work happens on <owner>'s own machine, where everything can be built and run directly.*

- **Build and test here (cloud Linux):** …
- **Needs CI or <owner>'s machine:** … (drafts go behind platform guards, labelled "draft, not compiled here").

## What already exists

The APIs this phase must feed:
- `<Type.func(…)>`: what it does.

**Stubs to replace:** "`<X>` passes `<placeholder>` today. Phase <n> must pass the real one."

## Rules carried forward (from reviews and decisions)

1. <ID>: <one-line rule>.

## Decisions needed before step 1

Ask early, as options with a recommendation. Each one notes the default used meanwhile.
1. **Scope:** anything to add or drop from this phase? (L-29)
2. **Policy:** <fail-safe for untrusted inputs, data strictness, privacy> (L-15, L-16)
3. …

## Toolchain (fresh cloud container, or the local machine)

```bash
<exact install + build + test commands; verified on <date>>
```

## Suggested step order (commit and push after each)

1. …
<k>. End to end, then review. One test encodes the goal. Then the safety audit and code review, fixes, and a narrow re-audit to 0/0.

## Model recommendations

| Step | Main session | Subagents | Why |
|---|---|---|---|
| Coupled logic | strongest model | none (don't split coupled logic) | |
| Tests from the SPEC table | | Sonnet | mechanical |
| Safety audit | | `logic-auditor` (Sonnet) | read-only |
| Code review | `/code-review` on the strongest model | | |

## Guardrails (unchanged)

- Never commit real personal data. Fixtures are hand-written.
- Never weaken a safety rule without <owner>'s explicit, separate confirmation.
- Don't reopen decided items.
- No model names in commits or code.
