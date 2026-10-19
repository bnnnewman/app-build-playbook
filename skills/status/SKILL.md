---
name: status
description: Report where a playbook project stands - current stage, size, gates met or open, pending decisions, open findings, and the single next action. Use when the user asks "where are we", "what's next", or at the start of any session on a playbook project.
---
# Where are we?

*`${CLAUDE_PLUGIN_ROOT}` is the playbook folder. If you see it literally, find the folder by searching for `PLAYBOOK.md` under `~/.claude/plugins/` or `.claude/playbook/`.*

1. Read the project `CLAUDE.md` Playbook map. If there isn't one, say so and suggest `/playbook:start`.
2. Check each stage gate against `${CLAUDE_PLUGIN_ROOT}/PLAYBOOK.md` ("The stages at a glance"). Use the files themselves, not memory:
   - **PLAN and SPEC:** versions, open "Still open" items, and whether SPEC §3 invariants exist.
   - **Spike:** a field report exists in `spikes/`, or the spike is marked not applicable.
   - **Panel:** the `reviews/R-*0.md` files exist, plus `reviews/SUMMARY.md`, and every C/M ID has a decision.
   - **Audit loop:** for the current stage, the file with the **highest round number** (`reviews/<stage>-SA<n>.md`, compared as numbers). Read its verdict line. Is it 0 Critical / 0 Major?
   - **Build:** the latest phase plan's Status section, unfinished steps, the git branch, uncommitted or unpushed work, and open PRs if you can see them.
   - **`DECISIONS.md`:** count the `pending-default` rows. List any ⚠ rows awaiting a yes, and any Critical/Major defaults that block a phase close.
   - **Notes and retros:** flags in `NOTES-FOR-OWNER.md` with no answer, and a missing retro for the last closed phase (unless the size is Light).
3. Report in this shape, under 15 lines:
   - **Stage:** <n, name> · **Size:** <…> — <one line>.
   - **Done:** <the gates met>.
   - **Open:** <bullets: pending decisions, open findings by ID, unmet gates, flags awaiting the owner>.
   - **Next:** <one action, with the exact command>.
4. If the Playbook map's Stage row is out of date, offer to fix it.
