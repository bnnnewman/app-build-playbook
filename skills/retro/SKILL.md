---
name: retro
description: Run a five-minute retro at a release (or each merge, on Full projects) or a project's end - numbers filled by a script, one question to the owner, at most three lessons - and carry proposals back to the playbook repo so the process actually improves. Use at each release, after every merge on Full projects, and when the owner asks to improve the playbook.
argument-hint: "[<build> | release | project | sync]"
---
# Retro

*`${CLAUDE_PLUGIN_ROOT}` is the playbook folder. If you see it literally, find the folder by searching for `PLAYBOOK.md` under `~/.claude/plugins/`, `/opt/app-build-playbook` or `.claude/playbook/`.*

For three weeks, four projects proposed 16 lessons and none reached the playbook. So the retro is small, it always
runs, and it always writes somewhere the playbook can collect.

## `<build>` or `release` (five minutes)

1. **Numbers, from files:** `python3 ${CLAUDE_PLUGIN_ROOT}/scripts/metrics.py .` prints, per build and lane, the
   rounds and first-round counts from the review files' verdict lines. Add: commits; tests at close (a count a
   command produced); findings caused by our own fixes (search the reviews for "introduced"); things the owner found
   on the device that the lanes missed; **usage windows** spent, roughly.
2. **The owner's answers.** The one question (*"Anything this time that felt slow, confusing or great?"*) rides in
   every PR summary, so it isn't a separate step that gets skipped. Read his answers from `retros/answers.md`; ask
   once now if there are none.
3. **At most three lessons.** Check `${CLAUDE_PLUGIN_ROOT}/LESSONS.md` first.
   - An existing lesson repeated → say which. Its fix isn't working well enough.
   - Something new → `<project>-L<n>` (for example `FL-L3`). **Never an `L-nn` number: only the playbook repo
     assigns those.**
4. Write `retros/<build>.md` (from `${CLAUDE_PLUGIN_ROOT}/templates/RETRO.md`) and **append** each lesson and
   proposed edit to `retros/playbook-proposals.md`: the lesson, the evidence, the file to change, the words.
5. If a rule for *this project* follows (as tiered audits once did), make it now: one line in the project
   `CLAUDE.md`, with the decision ID.

**When:** Full: every merge. Standard and Light: each release. Mini: once, at the end.

## `project`

Read every `retros/*.md`. Write `retros/PROJECT.md`: numbers per stage against the targets in the playbook's
`METRICS.md`; what worked; what cost too much; up to three questions to the owner. Then `sync`.

## `sync` (carry proposals to the playbook)

The playbook repo is `bnnnewman/app-build-playbook`. If it isn't in this session, attach it (read is enough to
check; pushing a branch needs push access), or tell the owner the proposals are waiting in
`retros/playbook-proposals.md`.

On a branch of the playbook repo:
- `LESSONS.md`: give each proposal the next free `L-nn`, with its project code and evidence.
- `METRICS.md`: the project's rows.
- The template, skill, agent or pack each lesson changes. Promote tailored reviewers back into their pack, with the
  placeholders restored.
- Bump the version (`.claude-plugin/plugin.json`, the `PLAYBOOK.md` header), add a `CHANGELOG.md` entry, run
  `claude plugin validate . --strict`.
- Push the branch. The owner merges playbook changes like any other.
- Mark the synced lines in `retros/playbook-proposals.md` with the L-number they became.
