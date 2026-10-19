---
name: panel
description: Run the playbook expert review panel (Phase R) - choose and tailor reviewers from the core agents and a domain panel pack, brief them identically with the owner's context, run them in parallel, synthesise SUMMARY.md in the main session, get the owner's accept/reject/modify per ID, and apply only accepted changes. Use at stage 4.
argument-hint: "[pack name, e.g. plant-care]"
---
# Expert review panel (Phase R)

*`${CLAUDE_PLUGIN_ROOT}` is the playbook folder. If you see it literally, find the folder by searching for `PLAYBOOK.md` under `~/.claude/plugins/` or `.claude/playbook/`.*

Read `${CLAUDE_PLUGIN_ROOT}/PLAYBOOK.md` stage 4 and "Finding IDs", `${CLAUDE_PLUGIN_ROOT}/panels/README.md`, and lessons L-02, L-03, L-07, L-12 and L-22.

**The reviewers advise. The owner decides. No reviewer edits any file.**

## R0. Before the run

1. **Check the gates.**
   - PLAN and SPEC exist.
   - SPEC §3 invariants are written. If not, write them first (`/playbook:design revise invariants`).
   - The spike is done or marked not applicable.
2. **Choose the panel.** Its size comes from the Playbook map: Light is about 3, Standard 5–6, Full 6–8. These are targets. If a Light project also needs the data or privacy reviewer, let the owner choose between going to 4 and dropping the domain expert.
   - **Core**, shipped with the playbook:
     - `logic-auditor` (SA) and `adherence-reviewer` (AD), always;
     - `data-reviewer` (DA), if the app reads sensors or APIs;
     - `privacy-reviewer` (PV), if personal data is involved.
   - **Domain**, from `${CLAUDE_PLUGIN_ROOT}/panels/<pack>/`. The pack is `$ARGUMENTS`, or ask. Each has a two-letter code in the pack README.
   - If no pack fits, design one using `panels/README.md` and `_TEMPLATE.md`.
   - If the pack is marked **Draft**, tell the owner it is untested and will be improved after this run.
   - Show the owner the proposed panel, one line per role, and get a yes.
3. **Tailor the domain agents.**
   - Copy each one into the project's `.claude/agents/`.
   - Fill every `<<…>>` placeholder from PLAN §1, `AS-IS.md` and the owner's answers: real numbers, history and constraints. Point the focus questions at the actual PLAN section numbers.
   - Check that no `<<` is left.
   - New agent files are picked up at the next session start. If they don't show up, ask the owner to run `/agents` or restart, or brief a general-purpose subagent with the agent file's text instead.
4. **Write `REVIEW-PANEL.md`** from the template, with the codes, the owner context, the hard constraints and the **precedence order** for conflicts (the harm owner first).
5. **Freeze scope.** No PLAN or SPEC edits until R5.

## R1–R2. Brief and run in parallel

1. **Brief.** Use the R1 text in `REVIEW-PANEL.md`. **Paste the owner context and hard constraints into the brief itself**, because the core agents have no Context block of their own. Give:
   - the template path: `${CLAUDE_PLUGIN_ROOT}/templates/review-output.md`;
   - the ID prefix `R-<code>0-`. The panel is round 0.
2. **The `logic-auditor`** gets `${CLAUDE_PLUGIN_ROOT}/templates/AUDIT.md`, the prefix `R-SA0-`, no word cap, and "no Bash at this stage".
3. **Launch all reviewers at once, in one message** (several Agent calls).
   - Plugin agents are `playbook:logic-auditor`, `playbook:adherence-reviewer`, and so on. If the playbook was copied into the project instead of installed, use the plain names (`logic-auditor`).
   - Project agents use their plain name.
4. **Save** each output verbatim to `reviews/R-<code>0.md`.

## R3. Synthesise (main session only, never a subagent)

Write `reviews/SUMMARY.md` from `${CLAUDE_PLUGIN_ROOT}/templates/SUMMARY.md`:
1. A verdict roll-call. Then the **real-world go/no-go** first ("Can the owner start by hand on Monday?").
2. Consensus: points raised by 2 or more reviewers, with attribution.
3. Conflicts, resolved by the declared precedence.
4. Change tables C01… / M01… / N01…, ordered by severity, with an evidence-vs-opinion column and **⚠ on anything that loosens a rule**.
5. Questions, deduplicated and split into "Decisions" and "About you".
6. **Reviewer errors caught.** Verify their arithmetic, dates, claimed contradictions and citations against the docs and data.

Commit: `Save R review panel and SUMMARY`.

## R4. The owner decides

Run `/playbook:decide`:
- Every C and M ID gets accept / reject / modify. Batch the Minors ("Accept all Minors except…?").
- ⚠ items get their own explicit question.
- Rejected items stay recorded.

Add the decisions section to SUMMARY, and log each decision in `DECISIONS.md`. **Don't proceed until every Critical and Major item is decided.** If the owner is away, pending defaults may carry the docs forward, but the stage doesn't close.

## R5. Apply

- Apply only the accepted IDs, with the fix-impact checklist (`/playbook:design revise panel`).
- Bump the versions. Write the CHANGELOG entry ("Every ID below was accepted by <owner>…").
- Commit.

## R6. Rechecks (before the audit loop where possible)

- **When:** an expert's numbers depended on unknown data, or items were deferred to "<expert> to confirm".
- **How:** re-run that expert with the new input, as round 1 (`reviews/R-<code>1.md`, IDs `R-<code>1-nn`). Each recheck's changes go through R4–R5.

Then start the audit loop: `/playbook:audit R`. It continues the SA numbering at round 1.

## Done when

- [ ] Every review and SUMMARY is saved.
- [ ] Every Critical and Major item is decided.
- [ ] Accepted changes are applied, with versions and CHANGELOG.
- [ ] Rechecks are done.
- [ ] The audit loop is closed at 0/0.
