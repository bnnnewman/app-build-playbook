---
name: status
description: Say where a project stands and the one next action, in plain words, and write it to STATUS.md - what is on main, on a branch and on the owner's phone; what is waiting on the owner; open findings; housekeeping. Also re-checks the grow trigger. Use when the owner asks "where are we", "what's next", "is that done", or at the start of any session on a playbook project.
---
# Where are we?

*`${CLAUDE_PLUGIN_ROOT}` is the playbook folder. If you see it literally, find the folder by searching for `PLAYBOOK.md` under `~/.claude/plugins/`, `/opt/app-build-playbook` or `.claude/playbook/`.*

Work from the files and git, not memory.

## 1. Gather

- **Set-up:** the project `CLAUDE.md` (size, type, mode, Playbook map). None? Say so and suggest `/playbook:start`.
- **Git:** `git fetch` (no remote: skip it and say so); what is on main; branches with unmerged work (and how old); branches fully merged; open PRs
  if you can see them; uncommitted work.
- **What the owner can use now:** the last release tag or publish-log line; for an app, the last merge to main.
- **Waiting on the owner:** run `python3 ${CLAUDE_PLUGIN_ROOT}/scripts/decisions.py DECISIONS.md` for `pending`
  rows and their age. Add: PRs waiting for "merge N", device steps not yet reported, ⚠ questions, unanswered
  questions in the newest handoff.
- **Open findings:** the newest review file per lane in the current `work/<build>/reviews/`; read each verdict line.
- **Stage gates:** check against `${CLAUDE_PLUGIN_ROOT}/PLAYBOOK.md` "The map".
- **Grow trigger:** has a harm answer changed? A second system, a second builder, or a date set by someone else?
- **Housekeeping:** `STATUS.md` or `CLAUDE.md` out of date; `DECISIONS.md` rows replaced but not marked; a vendored
  playbook older than the installed one; root files that don't belong (PLAYBOOK "Project layout").

## 2. Write `STATUS.md`

Use `${CLAUDE_PLUGIN_ROOT}/templates/STATUS.md`. **Rewrite everything except `## Published`. Keep
`## Published` exactly as it is** (the only record of what is live; add rows, never drop them). Keep the part you rewrite under 40 lines, so it reads on a phone:

```
**Where we are:** <stage, in plain words> · **Size:** <…> · updated <date>
**On main:** <what is merged>
**On a branch:** <what is waiting, with PR numbers>
**On your phone / live:** <version and date>

## Waiting on you (oldest first)
1. <plain words> (<age>)

## Next
<one action, with who does it>

## Running now
- <build>: <one line> (branch)

## Housekeeping
- Merged, safe to delete: <branches>
- Has unmerged work: <branches, age>   (older than 2 days: say so)

## Published          (kept; the one publish log)
```

Also flag: a `CLAUDE.md` status line that disagrees with the newest branch; `pending` items over 7 days.

**Mini:** there is no `DECISIONS.md`; read `BRIEF.md` sections 6 and 7 instead, and its grow check.

## 3. Tell the owner

Under 12 lines, same shape, no IDs unless he needs one to answer. If the project has outgrown its size, say so first, in plain words ("this now
handles other people's data; I suggest moving from Light to Standard"). Commit `STATUS.md` with the work it describes, not as a commit of its own on main.
