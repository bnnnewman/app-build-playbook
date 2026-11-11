# Lessons

Every lesson has an ID, the project it came from, the evidence, and where the playbook now uses it. New lessons come from `/playbook:retro`. **Never renumber.** Retire a lesson by striking it through and saying why.

**Kinds:**
- **Keep** means it worked; do it again.
- **Change** means it cost us; the playbook now does it differently.

| Source | Project |
|---|---|
| OF | Owner feedback, given directly (date in the lesson) |
| RA | Running-App, later named First Light (Oct 2026): adaptive training app, iOS + rules engine. The first 109 commits |
| RA-art | First Light's art loop (21–23 Oct 2026): 5 ink drawings, about 40 Maker and Critic runs, one family board |
| FL2 | First Light after playbook v1 (19 Oct – 11 Nov 2026): 1,562 commits, 86 PRs, about 60 audit loops, 795 decisions, tests 720 → 4,082 |
| FB | Flobbadob (Oct 2026): plant-care iOS app, adopted onto playbook v1.0; 140 commits |
| PT | A work policy tracker (Oct 2026): a published page, a database and a weekly routine, adopted onto v1.0.2; 222 commits |
| EC | A work enrolment checklist (Sep–Nov 2026): a web page built with no playbook; 59 commits |
| PB | This playbook itself (Nov 2026): the version 2 rebuild and its reviews |

---

## Design and SPEC

**L-01 · Change · Run the data spike before expert review, not after.** *(RA)*
In Running-App the panel and 10 audit rounds polished rules that assumed data fields which, it turned out, never arrive (HRV status, readiness and weather all arrived on 0 of 366 days). The spike forced a rewrite (SPEC v1.11) and 7 more audit rounds.
→ The spike (stage 3) comes before the panel (stage 5).

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
→ SPEC §4 Time; the build grill (`/playbook:build` step 2).

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
→ `templates/HANDOFF.md`.

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
→ One `DECISIONS.md` log. *(The separate notes diary was dropped in v2: see L-75.)* One CHANGELOG entry per phase close. Bump the SPEC whenever a decision changes a rule.

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

See `/playbook:art` and `examples/running-app/ART-LOOP.md`.

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

**L-42 · Keep · Finish with one family review of every piece together.** *(RA-art, OF 23 Oct 2026)*
Each piece had passed its own final review, yet six panellists looking at the whole set at once found 16 cross-piece
points: one tree drawn with two outline colours, a warm plane among cool greys, paper-coloured patches that would show
on tinted icons, a lilac-tinted shadow, token drift between the colour file and the art. The owner agreed 12 and
rejected 4 (each clash with an earlier pick was marked).
→ After the last piece is locked: every panellist reviews the family as one unit, points are merged with "who raised
it" and clash marks, the owner ticks what to apply, fixes run one Maker per area (one owner of the token file), then a
full vector check and the lock.

## Version 2: what four projects taught (Nov 2026)

Evidence for each is in `examples/2026-11-deep-dive.md`.

### The owner

**L-74 · Change · Write the owner's standing preferences once.** *(FL2, FB, PT, EC)*
About eleven preferences were asked again and again as if new (fewer words, one consistent look, build it now,
tighten freely, follow the clinician…). Reviews twice proposed things he had already refused. Five repos each
restated how to work with him, differently. → `OWNER.md`, read first by every session and reviewer; a question it
answers is logged "by profile", not asked.

**L-76 · Change · Ask the way he answers.** *(FL2, PT)*
He takes the recommendation about 90% of the time, in bulk, with named exceptions ("yes to all except 12. I like 12c
better"). The exceptions are the decision. He approved the wrong thing when an option didn't say what it did (three
reversals), and two safety questions once slipped inside a "yes to all". → `/playbook:grill`: numbered once, every
option says what it does, answers read back, ⚠ never in a round, direction and look asked separately.

**L-51 · Keep · Teaching is a mode, asked again each build.** *(FB)*
The owner wrote "treat every session as teaching, not just building" before the playbook existed, and the playbook
never mentioned it. By the end of the month his instruction was "cut the Xcode work". → teach / explain / ship, set
at start and re-asked by `/playbook:build`; `docs/owner/LEARNING.md`; a teach output style.

**L-78 · Change · Say where the work is.** *(FL2, FB, EC)*
He asked for work that was already merged; took "build succeeded" for "tests passed"; one project had no record of
what was live. → the footer (on main · on a branch · on your phone), `STATUS.md`, a publish log, `GLOSSARY.md`.

### Set-up

**L-50 · Change · Ask the harm questions before the size.** *(FB, EC)*
One project was sized before the dog was mentioned; the dog then produced all 3 Criticals. Another was never sized,
and handled fee and visa status. → harm questions first in `/playbook:start`.

