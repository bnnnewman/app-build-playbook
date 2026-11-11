---
name: audit
description: Run the safety-logic audit loop to 0 Critical and 0 Major, sized to the change - freeze, brief the logic-auditor with the invariants and a do-not-re-raise list, fix causes not cases, re-check narrowly, and end loops by simplifying, a close-out round, or a trial. Use after a panel, after any plan or spec change, and as the safety lane of a build. Pass "one-round" to run a single round without fixing.
argument-hint: "<build> [one-round] [tier]"
---
# Audit loop

*`${CLAUDE_PLUGIN_ROOT}` is the playbook folder. If you see it literally, find the folder by searching for `PLAYBOOK.md` under `~/.claude/plugins/`, `/opt/app-build-playbook` or `.claude/playbook/`.*

**Helpers:** pick each one's model, and record its cost, by `/playbook:coordinate` → "Who does this job". Fable needs the owner's yes first.

Files: `work/<build>/reviews/SA<round>.md`. Finding IDs: `<build>-SA<round>-nn`. The next round is the highest
existing number plus one.

## 0. Size it to the change first

| The change | What it gets |
|---|---|
| Words only (not safety wording) | No audit. A wording page. |
| Looks only | No safety audit. The design lane and a code review. |
| A rule gets stricter, or touches a safety input | **One narrow round** on the diff. |
| A rule gets looser ⚠, or reaches many areas, or new stored data | The full loop below. |
| Several small builds before a release | One whole-batch pass. |

Say which tier you chose and why, in one line.

**Before a rule changes** (stricter or looser), where the owner has real history: `/playbook:spike replay` first, and show him the counts.

**By size.** *Mini:* no audit loop (one review pass at close). *Light:* at round 3 with Majors, stop and offer simplify. *Standard:* simplify offered at round 3, the default at round 5. *Full:* as Standard.

## Each round

1. **Freeze.** Commit (no remote, or a push refused: commit locally and carry on). Record the exact scope (document versions, or `<base>..<head>`).
2. **Brief `playbook:logic-auditor`:**
   - Scope: round 1 reads everything in scope; later rounds read only the diff, what it touches, and the invariants.
     For code, "probe in a scratch copy outside the repo".
   - "Prove or refute every SPEC invariant, **by ID**." Tests to recompute.
   - **Do-not-re-raise list:** decided and rejected items, `pending` defaults, Minors already batched.
   - "Read `OWNER.md` and `DECISIONS.md` first. Flag anything that loosens a rule ⚠."
   - Template `${CLAUDE_PLUGIN_ROOT}/templates/AUDIT.md`; the ID prefix.
   - Existing code (build A): one auditor per module, in parallel, IDs `A-SA1-<mod>-nn`.
3. **Save** the report verbatim. Commit `Save <build> review SA<round>`.
4. **Read the verdict line.** 0 Critical and 0 Major → Exit. With `one-round`, stop here.
5. **Fix.**
   - The cause, for every case it covers, not the reported case.
   - Documents: list every place the fix touches, edit all, search for the old wording, recompute tests.
   - Code: a regression test per finding, checked to fail with the fix removed (work on a copy; never `git checkout`
     over uncommitted fixes).
   - The owner's call? Take the cautious option, mark it `pending`, carry on. A Critical or Major built on a
     `pending` blocks the merge until he confirms.
   - Never loosen a rule without a ⚠ yes.
6. **Before the next round, check the breakers:**
   - Same area, a Major two rounds running → rewrite it as one table or one definition.
   - A rewrite failed twice → change the **kind** of rule (ask the platform; one helper every reader uses).
   - **Round 3 with Majors → put "simplify or cut it" to the owner as the ★ option.** Round 5: it is the default.
   - **Close-out:** if he picks "one more round", that round is narrow and the loop closes either way; what's left
     goes to the build audit, written down.
   - It's about how a screen behaves, and 3 document rounds haven't settled it → stop, and build a **trial with
     made-up data** for him to try.

## Exit

1. One Minor pass: fix the cheap ones; the rest go to `work/<build>/NOTES.md` "Left as is", each with its reason.
2. Commit `<build> audit closed: round <n> at 0 Critical, 0 Major`.
3. Confirm any `pending` items in one batch (`/playbook:decide`).
4. Note rounds, first-round counts and findings caused by fixes, for the retro.

Report the loop to the owner as a trend, not jargon: "3 rounds; nothing serious after the first; 2 small things left
as they are, both on the safe side".
