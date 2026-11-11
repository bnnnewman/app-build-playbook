---
name: build
description: Start and carry out one build - read the handoff and the design lock, re-ask the teaching mode, grill scope, write the brief, mock up anything visible, then build in small committed steps with tests. One build is one brief, one branch, one PR. Use to begin any piece of building work, including idea builds and fix batches.
argument-hint: "<build id or name>"
---
# Build

*`${CLAUDE_PLUGIN_ROOT}` is the playbook folder. If you see it literally, find the folder by searching for `PLAYBOOK.md` under `~/.claude/plugins/`, `/opt/app-build-playbook` or `.claude/playbook/`.*

A **build** is one brief, one branch, one PR, one "merge N". Its ID is a short slug unique in the project
(`B3-today`, `I-shoes`, `A` for the audit of adopted code). Everything it makes lives in `work/<build>/`.

## 1. Pick up cold

- Read `${CLAUDE_PLUGIN_ROOT}/OWNER.md`, the project `CLAUDE.md`, `STATUS.md`, and `work/<build>/HANDOFF.md` or
  `BRIEF.md` if a coordinator wrote one.
- **Read the design lock** before anything visible: `design/STYLE-GUIDE.md`, the ledger, design decisions.
- Run the checks that run here. Note the count **a command produced**. If nothing can run, say "not run".
- **Ask the teaching mode for this build** (teach / explain / ship), unless a coordinator's brief sets it.

## 2. Settle it before code

`/playbook:grill <build>` (IDs `D-<build>-nn`), unless you're a child session (then: cautious reading, noted "for
the owner", and report it). Roots:
- **Scope:** anything to add or drop? Offer a **split** if it's large: smaller builds reach him sooner.
- **Policy the build raises:** what happens on bad input; new stored fields; what leaves the device.
- **"Now or later"** is asked only for medium or large items, with what each costs in checks.

## 3. Write `work/<build>/BRIEF.md`

From `${CLAUDE_PLUGIN_ROOT}/templates/BUILD-BRIEF.md`: the "done when" in his words; the tier of checks this build
needs and which lanes (`/playbook:close` table); files it may touch; rules carried in; numbered steps, the last
always **one end-to-end test of the done-when**; what can't be run here.

## 4. Mock-up before anything visible

A new screen or a visible layout change goes to `/playbook:mock change` first. Wait for his pick. Build what he
picked. If the build can't match it, say so before building.

## 5. Build, step by step

- Tests named for their SPEC IDs. A step that touches a promise adds or runs its invariant test.
- **Pull a rule out of the screen code in the same step that changes it**, so it can be tested here.
- Run the full checks; commit `<build> step k: <outcome>` with the count; push the branch.
- **Unrun code:** label it *draft, not run* in the commit. At most **one step** of it before something real runs it
  (the platform's test channel, the type-check harness, the owner). Never state a count no command produced.
- **Teach mode:** explain the idea before the step; one check question after a new idea; add it to
  `docs/owner/LEARNING.md`.
- An unclear rule → the cautious reading, logged as an interpretation in `work/<build>/NOTES.md`.
- Something he should look at → a line in `NOTES.md` under "For the owner". It reaches him in the PR summary.
- **No new steps mid-build** without asking. A late addition gets its own checks.
- New user-facing words: collect them as you go for the wording page.
- Long run? Post a one-line progress note at each step: done, left, anything that needs him.

When the last step is green: `/playbook:close <build>`.
