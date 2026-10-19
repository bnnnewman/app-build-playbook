# Phase <n> plan: <deliverable>

*Started <date>. Branch `<branch>`, built on `<parent>` (PR <link>). Handoff: `phases/P<n>-HANDOFF.md`.*

**Goal (SPEC §12):** <the "Done when" sentence, verbatim>.

**How the work is split:**
- Linux-tested logic goes in `<pure module>`. Every write goes through `<single write path>`.
- Platform code goes in `<UI module>`. It holds no rules, and CI compiles and tests it.
- Already built, so this phase only wires it up: <types>.

**Rules carried in:** <ID: one line>, …

**Decisions settled before step 1:** <D-IDs> (scope, fail-safe policy, data format).

## Steps (commit and push after each)

1. **<Outcome>.** SPEC §x.y. Tests: <IDs>.
   - Inputs: …
   - Writes: …
   - Edge cases: …
2. …
<k>. **End to end, then review.**
   - One test covers <the Done-when scenario>.
   - **Freeze the branch.**
   - Run the safety audit and the code review in parallel.
   - Fix, then narrowly re-audit until 0 Critical, 0 Major.
   - Get CI green.

**Deferred or open:** <questions, with the default in use>.

**Guardrails (unchanged):** no real personal data committed; never weaken a safety rule without explicit confirmation; don't reopen decided items; if PLAN and SPEC disagree, ask.

---

## Status (<date>), appended at close

- **Done:** steps … <N> tests on Linux.
- **Audits:** P<n>-SA1 <C/M> → … → 0/0. **Code reviews:** P<n>-CR1 <C/M>, all Majors fixed with regression tests.
- **<Owner> decisions this phase:** <D-IDs>.
- **Verified:** CI run <#> (<jobs>). **Not verified:** <what, and why>.
- **Left as is:** <IDs> (see DECISIONS.md).
- **Notes:** the Phase <n> block is in `NOTES-FOR-OWNER.md` (<k> flags to read).

## Trying it on the device

1. <Exact step>.
2. …

**Send back:** "done" or "not done" for each step, plus any error text, verbatim. No screenshots of personal data.
