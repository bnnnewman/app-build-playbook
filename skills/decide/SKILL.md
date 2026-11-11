---
name: decide
description: Gather everything waiting on the owner (review proposals, pending defaults, flags, PRs waiting for "merge", device steps not reported) and put it to him in grill rounds; record every answer and close what it settles. Use after a panel or review summary, at audit exit, before a build brief is fixed, or when status shows things waiting.
---
# Owner decisions

*`${CLAUDE_PLUGIN_ROOT}` is the playbook folder. If you see it literally, find the folder by searching for `PLAYBOOK.md` under `~/.claude/plugins/`, `/opt/app-build-playbook` or `.claude/playbook/`.*

1. **Gather.** `python3 ${CLAUDE_PLUGIN_ROOT}/scripts/decisions.py DECISIONS.md` lists `pending` rows by age. Add:
   review-summary IDs with no decision; ⚠ items; open questions in the newest handoff; PRs waiting for "merge N";
   device steps with no result.
2. **Cut the list first.**
   - Answered by `${CLAUDE_PLUGIN_ROOT}/OWNER.md` → close as "by profile".
   - A `pending` older than 7 days that nobody would reverse → propose closing it as confirmed, in one line.
   - Domain content the reviewers agree on → apply, report.
3. **Order:** Critical, then ⚠ (each alone), then Major, then the rest. Things that block the next step come first.
4. **Ask in grill rounds** (`/playbook:grill` format and rules).
   - Review proposals: accept / reject / change. Minors: "accept all Minors except…".
   - Rank anything with a cost using the **"if we skip it" columns**: why; when it bites; does it fail safe; cost in
     usage windows.
   - Anything visible comes with a mock-up link (`/playbook:mock`).
5. **Read back, then record** every answer in `DECISIONS.md` with his words.
   - When an answer settles an older row, **update that row too** (status `replaced`, "settled by D-…").
   - A rejected proposal keeps its row, marked *do not raise again*.
6. **Commit** `Notes: <summary>`, separate from code.
7. If an answer changes a rule: `/playbook:plan revise` or `/playbook:spec revise`, then the checks its size needs
   (`${CLAUDE_PLUGIN_ROOT}/GLOSSARY.md`, "Sizes of change").
8. Tell the owner what changed in three lines, then hand back to the skill that called you.