**L-49 · Change · Small tools grow: check at every session start.** *(EC)*
A 3-day prototype became a 7-week programme with gates, a privacy assessment and an IT build, with no plan, tests or
decision log. → Mini size (`BRIEF.md`) with a grow check; `status` re-asks it.

**L-48 · Change · Copy the real field names on day one.** *(EC)*
The pretend data said "Visa pending"; the real list said "Visa Pending" and had a status the mock lacked. Found on
day 9: "a small spelling difference can't show a checklist to the wrong student". → the mini spike, at every size.

**L-53 · Change · Prove the set-up before the first feature.** *(FL2, FB)*
Seven builds broke on Apple's tools after merging; a delivery route was re-derived from a sibling repo over three
days. → `/playbook:start` step 2 and `platforms/`.

**L-84 · Keep · Rules in a plain package the session can test.** *(FB, FL2)*
148 tests in under a minute, in the cloud. The best single change in one project.

**L-98 · Change · A scan test that every stored field is mapped.** *(FL2)*
A new field was silently not saved twice in one day; each was a Critical.

**L-77 · Change · A fixed layout, and nothing else at the root.** *(FL2)*
29 root files, 13 of them dead; 300 review files in one flat folder; handoffs in three places. → PLAYBOOK "Project
layout", `work/<build>/`, `/playbook:tidy`.

**L-83 · Keep · One document per reader.** *(EC, FL2)*
README for colleagues, an agreement for builders, a manual for the owner, a guide for a maintainer.

### Decisions and records

**L-75 · Change · The decision log is an index, and the only record.** *(FL2, FB, PT)*
One log reached 405 KB and 40 kinds of status, out of order, with build notes in the answer cell. Forty-three
"pending" rows were never updated when settled. A second notes file went stale after a week; another kept "your
answer: pending" slots for weeks. → `templates/DECISIONS.md` (one line per decision; detail in
`work/<build>/NOTES.md`; both rows updated when one settles another); `scripts/decisions.py`.

**L-71 · Change · Namespaces, not ranges.** *(FL2, PT, FB)*
Sessions collided on decision numbers three times and on spec sections once; one decision was recorded twice.
→ `D-<build>-nn`; the brief hands out everything else that could collide.

**L-70 · Change · Retros must be small, and must write back.** *(FL2, FB, PT)*
One retro in 23 days and 60 loops; its one owner comment produced tiered audits the same day. Sixteen proposed
lessons never reached this repo, and three projects reused L-31 and L-32. → `/playbook:retro`: five minutes, numbers
by script, the question inside the merge message, `<project>-L<n>` until this repo assigns a number.

### Design

**L-43 · Change · Design before the first screen.** *(FL2)*
Retrofitted: 853 copy findings, 73 Majors on the lock, 8 Critical and 134 Major on the page pass, about 480
decisions. → stage 4.

**L-63 · Keep · A mock-up before any visible change.** *(FL2, PT, FB)*
"Now vs options" on made-up data became his main way of deciding. He won't pick a look from words.

**L-44 · Keep · A lock is tested by "would two careful builders differ?"** *(FL2)*

**L-45 · Change · A lock needs lanes and a ledger from the start.** *(FL2)*
Ten versions in seven days and 1,347 lines; there was no fast lane until a critique asked for one.

**L-46 · Keep · Pin safety wording by test; a copy pass over it needs the auditor.** *(FL2, FB)*
Of 245 safety lines rewritten to be clearer, 50 had drifted to softer or wrong.

**L-61 · Keep · The owner's screenshots beat a code-only panel.** *(FL2)*
Four screenshots: 32 faults that twelve reviewers had missed.

**L-97 · Change · An accessibility claim needs a device check.** *(FL2)*
Five panels read code; nobody ran the app. A contrast claim was false for 8 of 22 colours.

**L-96 · Keep · Short skills written for the project outlast big borrowed ones.** *(FL2)*
Three third-party design skills (over 20,000 lines) were installed and dropped; two short project skills remain.

### Reviews and audits

**L-52 · Change · A build, with review lanes in parallel.** *(FL2)*
The phase and its single loop were replaced within a week by: lock first; safety, code and design-lock lanes on a
frozen commit; a logic review for rules; each fix re-checked by its lane. → `/playbook:build`, `/playbook:close`.

**L-56 · Change · Tier the checks to the change.** *(FL2, OF 29 Oct 2026)*
"Do we need to restart audits every time I bring new ideas?" → the tier table (`GLOSSARY.md`, `/playbook:audit`).

**L-59 · Change · Loops end by simplifying, a close-out, or a trial.** *(FL2, PT)*
One feature took 18 audit rounds. The round-5 breaker asked three times and he chose "fix and recheck" each time;
it ended with an invented close-out rule, a cut feature, and a trial page that found what ten document rounds had
not. When a rewrite fails twice, change the kind of rule.

