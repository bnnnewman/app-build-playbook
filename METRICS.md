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

## First Light after playbook v1 · v1.0–v1.1, mostly improvised beyond it · 19 Oct – 11 Nov 2026

1,562 commits, 86 PRs, about 60 audit loops, 795 decisions, tests 720 → 4,082. Paid CI: 0.

| Stage | Loops | Rounds to 0/0 | Notes |
|---|---|---|---|
| Spec audits (backup, part II, routes, watch, plan v3) | 6 | 8, 6, 4, 4, 6+3 | Spikes ran first for routes and watch; neither loop reopened |
| Code builds (roadmap steps, clusters K1–K12) | about 25 | median 3; one of 7, two of 5 | Criticals moved to the compile and code-review lanes: 7 broken builds, a stored field dropped twice |
| Whole-app QA, UX/accessibility, release | 3 | 4, 3, 2 | Whole-app reviewers found the two worst items, both pre-existing |
| Idea builds 1.1–1.4 (tiered) | 9 | 1–2 each | One whole-batch pass: 0 Major |
| Design lock and page pass | 2 | 1, then per-build | Panel: 2 Critical. Page pass: 8 Critical, 134 Major on a "finished" app |
| Design builds 1.5a–1.5n (three lanes) | about 12 | 2–4 per lane | |
| Logic review + season simulation | 1 | proposals | 6 serious rule gaps after 55 closed audits |

One retro in the period. About 100 device steps were never recorded as done until an acceptance checklist existed.

## Flobbadob · playbook v1.0.0 (adopt) · 19–31 Oct 2026

| Stage | Commits | Rounds to 0/0 | First round C / M | Tests at close | Notes |
|---|---|---|---|---|---|
| Adopt, plan, spec, panel (6 reviewers + recheck) | 34 | 4 | 0 / 9 (auditor); 3 Critical from the panel, all the dog | 54 written, 38 run | Standard, chosen over the recommended Light |
| Build A (A1 + A2), one day | 76 | 3, then 2 | 0 / 10 | 148 in the package | 18 test runs on the build service via a trigger file; 3 red |
| Design (D) | 5 | n/a | n/a | n/a | Stopped at round-0 mock-ups |

Device try-outs: 18 of 18 steps came back done.

## A work policy tracker · playbook v1.0.2 (adopt) · 20 Oct – 1 Nov 2026

| Stage | Rounds to 0/0 | Notes |
|---|---|---|
| Plan-and-spec audit | 6 (0 Major from round 5) | Test IDs grew 103 → 266 during review |
| Builds A, 1a, 1b, 2 | 2–4 each | The audit ran before the first live write |
| One page-editing feature (3a): design audit, build, page-change review | **10 + 3 + 5 = 18** | Ended by a close-out rule, a cut feature and a trial page |

Three routine designs in one day. CI never started. Two screenshots of live data were committed and removed.

## A work enrolment checklist · no playbook · Sep–Nov 2026

59 commits. No plan, spec, decision log or automated tests. Three review passes; only their fixes survive. Real field
names checked on day 9 of 12.

## How v1's targets held

| Target | First Light | Flobbadob | Policy tracker |
|---|---|---|---|
| Design audit loop ≤ 5 rounds | Median 3; three over | **Met: 4** | 6; one feature 18 |
| No reopen by a late spike | **Met** | **Met** | **Met** |
| First code audit: 0 Critical | Safety lane met; compile and code lanes not | **Met** | **Met** |
| No CI-minute exhaustion | **Met** | **Met** | n/a |
| On the device by the second build | **Met** | **Met** | n/a |

## Targets for the next project (playbook v2.0)

- **No audit loop past 5 rounds.** Simplify is offered at round 3.
- **0 builds broken on the build service** after the set-up check.
- **0 decisions re-asked** that `OWNER.md` already answers; 0 reviewer proposals that reopen a decision unmarked.
- **Nothing "pending" for more than 7 days.**
- **A retro at every merge**, with the owner's answer recorded; proposals reach this repo within the project.
- **Design lock before the first screen**; under 50 design findings at the first whole-app pass.
- **Acceptance:** every device step has a recorded result.
