# Playbook changelog

Newest first. Versions use semver (see `.claude/CLAUDE.md`).

## 1.3.0 · 23 Oct 2026

- **Art loop step A10, the family review** (L-42): after the last piece locks, every panellist reviews the whole set together; merged points with clash marks go to the owner as a tick list; one Maker per area applies them; then the vector check and the family lock.

## 1.2.0 · 23 Oct 2026

- **New: the art loop** (PLAYBOOK "The art loop", from Running-App's art rounds, 21–23 Oct): coherence review and a family style sheet, calibrated gates, a wide round of three Makers, two blind critics with today's art as a control, the owner's pick, directed edits, a final review, and a vector check. One family board for every iteration.
- Lessons L-33 to L-41 (RA-art and owner feedback).
- New `templates/ART-BRIEF.md`; worked example `examples/running-app/ART-LOOP.md`.

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