**L-55 · Change · Reviewers read what's decided first.** *(FL2, FB)*
Three reviewers said they hadn't opened the decision log; "the review should have checked it".

**L-60 · Keep · A verifier after each reviewer.** *(FL2)*
241 raw findings: 101 confirmed, 129 corrected, 10 already decided, 1 refuted.

**L-68 · Keep · A logic review with a simulated period of use.** *(FL2)*
After 55 closed audits and 3,500 green tests it found 6 serious rule gaps, including week-on-week jumps of over 50%.

**L-57 · Keep · When adopting, audit before planning the fixes.** *(FB)*

**L-58 · Change · Size the stages separately.** *(FB)*
A Standard panel was right; 13 review files and 5 rounds for a build with no Criticals was heavy.

**L-47 · Keep · Replay a rule on the owner's history before changing it.** *(FL2)*
He refused a loosening blind and accepted it once he saw the counts.

**L-54 · Change · Cap unrun code; never state a count no command produced.** *(FB)*
Sixteen tests sat unrun for 11 days; a test count was wrong three times.

### Release and after

**L-62 · Change · Write acceptance first; automate what a machine can check.** *(FL2)*
A checklist grew to 373 boxes; 103 were later turned into scenario tests. About 100 device steps were never
recorded as done.

**L-64 · Change · Real use before polish.** *(FL2)*
Four polish stages ran before three days of use; most screens were then redone.

**L-66 · Keep · Owner independence before the first release.** *(FL2)*
A manual for life without a session, a maintainer's guide with a renewals table, an owner-editable setting that
validates itself. Blanks left for the owner to fill were never filled: the session records them.

**L-67 · Change · No hard freeze: an ideas inbox and small releases.** *(FL2)*
A freeze was declared and held for a day; eight idea builds followed in two weeks. Built ideas were never marked.

**L-65 · Change · Spike the platform before designing a routine.** *(PT)*
Three routine designs in one day; the second failed on something the platform wouldn't do.

**L-69 · Keep · Routine safety rules.** *(PT)*
The agent computes nothing; code pinned by fingerprint; same-step change control; no connectors; data is never
instructions; say what risk remains. → `platforms/routine.md`, `automation-reviewer`.

**L-79 · Change · Operating a tool is a stage.** *(PT)*
About a third of one project was running it: updates on the owner's word, pinned writes read back, go-live
decisions, other sessions writing at once. → `/playbook:operate`.

**L-91 · Keep · A trial copy with made-up data for anything that writes.** *(PT)*

**L-80 · Keep · Research, then options, then he picks.** *(PT)*
Used three times; each decision took one step. → `/playbook:options`.

**L-81 · Keep · An interface agreement when someone else builds part.** *(EC)*

**L-82 · Keep · A user-testing round for other people.** *(EC)*
Scripted steps, a practice copy, feedback by email. It found what no reviewer did.

### Working method

**L-85 · Keep · Start a test run from the session with a trigger file.** *(FB)*
Tag pushes are refused from cloud sessions; one changed file started 18 test runs, with no paid CI.

**L-72 · Change · Plan for the allowance.** *(FL2)*
The plan's end date shaped the whole order of work, and only one document ever gave costs. → quote usage windows;
heavy steps first; on a small plan, one session and tiered checks.

**L-73 · Change · `git status` before `git add -A`; real data to absolute scratch paths.** *(PT, EC)*
Two screenshots of live data were committed by a script and had to be removed from history.

**L-99 · Keep · Roles, not names; scan for names without storing them.** *(PT, EC)*

**L-86 · Change · A fix for a data quirk goes to every reader, through one helper.** *(PT)*

**L-87 · Change · Write helpers patch named fields; they refuse whole nested objects.** *(PT)*

**L-88 · Change · Check a guard test on a copy; never `git checkout` over uncommitted fixes.** *(PT)*

**L-89 · Change · When a fix changes how text is read, compare output on a copy of real data.** *(PT)*

**L-93 · Change · Device-only tests go in the try-out, with their IDs.** *(FB)*

**L-94 · Change · Pull a rule out of its screen in the step that changes it.** *(FB)*
Eighteen test IDs were untestable until the last step.

**L-95 · Change · A short "never do on the Mac" list.** *(FB)*
Accepting an editor's recommended settings on main sent a build to the phone.

**L-100 · Change · A new playbook version needs an upgrade step for projects already running.** *(PB)*
At version 2, three projects held old copies of the skills and their own local rules, and nothing said how to move
them. `/playbook:start upgrade` keeps the project's decisions and IDs and swaps only the process.

**L-101 · Change · Anything with sign-in or a connection to another system gets a security lane.** *(PB)*
One web tool settled its sign-in, an emailed code and a read-only connection case by case, with only a privacy
reviewer to ask. Privacy covers what is held; security covers who can reach it.

*(L-90 and L-92 were proposed by a project and folded into L-59 and L-76.)*
