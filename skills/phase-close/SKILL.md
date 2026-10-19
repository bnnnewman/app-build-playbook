---
name: phase-close
description: Close a playbook build phase - freeze, run one safety-audit round and a code review in parallel, fix with regression tests, narrowly re-audit to 0 Critical/0 Major, get CI green, write the device try-out script, status, owner notes, CHANGELOG, PR and the next handoff, then a short retro. Use when a phase's build steps are done, or for the Phase A audit of adopted code.
argument-hint: "<phase number | A>"
---
# Close a build phase

*`${CLAUDE_PLUGIN_ROOT}` is the playbook folder. If you see it literally, find the folder by searching for `PLAYBOOK.md` under `~/.claude/plugins/` or `.claude/playbook/`.*

Read `${CLAUDE_PLUGIN_ROOT}/PLAYBOOK.md` stage 6 ("Phase close" and "Phase A"), and lessons L-08, L-17, L-18, L-19, L-20, L-23, L-25, L-26 and L-30.

The stage prefix is `P<n>`, or `A` for Phase A.

1. **Freeze.**
   - Commit everything. Push if there's a remote.
   - Record the base and head SHAs. Reviews cover exactly `<base>..<head>`. For Phase A, the scope is the whole codebase at HEAD.
   - No new commits until the reviews are back (L-18).
2. **Review in parallel, in one message:**
   - **Safety:** `/playbook:audit <stage> one-round` (`<stage>-SA1`). For Phase A, that means one `logic-auditor` per module from `AS-IS.md`: `reviews/A-SA1-<mod>.md`, IDs `A-SA1-<mod>-nn`. Each proves the invariants, and may probe in a scratch copy.
   - **Code review** on the same range, at high effort:
     - Use the `code-review` skill if it's available. Otherwise use a general-purpose subagent briefed to review for correctness bugs, and to verify each finding with a probe test in a scratch copy.
     - Save the result to `reviews/<stage>-CR1.md`, using the AUDIT template's issue table and IDs `<stage>-CR1-nn`.
     - Include "How the findings were checked" and "Dropped after checking".
   - **Optional:**
     - the `privacy-reviewer`, if the phase adds storage, sync or network calls;
     - the `adherence-reviewer`, if it adds screens or notifications.
3. **Fix.**
   - Every Critical and Major from every review. Root causes.
   - One regression-test file per review (e.g. `P2Audit1Tests`, `P2CodeReview1Tests`), mutation-checked: each test fails with its fix reverted.
   - Commits cite IDs.
   - Minors: fix the cheap ones. The rest go into `DECISIONS.md` "Left as is" with a reason, or into "Rules carried forward".
   - **Phase A:** plan the fixes as steps in `phases/PA-PLAN.md` (see `/playbook:phase-start A`), and build them first.
4. **Narrow re-audit** of the fix commits only: `/playbook:audit <stage>`, which continues at `SA2`, `SA3`, … until 0 Critical, 0 Major. The brief must ask the auditor to confirm each code-review fix too. Commit `<Stage> audit closed: round <k> at 0 Critical, 0 Major`.
5. **CI**, if the project has CI:
   - Trigger the platform workflow by hand (manual dispatch) before opening the PR. If that isn't possible, open the PR as a draft and let it run CI.
   - Don't loop on pushes: a macOS run costs about 110 free-tier minutes.
   - Fix failures. Ask the owner for logs if you can't see them.
   - Record the run number.
   - **Local-only project:** run the full suite and the platform build locally instead.
6. **Device check.**
   - Write "Trying it on the device" in the phase plan: numbered steps, plus what to send back (verbatim errors; no screenshots of personal data).
   - If the owner can't run it yet, say so, and record the device clause of "Done when" as **not met**. Don't paper over it.
7. **Record.**
   - Append the Status section to the phase plan.
   - Add the phase's block to `NOTES-FOR-OWNER.md` (from the template): **Flags** for the owner to read, **Interpretations** taken, items left as is, and rules for later phases.
   - Add one CHANGELOG entry for the phase. Bump the SPEC if any rule changed this phase (L-20).
   - Check `DECISIONS.md`: **any Critical or Major still on a `pending-default` blocks the close.** Ask the owner now.
   - Update the Playbook map.
8. **PR.**
   - **If there's a remote and the owner wants PRs:** open one from `${CLAUDE_PLUGIN_ROOT}/templates/PR-BODY.md`. State the merge order. Recommend merging before the next phase starts (L-25).
   - **No remote:** write the same body to `phases/<stage>-PR.md`.
9. **Next handoff.** Write `phases/P<next>-HANDOFF.md` from the template (after Phase A, the next is P1). Fill every field, especially:
   - carried-forward rules by ID;
   - existing APIs and stubs;
   - decisions needed before step 1;
   - the toolchain;
   - the model table.
10. **Retro.** Run `/playbook:retro <stage>` (skip it for Light-sized projects).

Finally, tell the owner, in up to 8 lines:
- what was delivered;
- the review rounds (C/M per round);
- the test count;
- CI and the device status;
- the flags to read;
- decisions they need to make;
- the next phase.
