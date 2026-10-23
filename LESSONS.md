# Lessons

Every lesson has an ID, the project it came from, the evidence, and where the playbook now uses it. New lessons come from `/playbook:retro`. **Never renumber.** Retire a lesson by striking it through and saying why.

**Kinds:**
- **Keep** means it worked; do it again.
- **Change** means it cost us; the playbook now does it differently.

| Source | Project |
|---|---|
| OF | Owner feedback, given directly (date in the lesson) |
| RA | Running-App (Oct 2026): adaptive training app, iOS + rules engine, 109 commits, 35 safety-audit rounds after the panel, 5 code reviews, 693 tests |
| RA-art | Running-App's art loop (21–23 Oct 2026): 5 ink drawings (widget, spot tree, launch mark, body map, street scene), about 40 Maker and Critic runs, one family board |

---

## Design and SPEC

**L-01 · Change · Run the data spike before expert review, not after.** *(RA)*
In Running-App the panel and 10 audit rounds polished rules that assumed data fields which, it turned out, never arrive (HRV status, readiness and weather all arrived on 0 of 366 days). The spike forced a rewrite (SPEC v1.11) and 7 more audit rounds.
→ PLAYBOOK stage 3 now comes before stage 4.

**L-04 · Change · One home for each rule.** *(RA)*
The plan and the SPEC restated the same rules, so every fix had to land twice, and drift between them was a recurring finding (RA-09, RA-11, RK-01, RL-05, RM-01). Within the SPEC, the same rule appeared in prose, in a table and in tests (RA-06).
→ The plan holds what a rule means and why. The SPEC holds the numbers, the algorithm and the tests, and points back to the plan. See templates/PLAN.md and SPEC.md.

**L-06 · Change · State machines are tables from day one.** *(RA)*
The row/override ledger was patched in prose for 6 rounds before one canonical definition was written. The clinician-hold feature then took 5 more rounds.
→ SPEC §7.n is a state/transition table. If the same area yields a Major two rounds running, stop patching and rewrite it canonically.

**L-09 · Change · Write a Definitions section.** *(RA)*
Even with 290 tests, the engine author logged about 25 "interpretations" (sample vs population SD, window inclusivity, what counts as a run).
→ SPEC §4.

**L-11 · Keep · The domain works by hand.** *(RA)*
The plan had paper logs, so week 1 ran from the document while the app was still being built. The app being late never blocked the user.
→ PLAN §8.

**L-15 · Change · Decide fail-safe policy for untrusted inputs before coding.** *(RA)*
Phase 2 took 5 audit rounds, mostly on a wrong device clock, and grew a whole subsystem mid-phase.
→ SPEC §4 Time; PHASE-HANDOFF "Decisions needed before step 1".

**L-16 · Change · Settle data-format strictness before the first persisted byte.** *(RA)*
A handoff rule (tolerant decoding) was reversed mid-phase (P1-04), which made earlier stores unreadable.
→ SPEC §6 schema-evolution rule.

**L-31 · Keep · The owner likes being interviewed. Make interviews thorough and easy to answer.** *(OF, 21 Oct 2026)*
Being interviewed was the part of the process the owner valued most. Matt Pocock's `grilling` technique makes interviews thorough and easy to answer:
- a design tree asked in rounds;
- a recommended answer that "yes" accepts;
- facts looked up, never asked;
- a shared-understanding finish.

→ `/playbook:grill`, adapted from it (MIT). Every skill that puts a decision to the owner now uses it.

**L-32 · Change · Grill the PLAN and SPEC before the panel.** *(RA)*
Many Running-App audit findings were really questions for the owner that surfaced late. About 12 bundles of SPEC §13 questions were answered with conservative defaults "pending Ben" during the audit loop, and settled only afterwards.
→ A spec grill now sits between the SPEC and the panel (PLAYBOOK stage 2; panel R0 checks it).

## Review panel and audits

**L-02 · Change · Write the invariants before round 1.** *(RA)*
The auditor rediscovered the same implicit invariants round after round.
→ SPEC §3. The auditor proves or refutes each one, every round ("Invariants checked: I1 ✓ …").

**L-03 · Change · Declare the exit rule and scope policy up front.** *(RA)*
The written exit was "no Critical", met at round 2. In practice the project ran to 0 Critical and 0 Major. Minors reported in rounds 1–9 (about 80) generated edits that created new Majors.
→ Exit is 0 Critical, 0 Major. Minors are batched into one polish pass. From round 2 the scope is the diff, the invariants and new Critical/Major. Each brief carries a do-not-re-raise list.

