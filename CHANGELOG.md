# Playbook changelog

Newest first. Versions use semver (see `.claude/CLAUDE.md`).

## 2.0.0 · 11 Nov 2026 (rebuilt from four projects)

A rebuild from what the owner actually did and decided between 19 Oct and 11 Nov 2026: about 1,100 decisions, 60
audit loops and 4 projects. Evidence: `examples/2026-11-deep-dive.md`. Lessons L-33 to L-99.

**New**
- **`OWNER.md`**: the owner's standing preferences, read first by every session and reviewer. A session-start hook
  prints it, with the project's status, at the start of every session (L-74).
- **Three set-up choices:** size (now with **Mini**, one `BRIEF.md`, and a grow check), project **type** (phone app,
  web tool, tool with a routine) and **teaching mode** (teach / explain / ship) (L-49, L-50, L-51).
- **A design track before the first screen:** `/playbook:design` (brief, round-0 mock-ups, the lock),
  `/playbook:mock`, `/playbook:critique`, `/playbook:art` (L-43 to L-46, L-63; the art loop from the unmerged
  `art-loop` branch, L-33 to L-42).
- **Builds with parallel review lanes**, replacing phases: `/playbook:build`, `/playbook:close`; checks tiered to
  the change; "merge N" (L-52, L-56).
- **`/playbook:coordinate`**: the coordinator pattern, with brief and report templates (L-71).
- **`/playbook:release`**: acceptance as a tick-box page, screenshot passes, owner's manual, maintenance guide with
  renewals, promises and proof (L-61, L-62, L-64, L-66).
- **Live stages:** `/playbook:ideas`, `/playbook:gaps`, `/playbook:logic-review`, `/playbook:operate`,
  `/playbook:options` (L-60, L-67, L-68, L-69, L-79, L-80).
- **`/playbook:handoff`**, **`/playbook:tidy`**.
- **Reviewers:** `design-reviewer`, `automation-reviewer`, `finding-verifier`. Packs: `design`, `governance`.
- **`platforms/`**: iPhone apps, web tools, routines.
- **`GLOSSARY.md`**: plain words, what each check catches, what each size of change costs.
- **Scripts:** `decisions.py` (what's waiting on the owner; collisions), `metrics.py` (retro numbers from review
  files), `orient.sh` (the session-start hook). A **Playbook Teach** output style.
- Templates: `BRIEF`, `STATUS`, `IDEAS`, `HANDOFF`, `BUILD-BRIEF`, `CHILD-REPORT`, `ACCEPTANCE`, `OWNER-MANUAL`,
  `MAINTAINING`, `PROOF`, `LEARNING`, `SETUP-PLATFORM`, `DESIGN-BRIEF`, `STYLE-GUIDE`, `DESIGN-LEDGER`, `FLOW-MAP`,
  `PAGE-INVENTORY`, `BENCHMARKS`, `ART-BRIEF`, `OPERATIONS`, `ROUTINE`, `OPTIONS`, `INTERFACE-AGREEMENT`,
  `TEST-SCRIPT`, `settings.json`, `gitignore`.

**Changed**
- `/playbook:design` now means visual design. Writing the plan and spec moved to **`/playbook:plan`** and
  **`/playbook:spec`**.
- **`/playbook:grill`** reshaped around how the owner answers: about 8 numbered questions, each option says what it
  does, "yes to all except…", answers read back, direction and look asked separately, a walkthrough mode, ⚠ never in
  a round (L-76).
- **Decisions:** `DECISIONS.md` is an index and the only record; IDs are `D-<build>-nn`; both rows are updated when
  one settles another (L-71, L-75).
- **Audit loop exits:** simplify offered at round 3; a close-out rule; a trial instead of more document rounds
  (L-59).
- **Reviewers read `OWNER.md` and the decision log first** and mark "Reopens D-…" (L-55).
- **Retro:** five minutes at every merge; numbers by script; the question inside the merge message; lessons as
  `<project>-L<n>` until this repo numbers them (L-70).
