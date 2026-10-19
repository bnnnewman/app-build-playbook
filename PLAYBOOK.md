# The app build playbook

*Version 1.0.2 · 19 Oct 2026 · Built from the Running-App project (see `examples/running-app/CASE-STUDY.md`). Lessons are in `LESSONS.md` and are cited as L-nn.*

This is the process for building an app with Claude Code, from first idea through expert review to a tested build:
- every stage has a **gate**: a clear "done when";
- every change is **traceable**: an ID, a decision, a commit;
- the owner **decides**, and reviewers only advise.

The plugin skills (`/playbook:start`, `/playbook:status`, …) run each stage. This file explains the why.

---

## The stages at a glance

```
0 Start / Adopt ─► 1 Plan ─► 2 SPEC ─► 3 Data spike ─► 4 Expert panel ─► 5 Audit loop ─┐
                                                                                       │
     ┌──────────────── (adopted apps: Phase A, an audit of the existing code) ◄────────┘
     ▼
6 Build phases (repeat):  handoff ─► questions ─► phase plan ─► steps (commit each) ─► freeze ─►
                          safety audit + code review ─► fix ─► narrow re-audit to 0/0 ─►
                          CI green ─► try it on the device ─► status + notes + CHANGELOG ─► PR ─► next handoff
     │
     ▼
7 Retro: a short one per phase; a full one at project end that feeds LESSONS.md and the playbook
```

| Stage | Skill | Output | Gate (done when) |
|---|---|---|---|
| 0 Start / Adopt | `/playbook:start` | Project `CLAUDE.md` with the Playbook map; `AS-IS.md` if adopting | The owner agrees the map, the size and the starting stage |
| 1 Plan | `/playbook:design plan` | `PLAN.md` | The owner can run the domain by hand from it |
| 2 SPEC | `/playbook:design spec` | `SPEC.md` (invariants, definitions, state tables, tests) | Every PLAN rule has a SPEC home and at least one test; invariants listed |
| 3 Data spike | `/playbook:spike` | `spikes/<source>-field-report.md` (fill rates, no values) | The owner has seen which fields really arrive; SPEC updated |
| 4 Expert panel | `/playbook:panel` | `reviews/R-<code>0.md`, `reviews/SUMMARY.md`, decisions | Every Critical and Major item has an owner decision; accepted changes applied |
| 5 Audit loop | `/playbook:audit R` | `reviews/R-SA<n>.md`, then `phases/P1-HANDOFF.md` | 0 Critical, 0 Major; Minors batched once |
| 6 Build phase | `/playbook:phase-start`, `/playbook:phase-close` | Code, tests, `phases/P<n>-PLAN.md`, notes, PR, next handoff | The SPEC "Done when" holds; safety audit at 0/0; code review fixed; CI green; device check done or recorded as not met |
| 7 Retro | `/playbook:retro` | `retros/<stage>.md`; at project end, lessons and metrics | Numbers recorded; at project end, playbook changes proposed |

At any point:
- `/playbook:status` reads the project and says which stage you're at, what's open and what to do next.
- `/playbook:decide` batches open questions for the owner and records the answers.

---

## Sizing the process

Running-App was health-adjacent: a wrong answer could injure someone. That justified 8 reviewers and 35 audit rounds. Most apps need less. `/playbook:start` asks **"How bad is the worst thing the app could get wrong?"** and records the size in the Playbook map.

| Size | When | Panel | Audit loop | Retros | Coverage matrix |
|---|---|---|---|---|---|
| **Light** | Worst case is annoyance or a small loss (e.g. a dead houseplant, a missed reminder) | About 3 reviewers: `logic-auditor`, `adherence-reviewer`, 1 domain expert (the owner chooses if data or privacy also matter) | Cap at 3 rounds, then the owner decides | Project end only | Optional |
| **Standard** | Real money, data or property, or harm to pets or plants that matter to you | 5–6 | Usual exit (0/0), loop breakers at round 5 | Short one per phase | Yes |
| **Full** | Health, safety or financial advice | 6–8, plus rechecks | Usual exit, every invariant every round | Short one per phase | Yes, and in CI |

Every size keeps the same core:
- PLAN and SPEC with invariants;
- the spike when there's external data;
- owner decisions;
- invariant tests;
- handoffs;
- the phase-close review.