**L-05 · Change · Use a fix-impact checklist.** *(RA)*
Fixes were "not carried through to every surface" (RA-01, RL-01 to RL-08).
→ For each applied ID, list every surface it touches: PLAN, SPEC prose, tables, data model, UI, tests, CHANGELOG, DECISIONS. Grep for the old wording. See the `/playbook:audit` skill.

**L-07 · Change · Freeze scope before an audit loop.** *(RA)*
Rechecks and new features added after sign-off reopened the loop (re-audits 11–17).
→ Schedule expert rechecks before the loop, or batch them into one change set followed by one loop.

**L-12 · Keep · Reviewers advise, the owner decides, and the main session synthesises.** *(RA)*
- Read-only reviewers meant no reviewer could edit a file.
- The synthesis caught reviewer errors: wrong dates, and a misread contradiction.
- The ⚠ loosening marker enforced "never weaken a safety rule without separate sign-off".

**L-10 · Keep · Use a conservative, reversible default while waiting.** *(RA)*
Auditor questions got the safest answer, marked "pending owner". The owner confirmed them in one batch, so work never blocked.

**L-22 · Change · Verify citations.** *(RA)*
Expert rechecks said "citations from memory, unverified", even though they had web tools.
→ The reviewer template now requires each citation to be checked, or tagged `[unverified]`.

**L-24 · Keep · Put a machine-readable verdict line at the top of every audit.** *(RA)*
The original used `Critical: n · Major: n` from re-audit 2. It is now required from round 1, in the form `Critical: n · Major: n · Minor: n · Nit: n`.

**L-21 · Change · Use readable finding IDs.** *(RA)*
Letter-per-round IDs (P1, Q1, R1 … W3, CR5) were unique but confusing (P1 vs Phase 1; CR5 was in Phase 4).
→ `<stage>-<reviewer><round>-<nn>`, e.g. `R-SA3-02`, `P4-CR1-06`.

## Build phases

**L-08 · Change · Example tests are not invariant tests.** *(RA)*
275 green acceptance tests missed 4 Critical bugs in the engine, because the guardrails had no tests of their own.
→ SPEC §13.I invariant tests are written before the first code audit.

**L-13 · Keep · Keep the logic pure and testable in the cloud.** *(RA)*
Most logic was tested under `swift test` on Linux, and the UI holds no rules. Cloud sessions could build and test almost everything.

**L-14 · Keep · Write handoff docs with fixed fields.** *(RA)*
Six sessions each started cold from one file and finished their phase without asking where things stood.
→ templates/PHASE-HANDOFF.md.

**L-17 · Change · Budget CI for its cost, and start platform CI early.** *(RA)*
Running 4 macOS jobs on every push used up the month's 2,000 free minutes (macOS bills 10×, about 110 minutes a run). Platform code drafted with no compiler broke when CI first ran.
→ Run a cheap job on every push. Run platform jobs only on PRs, `main` and manual runs. Stand platform CI up at the start of the first phase that touches platform code.

**L-18 · Change · Don't review a moving target.** *(RA)*
In Phase 4 a step was added while reviewers ran ("HEAD moved while the review was running"). That forced a second code review, which found 5 Majors.
→ Freeze the branch, or review a snapshot. No new steps while reviewers run.

**L-19 · Change · Get onto the real device early.** *(RA)*
After Phase 4 the app had still never run on the owner's phone. Every phase's device "Done when" clause was unmet.
→ A way to run it on the real device (e.g. TestFlight for iOS, an installable build or deployed preview for others) is a Phase 2 deliverable.

**L-20 · Change · Keep the SPEC and CHANGELOG alive through the build.** *(RA)*
The SPEC froze at v1.17. Later decisions went into a 650-line notes file, and the CHANGELOG stopped at Phase R.
→ One `DECISIONS.md` log, plus a readable `NOTES-FOR-OWNER.md` diary (Flags vs Interpretations, kept from the original). One CHANGELOG entry per phase close. Bump the SPEC whenever a decision changes a rule.

**L-23 · Change · Let auditors run probes.** *(RA)*
Read-only auditors "could not run the tests", so pass counts were self-reported. Later audits ran probe tests in a scratch copy and caught real bugs.
→ The auditor may run tests in a scratch copy outside the repo.

