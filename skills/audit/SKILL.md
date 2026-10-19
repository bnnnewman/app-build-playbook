---
name: audit
description: Run the playbook safety-logic audit loop until 0 Critical and 0 Major - freeze, brief the logic-auditor with invariants, scope and a do-not-re-raise list, fix with the fix-impact checklist, re-audit narrowly, and break patch loops. Use after the panel (stage 5), after any PLAN/SPEC change, or for build-phase safety audits. Pass "one-round" to run a single round without fixing.
argument-hint: "[R | A | P<n>] [one-round]"
---
# Audit loop

*`${CLAUDE_PLUGIN_ROOT}` is the playbook folder. If you see it literally, find the folder by searching for `PLAYBOOK.md` under `~/.claude/plugins/` or `.claude/playbook/`.*

Read `${CLAUDE_PLUGIN_ROOT}/PLAYBOOK.md` stage 5, and lessons L-02, L-03, L-05, L-06, L-10, L-18, L-23, L-24 and L-30.

**Stage** comes from `$ARGUMENTS`:
- `R`: PLAN and SPEC;
- `A`: adopted code;
- `P<n>`: a build phase.

**The next round number** is the highest existing `reviews/<stage>-SA<n>.md`, plus one (compare as numbers). At stage R, the panel's `R-SA0` is round 0. Finding IDs are `<stage>-SA<round>-nn`.

With **`one-round`**, do steps 1–4 only, and return. `/playbook:phase-close` does this while a code review runs in parallel.

## Each round

1. **Freeze.**
   - Commit any pending work.
   - Record the exact scope: document versions, or a `<base>..<head>` commit range.
   - No commits land while the auditor runs (L-18).
2. **Brief the `logic-auditor`.** Use `playbook:logic-auditor`, or `logic-auditor` if the playbook was copied into the project. The brief contains:
   - **Scope.**
     - Round 1: the whole PLAN and SPEC, or the whole phase diff.
     - Later rounds: **only** the diff since the last round, plus the sections it touches, plus all invariants.
     - For code, give the commit range and say "probe in a scratch copy outside the repo". At stage R, say "no Bash".
     - For Phase A: one auditor per module from `AS-IS.md`, launched in parallel, all frozen at the same HEAD.
   - **Invariants:** "Prove or refute every SPEC §3 invariant."
   - **Tests to recompute:** any whose rules changed.
   - **Do-not-re-raise list:**
     - decided items (`DECISIONS.md`);
     - rejected proposals;
     - items deferred to an expert;
     - `pending-default` items;
     - Minors already batched.
   - **The ID prefix** and the template path: `${CLAUDE_PLUGIN_ROOT}/templates/AUDIT.md`.
   - **Exit and Minors:** "Report Critical and Major in full. List Minors briefly at the end; they are batched, not looped."
3. **Save** the report verbatim to `reviews/<stage>-SA<round>.md`. Commit it: `Save <stage> review SA<round>`.
4. **Read the verdict line** (`Critical: n · Major: n · Minor: n · Nit: n`). If it says 0 Critical, 0 Major, go to "Exit". In `one-round` mode, stop here.
5. **Fix** each Critical and Major:
   - **Root cause, not the reported scenario** (L-30).
   - Docs use the **fix-impact checklist**:
     - list every surface the ID touches: PLAN, SPEC prose, tables, data model, UI, tests, DECISIONS, CHANGELOG;
     - edit all of them;
     - grep for the old wording;
     - recompute the affected tests.
   - Code fixes get a regression test in a per-review test file (e.g. `P2Audit1Tests`). Check that it fails with the fix reverted.
   - Where the right answer is the owner's call:
     - apply the **most conservative** option;
     - log it as `pending-default` in `DECISIONS.md`;
     - add it to the next round's do-not-re-raise list;
     - keep going.
     - A Critical or Major item built on a default blocks the **phase close** until the owner confirms it.
   - Never loosen a safety rule without a ⚠ owner yes.
   - Commit `Fix <IDs>: …`. Bump versions and the CHANGELOG for doc changes.
   - Append a Status block to the audit file.
6. **Loop breakers.** Check these before the next round:
   - **The same area yielded a Major in two consecutive rounds?** Stop patching. Rewrite that area as one canonical definition or state table (L-06). Tell the owner.
   - **Round 5 or later, still with Majors** (round 3 for a Light project)? Stop. Put the design question to the owner, with options.
   - **Did a fix introduce a new Critical?** Next round, re-read that fix's whole neighbourhood, not just the diff.
7. Run the next round.

**Owner reversals.** If the owner reverses a decision in an area already closed, apply it as a new diff, then run one narrow round on it.

## Exit

At 0 Critical and 0 Major:
1. **Do one Minor polish pass.**
   - Fix the cheap ones.
   - The rest go into `DECISIONS.md` "Left as is", with a reason ("safe direction").
   - If the polish touched rules or tests, run one narrow round on that diff.
2. Commit `<Stage> audit closed: round <n> at 0 Critical, 0 Major`. Update the Playbook map.
3. Ask the owner to confirm the `pending-default` decisions in one batch (`/playbook:decide`).
4. **At stage R,** write `phases/P1-HANDOFF.md` (or `PA-HANDOFF.md` for an adopted app) from the template, so the build can start cold.
5. Note the round count and the findings per round for the retro.
