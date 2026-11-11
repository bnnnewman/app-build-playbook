---
name: panel
description: Run an expert review panel - choose reviewers from the core agents and a domain pack, tailor them with one shared owner-context block, brief them identically, run them in parallel on a frozen commit, verify, synthesise in the main session, and put the result to the owner by ID. Use at stage 5 on the plan and spec, on design mock-ups, or whenever the owner asks for experts to review something.
argument-hint: "[pack name | design] [scope]"
---
# Expert review panel

*`${CLAUDE_PLUGIN_ROOT}` is the playbook folder. If you see it literally, find the folder by searching for `PLAYBOOK.md` under `~/.claude/plugins/`, `/opt/app-build-playbook` or `.claude/playbook/`.*

**Helpers:** pick each one's model, and record its cost, by `/playbook:coordinate` → "Who does this job". Fable needs the owner's yes first.

**Reviewers advise. The owner decides. No reviewer edits a file.** Files go in `work/<build>/reviews/` (`work/R/` for
the plan-and-spec panel).

## 1. Set up

1. **Gates:** what is being reviewed is written and grilled; the spike is done or not needed; SPEC invariants exist.
2. **Choose the panel** by size (Light about 3; Standard 5–6; Full 6–8).
   - Core (shipped with the playbook): `logic-auditor` and `adherence-reviewer` always; `data-reviewer` for sensors or
     outside data; `privacy-reviewer` for data about people; `security-reviewer` when anyone signs in or it
     connects to another system; `automation-reviewer` for routines;
     `design-reviewer` for anything visible.
   - Domain: `${CLAUDE_PLUGIN_ROOT}/panels/<pack>/`. No pack fits? Design one with `panels/README.md`.
   - **Tell the owner which reviewers will run, one line each, and wait for "start".**
3. **One owner-context block**, written once in `work/<build>/REVIEW-PANEL.md` (from
   `${CLAUDE_PLUGIN_ROOT}/templates/REVIEW-PANEL.md`) and pasted into every brief: who it's for, the real numbers,
   hard constraints, what it is not, and "Unknown: ask if it matters (max 3 questions)". Add those unknowns to the
   owner's next grill so six reviewers don't each ask.
4. **Tailor the domain agents** into `.claude/agents/`: fill the placeholders; point the focus questions at real
   section numbers and real values. If new agents don't load, brief a general-purpose subagent with the file's text.
5. **Precedence** for conflicts, written before the run: the harm owner first.
6. **Freeze:** commit; reviewers read that commit only.

## 2. Brief and run

Same brief for all, plus:
- **"Read `OWNER.md`, `DECISIONS.md` and `AS-IS.md` first, and say that you did.** Cite the decision or profile line
  for any point they touch. A finding that disagrees with one says 'Reopens D-…' with new evidence."
- The template: `${CLAUDE_PLUGIN_ROOT}/templates/review-output.md`; the auditor uses `templates/AUDIT.md`.
- The ID prefix `<build>-<code>0-` (the panel is round 0). 900 words, except the auditor.
- "Verify each citation, or tag it [unverified]." "Mark anything that loosens a rule ⚠."

Launch every reviewer **in one message**. Save each output verbatim to `work/<build>/reviews/<code>0.md`.

**Verifier** (Full, or any panel over 6): follow each reviewer with a `playbook:finding-verifier` told to refute its
findings against the files. Keep confirmed and corrected; drop refuted.

## 3. Synthesise (main session, never a subagent)

`work/<build>/reviews/SUMMARY.md` from `${CLAUDE_PLUGIN_ROOT}/templates/SUMMARY.md`: the real-world answer first
("can he start using it by hand on Monday?"); what two or more raised; conflicts settled by precedence; changes as
C01… M01… N01… with ⚠ on loosenings; questions for the owner, deduplicated; **reviewer errors caught**; points that
clash with an earlier decision, marked.

## 4. The owner decides, then apply

- `/playbook:decide`: every Critical and Major gets accept / reject / change. ⚠ alone. Rejected items are marked *do
  not raise again*.
- Apply only what was accepted (`/playbook:spec revise panel`).
- **Recheck** a reviewer whose facts changed because of the owner's answers (round 1, `<code>1.md`).
- Then `/playbook:audit <build>`.

**Design panels** (`panel design`) review the **mock-up**, and their findings become mock edits, not code.
