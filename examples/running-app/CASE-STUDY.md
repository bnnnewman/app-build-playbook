# Case study: Running-App (Oct 2026)

*The project this playbook was mined from. Repo: `bnnnewman/Running-App`. It describes the process only; no personal health values are included.*

**What it is:** a single-user adaptive training app for a 12-week running block.
- An iOS app (SwiftUI and SwiftData) on top of a pure Swift rules engine.
- Data comes from a watch via the Intervals.icu API, a CSV export and a 20-second morning check-in.
- It produces a daily traffic light, session adjustments, pain and safety flags, and a Sunday review that proposes the next week. The owner confirms or overrides.

## Timeline

| Stage | When | Commits | What happened |
|---|---|---|---|
| Design (before the repo) | before 8 Oct | – | The plan, SPEC and REVIEW-PANEL were written outside git (in claude.ai chat, inferred), all addressed "For Claude Code" |
| Phase R: panel | 8 Oct | 1 | 8 Sonnet reviewers in parallel → SUMMARY → owner decisions → re-audits 1–2 |
| Phase R: re-audit loop | 8 Oct, about 45 min | 13 | Re-audits 3–10, each a fix plus a version bump; closed at 0/0 |
| Phase 0: data spike (parallel session) | 8 Oct, about 1 h | 6 | 3 needed fields never arrive |
| Recheck + second loop | 8–9 Oct, about 30 min | 11 | Data rewrite, physio recheck, re-audits 11–17 |
| Phase 1: engine | 9 Oct | 27 | 1.5 h build; about 6 h of audits and code review |
| (gap) | 10–16 Oct | – | Week 1 ran by hand from the plan, as designed |
| Phase 2: persistence, sync, CI | 16–17 Oct | 18 | 5 audit rounds, mostly about the device clock |
| Phase 3: Today screen | 17 Oct, 47 min | 11 | 2 audit rounds |
| Phase 4: Sunday review | 18 Oct, 4.7 h | 19 | A step added mid-phase; CI minutes ran out |
| Merges | 10 and 19 Oct | 4 | PR #1 on 10 Oct; the stacked PRs #4 → #3 → #2 top-down on 19 Oct, within 9 seconds |

Totals:
- 109 commits over 6 sessions;
- 51 review files: 8 panel reviews, 2 rechecks, 1 SUMMARY, 35 safety audits (17 plan/SPEC re-audits, 8 engine, then 5 / 2 / 3 in Phases 2–4) and 5 code reviews;
- SPEC v1.0 → v1.17, plan v2.0 → v2.16;
- 693 tests, covering 289 live SPEC test IDs (309 rows including tombstones and suffixes).

Commit counts by stage include two Phase 0 merge commits; with the initial commit and the PR merges the total is 109.

## What made it good

- **Two documents with separate jobs.** The plan was runnable by hand. The SPEC had §0 gates, locked constants, precedence lists and 290 Input→Expected tests.
- **The safety-logic auditor was the most valuable agent.** It found all 8 initial Criticals using worked counter-examples, and its "missing tests" became the engine's test suite.
- **Clear roles:**
  - reviewers advise and never edit;
  - the main session synthesises and catches reviewer errors;
  - the owner decides per ID;
  - ⚠ marks any loosening.
- **The owner never blocked work.** Every open question got a conservative, reversible default, confirmed later in one batch.
- **Handoffs let 6 cold sessions continue** with no "where were we".
- **The architecture let the cloud test almost everything:** a pure engine and app-state layer under `swift test` on Linux, with the UI holding no rules.
- **Traceability.** Every finding had an ID, every fix commit cited it, every decision was recorded, and every review got a regression test file.

## What cost the most (and the playbook fix)

| Cost | Fix in v1.0 |
|---|---|
| Spike after 10 audit rounds → 7 more rounds | Spike before the panel (L-01) |
| 17 plan audit rounds, mostly fixes creating the next issue | Invariants up front, narrow scope, fix-impact checklist, the "two rounds → rewrite" breaker (L-02, L-03, L-05, L-06) |
| Rules duplicated in plan and SPEC | One home for each rule (L-04) |
| 275 green tests missed 4 Critical bugs | Invariant tests (L-08) |
| Clock and data-format policies decided mid-phase | Decided before the first step (L-15, L-16) |
| CI minutes exhausted; platform code compiled late | CI cost rules, early platform CI (L-17) |
| Reviews of a moving branch | Freeze before review (L-18) |
| Never run on the device | Device distribution in Phase 2 (L-19) |
| SPEC froze; decisions scattered | One DECISIONS.md and a living CHANGELOG (L-20) |

## Files worth reading in the Running-App repo

- `REVIEW-PANEL.md`: the original panel script.
- `reviews/SUMMARY.md`: a full synthesis, with 26 sections of decisions.
- `reviews/safety-logic-auditor-reaudit-6.md`: the round where patching stopped and the rule was rewritten canonically.
- `PHASE4-HANDOFF.md`: the most complete handoff.
- `RulesEngine/scripts/coverage.py`: the SPEC test ID → test coverage matrix.