- **Project layout:** `work/<build>/`, `docs/owner/`, `design/`, one `STATUS.md`, nothing else at the root (L-77).
- `coverage.py` reads test IDs of any prefix from the SPEC and fails on rows it can't read.
- `/playbook:start` adopt: works on the session's branch; says "not run" when it can't run; allows fixes that touch
  a Critical harm; imports an older decision log.
- The plant-care pack carries what Flobbadob's tailoring taught; the health pack's status is updated.

**Removed**
- `/playbook:phase-start`, `/playbook:phase-close` (→ `build`, `close`).
- `templates/NOTES-FOR-OWNER.md` (went stale in every project that used it; flags now reach the owner in the PR
  summary and `STATUS.md`), `PHASE-PLAN`, `PHASE-HANDOFF`, `DEVICE-STEPS` (→ `BUILD-BRIEF`, `HANDOFF`, `ACCEPTANCE`).

**For projects already on v1:** nothing breaks. Vendored copies keep working as they are. To move one over, run
`/playbook:tidy check`.

## 1.1.0 · 21 Oct 2026

- **New `/playbook:grill`**, adapted from Matt Pocock's `grilling` skill (MIT). It works through a design tree in rounds. Each question has a recommended answer that "yes" accepts, and facts are looked up by subagents rather than asked. Every answer goes into `DECISIONS.md`, and nothing is acted on before a shared-understanding yes. ⚠ loosenings are always asked alone. On Light projects, cheap reversible branches are left to defaults (L-31).
- **start, design, decide and phase-start** now ask the owner everything through the grill.
- **New gate: grill the PLAN and the SPEC before the panel.** Design stages 1–2 include it, and panel R0 checks it (L-32).
- Added `THIRD-PARTY-NOTICES.md`. `vendor.sh` copies it.

## 1.0.2 · 19 Oct 2026

- `scripts/cloud-setup.sh` says whether the token variable is visible, never prompts for a username, hides the token in any error, and no longer fails the session start.

## 1.0.1 · 19 Oct 2026

- README: install for every session. On your own computer it's a user-scope plugin. In the cloud, the environment's setup script installs it (`scripts/cloud-setup.sh`, using a read-only token).
- README: a manual-copy fallback for when a session's safety check blocks `vendor.sh`.
- Added the visual stage map (`docs/stage-map.html`).

## 1.0.0 · 19 Oct 2026 (from Running-App)

The first version, mined from the full Running-App history: 109 commits, 51 review files, 6 sessions.

**Kept as it was** (it worked):
- the PLAN/SPEC pair, written "For Claude Code";
- §0 gates;
- locked constants;
- Input→Expected tests with stable IDs;
- the parallel read-only expert panel, with main-session synthesis and "owner decides";
- the ⚠ loosening marker;
- conservative reversible defaults;
- the auditor loop to 0/0;
- handoff docs with fixed fields;
- commit and push per step;
- per-review regression tests;
- Notes commits;
- pure logic tested in the cloud;
- the privacy rules.

**Changed** (each traced to a lesson):
- Data spike before the panel (L-01).
- Invariants and Definitions sections in the SPEC (L-02, L-09).
- Exit rule 0C/0M stated up front, Minors batched, narrow scope from round 2, and a do-not-re-raise list (L-03).
- One home for each rule (L-04).
- Fix-impact checklist (L-05).
- State machines as tables, plus the "two rounds → rewrite" breaker (L-06).
- Scope freeze before loops and reviews (L-07, L-18).
- Invariant tests (L-08).
- Readable finding IDs (L-21).
- Verified citations (L-22).
- Auditor probes in a scratch copy (L-23).
- Fail-safe and schema policies decided before coding (L-15, L-16).
- CI cost rules and early platform CI (L-17).
- Device distribution in Phase 2 (L-19).
- One `DECISIONS.md` and a living CHANGELOG (L-20).
- Explicit PR merge order (L-25).
- Scope questions before the phase step plan is fixed (L-29).

**New:**
- the adopt path for half-built apps (`AS-IS.md`, Phase A);
- the retro stage that feeds the playbook;
- `METRICS.md`;
- core `data-reviewer` and `privacy-reviewer`;
- panel packs: health-fitness (from Running-App) and plant-care (draft).