The size can change. Revisit it if a harm turns up that's worse than expected.

---

## Stage 0: Start a new app, or adopt a half-built one

**New app.** Interview the owner, covering:
- purpose;
- stack, and what the "device" is for this platform;
- environment: local machine, cloud sessions, or both;
- external data;
- the worst harm (this sets the size and defines "Critical");
- hard constraints;
- how the domain works without an app today.

Then create the project layout (below) and the project `CLAUDE.md` from `templates/PROJECT-CLAUDE.md`.

**Adopt an existing app.** This is the path for something like Flobbadob. Don't throw away what's built, and don't redesign anything before you understand it:
1. **Baseline.**
   - Record `git status`, the branch and the last commit. If the tree is dirty, ask the owner to commit or stash first.
   - Work on a `playbook/adopt` branch.
   - Run the build and tests, and record what happens.
2. **Secret and personal-data scan.** Check the tree and the history for keys, tokens, exports and personal data. Check the `.gitignore` coverage. Report to the owner before any push.
3. **Owner's intent.** Ask for existing notes, issues, chat exports and ideas, and read them first. The code shows what the app *does*. The notes show what it was *meant* to do.
4. **Inventory.** Write **`AS-IS.md`**:
   - features, each with a state;
   - **rules found in the code** (AS-01…), each marked *intended / accidental / unknown*;
   - risks;
   - open questions.
5. **Recover the design docs.** Draft `PLAN.md` and `SPEC.md` from AS-IS, the notes and an owner interview. Tag each rule's provenance: *found in code (AS-xx)*, *confirmed by owner*, or *new*.
6. **Re-enter the stages:**
   - stage 3, if the app uses external data;
   - then stages 4–5 on the recovered docs;
   - then **Phase A**: retro-fit the invariant tests, then audit the existing code module by module against the SPEC and fix the Criticals and Majors;
   - then normal build phases, starting at P1, for what's left.

## Stage 1: The plan (domain truth, human-facing)

Template: `templates/PLAN.md`.
- **§0 "If you read nothing else":** one screen with the few rules that matter.
- **§1 Real data first:** facts from what the owner actually has, not hopes.
- **§2 Principles:** these become SPEC invariants.
- **§6 Decision rules:** each with inputs, precedence and missing-data behaviour.
- **§8 Doing it by hand:** the domain works with no app (L-11).
- **One home for each rule.** The plan says what a rule means and why. The SPEC holds the numbers and tests (L-04).

## Stage 2: The SPEC (software truth, agent-facing)

Template: `templates/SPEC.md`. It keeps what made Running-App's SPEC work and adds the fixes. Its section numbers differ from Running-App's: phases are §12 here (§11 there), tests §13 (§12 there), questions §14 (§13 there).
- **§0 "Before writing any app code":** an ordered gate list (read, real data, spike, panel, open questions). It tells the agent when to stop and report.
- **Constants table** with an *Editable?* column and a **locked** list, each with a test.
- **§3 Invariants:** numbered and testable. The auditor checks every one, every round (L-02).
- **§4 Definitions:** statistics, windows, units, time and the fail-safe policy (L-09, L-15).
- **§7 Rules:** a pure module, "now" injected, every output carries reasons, precedence as an ordered list ("first match wins"), and **state machines as tables** (L-06).
- **§12 Build phases**, each with a "Done when". Phase 0 and Phase R are phases too.
- **§13 Acceptance tests:**
  - ID | Input | Expected, with exact numbers;
  - IDs `T001` …, never renumbered, with tombstones for removed tests;
  - plus **§13.I invariant tests** `TI1a` … (L-08);
  - `scripts/coverage.py` maps IDs to tests.
- **Versioning.** Bump only the document that changed. Every bump gets a CHANGELOG entry: the trigger, then the IDs, then the sections touched.

## Stage 3: Data spike (before the panel; L-01)

Skip it only if the app reads no external data. Template: `templates/SPIKE-REPORT.md`.
1. Write a small script that pulls a long window of the owner's real data. Credentials come from the env or Keychain, never the command line. If the session can't reach the network, the owner runs the script and sends back the redacted report.
2. Print **every field**, with its fill rate and type. Mark the fields the rules depend on.
3. Do the same for any export file: columns, fill rate, format quirks, implausible rows. An implausible row becomes test data.
4. Commit a **redacted** report (counts and fill rates only). Raw output stays git-ignored (L-28).
5. Rewrite any rule whose inputs don't really arrive. Field missing ≠ bad.
6. Keep a **replay harness** for thresholds you can't settle yet. It runs the rule over real history and reports counts only.

