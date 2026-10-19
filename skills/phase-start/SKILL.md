---
name: phase-start
description: Start a playbook build phase - read (or write) the handoff, settle scope and policy questions before planning, write phases/P<n>-PLAN.md with numbered steps tied to SPEC sections and test IDs, then build step by step with a commit after each. Use at the start of each build phase or when a fresh session picks one up.
argument-hint: "<phase number | A>"
---
# Start a build phase

*`${CLAUDE_PLUGIN_ROOT}` is the playbook folder. If you see it literally, find the folder by searching for `PLAYBOOK.md` under `~/.claude/plugins/` or `.claude/playbook/`.*

Read `${CLAUDE_PLUGIN_ROOT}/PLAYBOOK.md` stage 6, and lessons L-13, L-14, L-15, L-16, L-17, L-19, L-27 and L-29.

## 1. Pick up cold

1. Read `phases/P<n>-HANDOFF.md`. If it's missing, write one from `${CLAUDE_PLUGIN_ROOT}/templates/PHASE-HANDOFF.md` using the project state.
2. Read everything in its "Read first" list, and check out its start branch.
3. Run its toolchain commands. **If code exists,** confirm the test suite passes **before** changing anything, and note the count. **If there's no code yet** (P1 of a new app), say so and skip this.
4. **Phase A (adopted code)** works differently:
   - **First,** write the SPEC §13.I invariant tests against the existing code, plus any example tests the existing code should already pass. Commit them, even the failing ones: a failing test is a finding.
   - **Then** run `/playbook:phase-close A` for the module-by-module audit.
   - **Then** come back here and plan the fixes as numbered steps in `phases/PA-PLAN.md`.

## 2. Settle questions before planning (L-29)

Ask the owner (see `/playbook:decide`) before the step plan is fixed:
- **Scope:** anything to add or drop?
- **Policy questions this phase raises:**
  - fail-safe behaviour for untrusted inputs (clock, empty or partial fetches);
  - data-format strictness and schema evolution for anything newly persisted;
  - privacy (what leaves the device).
- Anything the handoff lists as open.

Use conservative defaults for anything unanswered, logged as `pending-default`.

## 3. Write `phases/P<n>-PLAN.md`

Use `${CLAUDE_PLUGIN_ROOT}/templates/PHASE-PLAN.md`.
- **Goal:** the SPEC §12 "Done when" for this phase, verbatim.
- **How the work is split:**
  - pure logic, testable without the platform;
  - the app-state layer, pure;
  - UI, which holds no rules;
  - the single write path.
- **Rules carried in** from earlier audits and decisions, by ID.
- **Numbered steps.** Each one names its SPEC sections and test IDs, its inputs, its writes and its edge cases.
  - The hardest coupled logic gets its own step.
  - The last step is always "End to end, then review", with one end-to-end test for the Done-when.
- **Check that the §13.I invariant tests for this phase's guardrails exist,** or are a step, before the review step (L-08).
- **If this is the first phase touching platform code, and work happens in cloud sessions:** a step to stand up platform CI. It triggers only on PRs, `main` and manual runs; a cheap job runs on every push (L-17). Working only on a local machine? Running the full suite locally may be enough.
- **If this is Phase 2, or the first phase with a UI:** a step to get the app onto the real device for this platform. Examples: TestFlight for iOS, an APK for Android, a deployed preview for web. Or a device-steps doc from `DEVICE-STEPS.md` (L-19).
- **Model table:** don't split coupled logic across parallel agents. Sonnet subagents may write mechanical tests from SPEC tables.

Commit the plan (`P<n> plan`). Push if there's a remote.

## 4. Build

For each step:
- Implement it, with tests named for SPEC IDs (`test_T047_…`, `test_TI1a_…`).
- Run the full suite.
- Commit `P<n> step k: <outcome>`. The body is a bullet list of what landed, ending with "<N> tests, 0 failures".
- **Push after every step if there's a remote.**

Also:
- Split oversized steps (`part 1`, `part 2`).
- Label code that can't be compiled or run here "(draft)", and put it behind platform guards.
- Ambiguous rule? Take the conservative reading. Log it as an Interpretation in `DECISIONS.md`, and note it for the phase's `NOTES-FOR-OWNER.md` block.
- Something the owner should look at? Note it as a Flag for the same block.
- **No new steps mid-phase** without asking the owner. A late addition gets its own review pass.
- Keep `TESTS.md` current: `python3 ${CLAUDE_PLUGIN_ROOT}/scripts/coverage.py --spec SPEC.md --tests '<test glob>'`.
  - **Standard and Full:** required.
  - **Full:** also add it to CI (it exits 1 on any missing ID).
  - **Light:** optional.

When the last build step is done, run `/playbook:phase-close <n>`.
