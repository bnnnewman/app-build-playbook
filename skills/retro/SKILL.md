---
name: retro
description: Run a playbook retrospective. Phase retros are short (numbers + one owner question). The project-end retro collects all phase retros, proposes new LESSONS and concrete playbook edits, and feeds them back to the playbook repo. Use after a phase close, at project end, or when the user asks to improve the playbook.
argument-hint: "[R | A | P<n> | project]"
---
# Retro and playbook feedback

*`${CLAUDE_PLUGIN_ROOT}` is the playbook folder. If you see it literally, find the folder by searching for `PLAYBOOK.md` under `~/.claude/plugins/` or `.claude/playbook/`.*

The playbook gets better only through this step. Keep phase retros to about 5 minutes. Make the project-end retro thorough.

**The playbook version used:**
- `${CLAUDE_PLUGIN_ROOT}/.claude-plugin/plugin.json` if the playbook is installed as a plugin;
- `.claude/playbook/VERSION` if it was copied into the project;
- otherwise the `PLAYBOOK.md` header.

## Phase retro (`R`, `A`, `P<n>`)

1. **Collect the numbers from files, not memory:**
   - **Git:** commits, and elapsed time from first to last commit for the stage (`git log --format='%h %ad %s' --date=iso`).
   - **Review files:** rounds to 0/0. Findings per round by severity, from each verdict line. How many findings were introduced by your own fixes (search for "introduced").
   - **Tests:** the count at close, and the change.
   - **CI:** runs and approximate billed minutes.
   - **`DECISIONS.md`:** decisions this stage, and how many were confirmed defaults.
   - **Scope added mid-stage:** steps not in the original plan.
2. **Ask the owner one question:** "Anything that felt slow, confusing or great this phase?"
3. **Write `retros/<stage>.md`** from `${CLAUDE_PLUGIN_ROOT}/templates/RETRO.md`. Fill in the numbers, the owner's answer, and any candidate lessons (one line each).
4. That's all. Don't edit the playbook yet, unless a lesson is urgent (the same costly problem twice in a row). Then do the project-end steps 3–4 for that lesson alone.

## Project-end retro (`project`)

1. **Read every `retros/*.md`,** and add up the numbers into one table per stage.
2. **Write `retros/PROJECT.md`:** what worked, what cost too much, surprises, and the owner's view. Ask the owner up to 3 questions.
3. **Lessons.** Compare with `${CLAUDE_PLUGIN_ROOT}/LESSONS.md`.
   - **Did an existing lesson repeat?** The playbook's fix for it didn't work well enough. Strengthen it.
   - **Anything new?** Write it as a lesson: next free ID, Keep or Change, the evidence, and the playbook edit it implies.
4. **Feed it back.** The playbook repo is `github.com/bnnnewman/app-build-playbook`.
   - **If it's reachable here** (attached to this cloud session, or cloned locally), make the edits on a branch:
     - `LESSONS.md`: the new lessons;
     - `METRICS.md`: the project's block, one row per stage, plus whether the "targets for the next project" were met;
     - templates, skills, agents and panel packs: the Change edits;
     - panel packs: promote the tailored agents (placeholders restored), and mark the pack "used in anger";
     - `.claude-plugin/plugin.json` version (patch for wording, minor for a process change, major for a restructure), plus the `PLAYBOOK.md` header and `CHANGELOG.md`;
     - run `claude plugin validate . --strict` if the CLI is available.
     Then push the branch and offer to open a PR.
   - **If it's not reachable,** write the proposed edits to `retros/playbook-proposals.md`, and tell the owner to bring that file to a session that has the playbook repo. In a cloud session, they can attach it.
5. **Tell the owner,** in 3–6 lines:
   - the key numbers against the targets;
   - the top lessons;
   - the playbook changes proposed, with where they went.
