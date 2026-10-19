# Metrics across projects

One block (table) per project, with one row per stage. Filled in by the project-end `/playbook:retro`. The point is to see whether playbook changes actually help: fewer audit rounds, fewer late surprises, and less CI waste.

## Running-App · playbook v0 (before the playbook existed) · Oct 2026

| Stage | Elapsed (span, includes idle time) | Commits | Audit rounds to 0/0 | First-round findings (C/M/m) | Code review Majors | Tests at close | Notes |
|---|---|---|---|---|---|---|---|
| R panel + audits | about 14 h over 2 days | 25 | 17 (closed at 10, reopened by the spike) | 8 / 22 / 11 | n/a | 309 SPEC test rows (289 live IDs) | SPEC v1.0→1.17 |
| 0 data spike | about 1 h | 6 | n/a | n/a | n/a | n/a | 3 needed fields never arrive |
| P1 engine | 1.5 h build + about 6 h audits | 27 | 4 + 4 narrow | 4 / 12 / 12 | 4 | 338 | 275 green tests missed 4 Critical |
| P2 persistence + sync + CI | about 15.5 h span | 18 | 5 | 0 / 3 / – | 5 correctness | 480 | Clock fail-safe grew mid-phase |
| P3 Today | 47 min | 11 | 2 | 0 / 4 / – | 4 | 559 | |
| P4 Review | 4.7 h | 19 | 3 | 0 / 7 / – | 6 + 5 | 686 | Step added mid-phase; CI minutes ran out |
| **Total** | 11 days | 109 (stage rows include 2 Phase 0 merges; + initial commit and 4 PR merges) | 35 safety-audit rounds after the panel | | 5 code reviews | 693 | Never run on the device by the end |

**Docs vs code:**
- 10.1k lines of markdown;
- 11.9k lines of Swift source;
- 9.3k lines of Swift tests.

**CI:** about 110 billed macOS minutes per full run. The 2,000 free minutes ran out on 18 Oct.

## Targets for the next project (playbook v1.0)

- Phase R audit loop closes in **5 rounds or fewer** (it took 17).
- No reopen of the loop by a late spike (the spike now runs before the panel).
- The first code audit finds **0 Critical** (invariant tests are written first).
- No CI-minute exhaustion.
- The app runs on the device by the end of Phase 2.
