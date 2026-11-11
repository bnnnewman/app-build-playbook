---
name: spike
description: Look at what is really there before designing around it - a data spike (field coverage and fill rates, never values), a mini spike (copy the real field names), a platform spike (what a routine or hosted page is allowed to do), or a replay of a rule over the owner's own history (counts only). Use at stage 3, when a new data source or platform appears, or before any rule change the owner can't judge in the abstract.
argument-hint: "[data <source> | mini <source> | platform <name> | replay <rule>]"
---
# Spike

*`${CLAUDE_PLUGIN_ROOT}` is the playbook folder. If you see it literally, find the folder by searching for `PLAYBOOK.md` under `~/.claude/plugins/`, `/opt/app-build-playbook` or `.claude/playbook/`.*

Rules built on things that aren't there waste whole audit loops. One spike per source. Findings are `S-nn`. Report
to `spikes/<source>-report.md` from `${CLAUDE_PLUGIN_ROOT}/templates/SPIKE-REPORT.md`.

**Always:** credentials come from the environment or a secure form, never typed in chat or on a command line. Raw
output goes to an absolute scratch path outside the repo. The report holds counts and fill rates only. Run
`git status` before any commit.

## `mini <source>` (every size, 15 minutes)

Copy the real field names, the allowed values and their exact spelling from the source into the SPEC or `BRIEF.md`.
Note the time zone the source uses, blank and duplicate rows, and values the pretend data doesn't have. Never type
them from memory.

## `data <source>`

1. List the fields the rules depend on, from SPEC §5 and §7.
2. Pull a long window (a year if there is one). For every field: type, how often it is filled. Mark the ones the
   rules need.
3. For an export file: every column, format quirks, implausible rows (these become test data).
4. Say plainly which needed fields never arrive and what that means for the rules. A missing field is "missing",
   never "bad".
5. Feed it back with `/playbook:spec revise spike`. Mark each change Tightens / Loosens ⚠ / Neutral.
6. If the panel already ran, re-run the data reviewer with the report.

## `platform <name>`

For a routine, a hosted page or any service the design leans on. On a throwaway copy, test: what a session may read
and write; which settings only the owner can change on screen; what happens to connectors and permissions; limits
and costs. List "only the owner can do this" steps with the exact screens.

## `replay <rule>`

Before a rule changes, run the old and new rule over the owner's real history. Report counts only ("would have fired
in 11 of 51 weeks, 3 fewer than today"). Keep nothing. Show the counts with the question, which is asked alone if
it loosens anything.

If this session can't reach the source, give the owner the script and the one command to run, and ask for the
printed counts back.