## Stage 4: Expert review panel (Phase R)

Skill: `/playbook:panel`. Templates: `REVIEW-PANEL.md`, `review-output.md`, `SUMMARY.md`.

**Who sits on the panel** (the size sets how many):
- **Always:** the `logic-auditor` (SA: consistency, unsafe paths, invariants, test gaps; exhaustive; at stage R it only reads) and the `adherence-reviewer` (AD: friction, framing, real-life use).
- **When the app reads sensors or APIs:** the `data-reviewer` (DA).
- **When personal data is involved:** the `privacy-reviewer` (PV).
- **Domain experts** from a panel pack (`panels/<domain>/`), tailored with the owner's context. Each has a two-letter code.

**The run:**

| Step | What happens |
|---|---|
| R0 | Write the **invariants** and the **precedence order** for conflicts *before* the run. Freeze scope (L-07). |
| R1 | Same brief for everyone: the files, **the owner context and hard constraints**, the remit, the template, a 900-word cap (the auditor is exempt), and citations verified or tagged `[unverified]` (L-22). |
| R2 | Launch all reviewers **in parallel**. The panel is round 0: save each review to `reviews/R-<code>0.md`, with IDs `R-<code>0-nn`. |
| R3 | The **main session** (never a subagent) writes `SUMMARY.md`: verdict roll-call, real-world go/no-go, consensus, conflicts resolved by precedence, change tables (C/M/N IDs with ⚠ on any loosening), deduplicated questions, and **reviewer errors caught**. |
| R4 | The owner marks each ID **accept / reject / modify** (`/playbook:decide`). Nothing proceeds until every Critical and Major item has a decision. Rejected items stay recorded so they aren't raised again. |
| R5 | Apply only accepted IDs, using the fix-impact checklist (L-05). Bump versions, write the CHANGELOG, then go to stage 5. |
| R6 | Rechecks (round 1, `R-<code>1.md`): any expert whose numbers depended on unknown data or on deferred items re-runs. Do this **before** the audit loop if you can (L-07). |

**Guardrails:**
- Reviewers never edit files.
- Never weaken a safety rule without the owner's explicit, separate confirmation.
- Respect the owner's hard constraints.
- Keep evidence separate from opinion.
- No diagnosis: say "recommend getting X checked".

## Stage 5: The audit loop

Skill: `/playbook:audit`. Template: `templates/AUDIT.md`.

**Each round:**
- The `logic-auditor` reads the changed docs, or the frozen code.
- It starts with a verdict line: `Critical: n · Major: n · Minor: n · Nit: n` (L-24).
- It proves or refutes **every invariant**, recomputes the named tests, and lists missing tests as input → expected.

**Between rounds:**
- The main session fixes the issues and bumps versions.
- It uses the **fix-impact checklist** and greps for the old wording.

**Exit rule (L-03):**
- **0 Critical and 0 Major.**
- Minors go into **one** polish batch at the end, not into the loop. If the polish touches rules or tests, one narrow check of that diff follows.

**Scope:**
- Round 1 is the whole document.
- From round 2, the scope is the diff plus its dependents, the invariants and any new Critical or Major.
- Each brief carries a **do-not-re-raise list**: decided items, deferred items and pending defaults.

**Loop breakers:**
- If the same area yields a Major **two rounds running**, stop patching. Rewrite it as one canonical definition or table (L-06).
- At **round 5 or later** with Majors still coming, escalate the design question to the owner. For Light-sized projects, escalate at round 3.

**While waiting on the owner:**
- Apply the **most conservative** answer, mark it `pending-default` in `DECISIONS.md`, and keep going (L-10). Confirm the batch later.
- **A Critical or Major item can be built on a default, but its phase can't close until the owner confirms it.**

**Owner reversals.** If the owner later reverses a decision in an area the loop already closed, treat the change as a new diff. Apply it, then run one narrow round on it.

**When it exits:** write `phases/P1-HANDOFF.md` (or `PA-HANDOFF.md` for an adopted app) so the build can start cold.

