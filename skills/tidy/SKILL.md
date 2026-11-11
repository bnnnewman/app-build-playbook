---
name: tidy
description: Housekeeping for a project that has grown messy - move it onto the playbook's layout, shrink an oversized decision log into an index plus detail, archive closed work, delete merged branches, refresh stale docs and stale test coverage. Proposes first; changes nothing until the owner agrees. Use when status flags housekeeping, when a project predates playbook v2, or when the owner says "tidy up the repo".
argument-hint: "[check | layout | decisions | branches | docs]"
---
# Tidy

*`${CLAUDE_PLUGIN_ROOT}` is the playbook folder. If you see it literally, find the folder by searching for `PLAYBOOK.md` under `~/.claude/plugins/`, `/opt/app-build-playbook` or `.claude/playbook/`.*

**Propose, wait for yes, then do it**, on a branch, in one PR with no behaviour change. Never during an open build.

## `check` (default)

Report, in plain words, with counts:
- **Root files** that don't belong (PLAYBOOK "Project layout"): dead handoffs and plans, stray reviews.
- **Decision log:** size; rows out of order; `pending` rows a later row settled; duplicate IDs (run
  `python3 ${CLAUDE_PLUGIN_ROOT}/scripts/decisions.py DECISIONS.md --branches`); a second record still claiming to be
  current.
- **Reviews:** files with no verdict line; a flat folder with hundreds of files.
- **Branches:** merged and safe to delete; with unmerged work, and how old.
- **Stale docs:** a `CLAUDE.md` status section over 15 lines; a README over about 150 lines doing the job of a
  working file; "current state" headers with old dates; a coverage file older than the newest tests.
- **Privacy:** personal names in docs (should be roles); real data or screenshots in the repo; no `.gitignore`.
- **Playbook:** a vendored copy older than the current version.
Then recommend which of the steps below are worth doing, with sizes.

## `layout`

Move files to the layout, with `git mv` so history follows: owner docs to `docs/owner/`; closed handoffs, plans and
their reviews to `work/archive/<build>/`; live build material to `work/<build>/`. Update every path the project
`CLAUDE.md`, README and skills cite. Add the Playbook map. Leave code where it is.

## `decisions`

1. Keep every ID. Never renumber.
2. Make `DECISIONS.md` the **index**: one line per owner decision, in ID order: ID, date, the question in plain
   words, his answer, status, replaces / settled by.
3. Move the long cells (options, build notes, interpretations, "left as is") to `work/archive/decisions/<range>.md`,
   linked from the index. Bug-fix rows move to `CHANGELOG.md`.
4. For each `pending` a later row settled, update **both** rows.
5. Add a ranges table at the top if the project numbers `D-nnn` by session.
6. Retire any second record: one line at its top pointing to `DECISIONS.md`.

## `branches`

List merged branches; delete them on his yes. For branches with unmerged work: say what's on each and how old, and
ask merge / keep / drop.

## `docs`

Cut the `CLAUDE.md` status to the last 15 lines (history to `CHANGELOG.md`). Split a long README (people-facing part
stays). Replace names with roles. Re-run `coverage.py` so the coverage file is true. Archive old acceptance results
per version.