**L-25 · Change · Be explicit about PR merge order.** *(RA)*
Stacked phase PRs sat open for days, PR bodies went stale, and the merge order differed from what the PR text said.
→ Merge each phase PR before the next phase starts, or state the order in every PR body.

**L-26 · Keep · Add regression tests for each review.** *(RA)*
Each review got its own test file (e.g. `CodeReview4Tests`). The tests are mutation-checked: they fail when the fix is reverted.

**L-27 · Keep · Split work across models deliberately.** *(RA)*
- The strongest model handles coupled logic and code review.
- Sonnet runs the read-only reviewers and auditors.
- Tightly coupled logic is never split across parallel agents.
- No model names appear in commits or code.

**L-28 · Keep · Keep personal data out of the repo.** *(RA)*
The spike reported fill rates, not values. Fixtures were hand-written. Raw output was git-ignored. The owner was asked for "no screenshots".

**L-29 · Change · Ask scope questions before the step plan is fixed.** *(RA)*
The Phase 4 planner was added mid-phase and produced its largest cluster of Majors.

**L-30 · Keep · Fix root causes, then narrowly re-audit the fix.** *(RA)*
Fixes introduced new Criticals (E2-01). Root-cause fixes plus a narrow re-audit of the fix commit closed them.

## Art and visual design

See PLAYBOOK "The art loop" and `examples/running-app/ART-LOOP.md`.

**L-33 · Keep · Gates before taste, calibrated on today's art.** *(RA-art)*
Agents can't judge fine detail at true size. Every visual verdict carried numbers from a script: line width at display size, contrast, a dark-mode outline-to-fill ratio, gradients, colours that aren't tokens, file size. Each gate was first run on today's art: the street's measured 0.44 pt median matched the earlier coherence measure before any Maker ran. The widget pilot's first line gate was wrong, and two Makers caught it.
→ Write and calibrate the gate script before the wide round; test it on known inputs (ruled test lines).

**L-34 · Keep · Blind critics with today's art hidden as a control.** *(RA-art)*
Today's art, relabelled among the variants, ranked last in every blind round across five pieces. One critic's score moved by ±0.4 on the same image between runs, so two critics are averaged.
→ Two blind critics per round, variants shuffled, today's art hidden. If the control doesn't come last, the review is broken.

**L-35 · Change · The owner picks straight after the wide round; polish is directed edits.** *(RA-art)*
In the widget pilot, open-ended polish rounds fixed checkable faults but drifted on taste: the jacaranda became an acacia while meeting every number.
→ After the wide round, the owner picks or mixes. Each later edit is one Maker with an exact change list and a "must not change" list.

**L-36 · Keep · One board for every piece, at real size, light and dark.** *(OF, 22 Oct 2026)*
Family problems (two pens, three dark-mode treatments, a 2× spread in line weight) only showed with every drawing side by side. The owner asked for every iteration to go on one page, updated in place.
→ A generated family board, one link, republished after every round; history rows below the current pieces.

**L-37 · Change · The owner's eye catches what the rubric misses: add a composition check.** *(RA-art)*
Critics scored the street's directed edit well. The owner saw at once that it had no ground ("everything looks disjointed") and that a half-outlined skyline looked wrong; later, that the bins didn't sit on the footpath.
→ The rubric gains a composition item: a continuous ground, every object grounded, one treatment per depth layer.

**L-38 · Change · Tell final reviewers what's decided.** *(RA-art)*
Reviewers twice asked to redraw the shared jacaranda, the app's one tree, which the owner had fixed as an input.
→ Final-review briefs list the decided points and ask for at most 5 small fixes, or "none".

**L-39 · Change · When cutting detail, keep each element's frame.** *(RA-art)*
Halving the terrace lines turned the balconies into "just a shade". The owner asked for the frame back.
→ Cut infill (lace, repeats, hatching) before frames (rails, posts, edges).

**L-40 · Keep · Reproducible variants.** *(RA-art)*
Each variant folder held only its changed generator files and a `make.py` that rebuilt the export byte-identical from the base branch. Rounds resumed cleanly after four container restarts, and every edit could be diffed.
→ Every Maker confirms the previous variant rebuilds byte-identical before editing, and delivers a `make.py`.

**L-41 · Keep · Reviewer points go to the owner as a tick list.** *(OF, 23 Oct 2026)*
"Have sub agents review it and send me their feedback for whether I agree or not." The owner ticked four of six points and rejected two (one clashed with an earlier decision, which the question said).
→ Merge both reviewers' points, put them as a multi-select question with a recommendation and a clash note, apply only the ticked ones.