## Stage 6: Build phases

Skills: `/playbook:phase-start` and `/playbook:phase-close`. Templates: `PHASE-HANDOFF.md`, `PHASE-PLAN.md`, `DEVICE-STEPS.md`, `NOTES-FOR-OWNER.md`, `PR-BODY.md`.

**Phase start:**
1. Read the handoff written by the previous session. It has fixed fields: branch, where things stand, read-first list, sources of truth with versions, goal, carried-forward rules by ID, existing APIs and stubs, open questions, toolchain, step order, model table and guardrails (L-14).
2. **Ask the scope and policy questions now**, before the step plan is fixed (L-29, L-15, L-16).
3. Write `phases/P<n>-PLAN.md` as numbered steps. Each step names its SPEC sections and test IDs. The hardest coupled logic gets its own step. The last step is always "end to end, then review", with one end-to-end test that encodes the phase's "Done when".

**Steps:**
- Commit after each step, and push if there's a remote. Title: `P<n> step k: <outcome>`. The body lists what landed and the test count.
- Split oversized steps. Label draft or unverifiable steps "(draft)".

**Phase close:**
1. **Freeze** the branch, or snapshot it (L-18).
2. Run **one round** of the `logic-auditor` (safety and invariants) and a code review on the phase diff, **in parallel**. Reviewers may run probe tests in a scratch copy (L-23).
3. Fix with root-cause fixes (L-30). Commits cite IDs. Each review gets a **regression test file**, mutation-checked (L-26).
4. **Narrowly re-audit the fix commits** (`P<n>-SA2`, `SA3`, …) until 0 Critical, 0 Major.
5. Get **CI green**. In the cloud, the cheap job runs per push and platform jobs run by hand or on the PR (L-17). On a local machine, run the full suite yourself.
6. **Try it on the device.** A short numbered script for the owner, with what to send back. A way to run it on the real device exists from Phase 2 (L-19).
7. Append a **Status** section to the phase plan. Add the phase's block to **`NOTES-FOR-OWNER.md`** (Flags to look at, and Interpretations taken). Add **one CHANGELOG entry**, and bump the SPEC if any rule changed (L-20).
8. Open the **PR** using `PR-BODY.md`. Merge it before the next phase, or state the merge order (L-25).
9. Write the **next handoff**, then a short retro.

**Phase A (adopted apps only):**
- Write the §13.I invariant tests for the existing code first.
- Then audit module by module (one auditor per module, in parallel), frozen at the current HEAD.
- IDs: round 1 is per module (`A-SA1-<mod>-nn`, in `reviews/A-SA1-<mod>.md`), then `A-SA2-nn` … from a single auditor; code review is `A-CR1-nn`. The plan is `phases/PA-PLAN.md`.
- Fix the Criticals and Majors as numbered steps. The next phase is P1.

**Architecture habit (L-13):** keep the logic pure and testable without the platform. The app-state layer is pure too: it decides what each screen shows and every write it makes. The UI holds no rules. There is one write path.

## Stage 7: Retro and feeding the playbook

Skill: `/playbook:retro`.
- **Phase retro** (5 minutes; skip on Light):
  - the numbers;
  - one question to the owner;
  - `retros/P<n>.md`.
  No playbook edits yet; just collect.
- **Project-end retro** (or whenever a lesson is urgent):
  1. Read every phase retro.
  2. Fill in `templates/RETRO.md` for the project.
  3. Add the project's block to `METRICS.md` in the playbook repo.
  4. Add new lessons to `LESSONS.md` (next free ID, Keep or Change).
  5. For each Change lesson, edit the playbook (template, skill or this file) on a branch. Bump the playbook version and CHANGELOG, and offer a PR.

---

## Conventions (all stages)

**Asking the owner.**
- Use AskUserQuestion when it's available: up to 4 questions a call, 2–4 options each, the recommended option first, marked "(Recommended)".
- Otherwise, ask in chat as lettered options with a recommendation, and wait.
- Each question stands alone; the owner may be on their phone.

**Decisions.**
- Every decision lives in **`DECISIONS.md`**, one row per decision: ID, date, source, question, options, answer, who decided, reversible?, and status (`pending-default` / `confirmed` / `changed` / `rejected`).
- Record the answer as soon as it arrives, in a `Notes:` commit.
- Plan-vs-SPEC conflicts are always raised as questions, never resolved silently.

