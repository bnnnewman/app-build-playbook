---
name: close
description: Close a build - freeze, run the review lanes it needs in parallel (safety, code, design lock, logic, privacy, security, automation), fix and re-check each lane to 0 Critical and 0 Major, get the wording approved, write the device steps and a plain-words PR, then wait for the owner's "merge N". Ends by recording the owner's answer to the one question, and a handoff. Use when a build's steps are done.
argument-hint: "<build id>"
---
# Close a build

*`${CLAUDE_PLUGIN_ROOT}` is the playbook folder. If you see it literally, find the folder by searching for `PLAYBOOK.md` under `~/.claude/plugins/`, `/opt/app-build-playbook` or `.claude/playbook/`.*

**Helpers:** pick each one's model, and record its cost, by `/playbook:coordinate` → "Who does this job". Fable needs the owner's yes first.

## 1. Freeze

Commit and push (no remote, or push refused: commit locally, say "not pushed", carry on). Record `<base>..<head>`. No commits land while reviewers read. Gates first: the checks that run
here pass with **0 failures** (read the result, don't grep for a count); the type-check or compile stand-in passes;
`coverage.py` shows 0 missing (Standard and Full).

**Mini:** one review pass only (the code lane), the checklist in `BRIEF.md` section 8, findings into section 10.
Wait for his "merge" or "publish", then publish by section 9, add a row to `STATUS.md` → Published, and run the
one retro (`/playbook:retro release`). Skip sections 2 to 5.

## 2. Pick the lanes (from the brief's tier)

| Lane | Code | Runs when the build… | Who |
|---|---|---|---|
| Safety | SA | touches rules, stored data or the Critical list | `/playbook:audit <build> one-round` |
| Code | CR | always | the `code-review` skill if present; otherwise a general-purpose subagent told to find bugs and prove each with a probe in a scratch copy |
| Design lock | DL | changes anything visible (copy, layout, symbols) | `playbook:design-reviewer`, against the lock and the approved mock-up |
| Logic | LR | changes what the app plans, counts, caps or decides | `/playbook:logic-review concept` or `clash` |
| Privacy | PV | adds storage, network, logs or anything about people | `playbook:privacy-reviewer` |
| Security | SE | changes sign-in, who can see what, stored keys, or a connection to another system | `playbook:security-reviewer` |
| Automation | AU | changes anything a routine runs | `playbook:automation-reviewer` |

New screen → also `/playbook:critique screen`. Words-only or looks-only builds skip SA (see `/playbook:audit` tiers).
Launch the lanes **in one message**, each on the frozen commit with its own scratch folder (L-105):
- **Each lane is a separate reviewer.** The builder's own check is not a lane.
- **Give each reviewer the code to read:** a separate copy checked out at the frozen commit, or a diff file in its
  scratch folder. A reviewer with no shell can't fetch it.
- **Reviewers never touch the build's checkout:** no checkout, switch or reset there. Read only.

Save each to `work/<build>/reviews/<LANE>1.md`.

## 3. Fix and re-check

- Fix every Critical and Major: the cause, for every case it covers. One regression test per finding, checked to
  fail without the fix.
- **Each fix is re-checked by the lane that found it** (`<LANE>2`, narrow), until every lane is at 0/0. The audit
  skill's loop breakers apply to every lane.
- Minors: fix the cheap ones; the rest to `NOTES.md` "Left as is" with a reason.

## 4. Words and device

- **Wording page** (`/playbook:mock wording <build>`, from `${CLAUDE_PLUGIN_ROOT}/templates/WORDING-PAGE.md`): he
  replies "words fine" or names lines.
- **Device steps** into `docs/owner/ACCEPTANCE.md` under this build: *where → what to tap → what you should see*,
  with a time budget, a "use a test item" line where real data could be touched, and the test IDs each step covers.
  Ask for a **screenshot pass** of anything visible: light, dark, largest text.
- A build that sends data to an outside service does not merge with its device step unticked.

## 5. The PR, in plain words

From `${CLAUDE_PLUGIN_ROOT}/templates/PR-BODY.md`: what you'll see; what each lane found and fixed; what was tested
here and what was **not run**; what needs the device; anything "for the owner" from `NOTES.md`. If there's no
remote, write it to `work/<build>/PR.md`. A `pending` on a Critical or Major blocks the merge: ask now.

## 6. "Merge N"

Wait for it. Then merge, and say: **On main: … · On a branch: … · On your phone: …** and when it will arrive. For an
app, one merge is one build on his phone: bundle docs-only changes with the next real one.

## 7. After the merge

- `CHANGELOG.md`: one entry (what changed, the decisions, bug fixes). Bump the SPEC if a rule changed.
- Move `work/<build>/` to `work/archive/`. Delete the merged branch. Update `STATUS.md`.
- **Record his answer** to the one question in the PR summary ("anything slow, confusing or great?") in
  `retros/answers.md`, or "not answered".
- **Retro:** Full: now, `/playbook:retro <build>`. Standard and Light: at the next `/playbook:release`. Mini: once, at
  the end.
- `work/<next>/HANDOFF.md` if the next build is known.