**Notes for the owner.** `NOTES-FOR-OWNER.md` is a plain-English diary, one block per phase, that the owner actually reads. It has two kinds of entry:
- **Flag:** something the owner should look at.
- **Interpretation:** a reading taken inside the stated rules, always the conservative one.

Each entry gets the owner's answer and the date. `DECISIONS.md` is the formal log behind it.

**Severity** (define Critical for the domain in the project `CLAUDE.md`):
- **Critical:** could plausibly cause harm, or give unsafe or wrong advice; or a path that loosens a guardrail or acts without the owner's Confirm.
- **Major:** materially reduces correctness, effectiveness or adherence.
- **Minor:** polish or latent.
- **Nit:** cleanup.

**Finding IDs** (L-21): `<stage>-<code><round>-<nn>`.
- Stage: `R` = design docs (panel and audit loop), `A` = Phase A, `P1`…`Pn` = build phases. Spike findings are `S-nn`.
- Code:
  - core: `SA` logic auditor, `CR` code review, `AD` adherence, `DA` data, `PV` privacy;
  - domain experts use the two-letter code in their pack's README.
- Round: the panel is round 0, rechecks are round 1+, and the audit loop counts from 1.
- Examples: `R-PH0-04` (physio, panel), `R-SA3-02` (audit round 3), `P4-CR1-06`.

**Review files.** `reviews/<stage>-<code><round>.md`, e.g. `reviews/R-AD0.md`, `reviews/P2-SA1.md`.
- Header: the date, the agent, the exact scope (docs and versions, or a commit range), what the reviewer could not check, and the verdict line.
- When fixes land, add a Status block to the file itself.

**Commits.**
- `P<n> plan`.
- `P<n> step k: …` for build steps.
- `Fix <IDs>: …` for fixes.
- `Save <stage> review <file>` for review reports.
- `<Stage> audit closed: round <n> at 0 Critical, 0 Major`.
- `Notes: …` for decisions.
- `Design: PLAN v<a>, SPEC v<b>` for doc revisions.
- The body ends with the test count.
- No model names in commits or code.

**Git.**
- Commit after every step.
- Push if there's a remote and the owner agrees.
- With no remote: commit locally, skip the PR, and write the PR body to `phases/P<n>-PR.md` instead.
- Not a git repo yet? `git init` first, with the owner's OK.

**Privacy.**
- Never commit real personal data.
- Spikes report counts and fill rates only.
- Fixtures are hand-written.
- Ask the owner for "errors and test names, verbatim", not screenshots of personal data.

**Writing style.** Plain English, short sentences and concrete numbers. Lead with the answer ("Yes, you can start Monday by hand"). One convention per idea: ⚠ = loosens a rule; (Owner, date) = owner's decision.

**Models (L-27).**
- The main session runs on the strongest model. It handles coupled logic, synthesis and code review.
- Reviewers and auditors are Sonnet and don't edit the repo (auditors may probe in a scratch copy at build stages).
- Never split tightly coupled logic across parallel agents.
- Each handoff carries a model table: step, main, subagents, why.

---

## Project layout

```
<app>/
  CLAUDE.md              project instructions + Playbook map (stage, size, environment, files, guardrails, Critical defined)
  PLAN.md                domain truth (human)
  SPEC.md                software truth (agent)
  DECISIONS.md           every decision, default, interpretation and carried-forward rule (formal log)
  NOTES-FOR-OWNER.md     plain-English diary per phase: Flags and Interpretations
  CHANGELOG.md           one entry per version bump / phase close
  REVIEW-PANEL.md        this project's panel: roles, codes, context, precedence, brief
  AS-IS.md               (adopted projects only) what existed before the playbook
  TESTS.md               SPEC test ID → test coverage matrix (generated by coverage.py)
  spikes/                data spike scripts + redacted reports
  reviews/               every review and audit, plus SUMMARY.md
  phases/                P<n>-HANDOFF.md, P<n>-PLAN.md, device steps
  retros/                retros
  .claude/agents/        this project's tailored panel (copied from a panel pack)
```

The project `CLAUDE.md` has a **Playbook map** table. It maps each role (plan, SPEC, decisions…) to the actual file path, so adopted projects can keep their own names.
