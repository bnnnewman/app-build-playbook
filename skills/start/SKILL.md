---
name: start
description: Start a new app on the app build playbook, or adopt a half-built existing app into it. Interviews the owner, sizes the process, baselines and inventories existing code (adopt), writes AS-IS.md, scaffolds the project docs and CLAUDE.md Playbook map, and picks the stage to begin at. Use when the user says "start a new app", "set up the playbook", or "adopt/onboard this project".
argument-hint: "[new | adopt]"
---
# Start or adopt a project

*`${CLAUDE_PLUGIN_ROOT}` is the playbook folder. If you see it literally, not replaced with a path, find the folder by searching for `PLAYBOOK.md` under `~/.claude/plugins/` or `.claude/playbook/`.*

Read `${CLAUDE_PLUGIN_ROOT}/PLAYBOOK.md` first: "Sizing the process", Stage 0, "Conventions" and "Project layout". Skim `${CLAUDE_PLUGIN_ROOT}/LESSONS.md`.

**Asking the owner:** use AskUserQuestion if you have it (up to 4 questions a call, 2–4 options each, the recommended option first, marked "(Recommended)"). Otherwise ask in chat as lettered options and wait. Keep the rounds short, and never send a wall of questions.

**Mode:** take it from `$ARGUMENTS`. If there are none, look at the repo: app code means **adopt**, no code means **new**. Confirm the mode with the owner.

## The owner interview (both modes; skip anything the code already answers)

1. What the app is for, and who uses it.
2. **Stack and "device".** iOS, Android, web, desktop, or a script? What does "try it on the device" mean for it?
3. **Environment.**
   - Do you work on your own machine, in Claude Code cloud sessions, or both?
   - What's installed (Xcode, Node, Python…)?
   - Is there a git remote?
4. **External data:** APIs, sensors, exports they already have.
5. **The worst thing the app could get wrong,** and who or what it would hurt. This defines "Critical", and it sets the **size**: Light / Standard / Full. Recommend a size and let the owner choose.
6. Hard constraints: time per day, budget, equipment.
7. How the domain works today without the app. This becomes PLAN §8.

## New app

1. If the folder isn't a git repo, run `git init` (with the owner's OK).
2. Run the interview.
3. **Scaffold** from `${CLAUDE_PLUGIN_ROOT}/templates/`, filling in what you know and leaving `<…>` where you don't:
   - **`CLAUDE.md`** (from `PROJECT-CLAUDE.md`), with the Playbook map (stage, size, environment, remote) and the Critical definition.
   - **`DECISIONS.md`, `NOTES-FOR-OWNER.md`, `CHANGELOG.md`.**
   - **Folders:** `spikes/`, `reviews/`, `phases/`, `retros/`.
   - **A `.gitignore`** covering raw spike output, exports and debug stores.
4. Record the interview answers as D-001… in `DECISIONS.md`.
5. **Show the owner the Playbook map and the starting stage, and get a yes.** That's the stage 0 gate.
6. **Next:** `/playbook:design plan`.

## Adopt an existing app

Don't redesign anything yet. First understand it.

1. **Baseline.**
   - Record `git status`, the branch, the last commit and the remote.
   - If the tree is dirty, ask the owner to commit or stash first.
   - Create and switch to a `playbook/adopt` branch.
   - Run the build and the tests. Record what happened: it builds yes/no; tests N pass / N fail / none.
2. **Secret and personal-data scan.**
   - Grep the tree and `git log -p` for keys, tokens, passwords, `.env` files, exports, photos with location, and personal data.
   - Check the `.gitignore` coverage.
   - **Report findings to the owner before any push.** Recommend rotating any exposed key.
3. **Owner's intent.** Ask for existing notes, issues, chat exports or idea lists, and read them first. They show what the app was *meant* to do; the code shows what it *does*.
4. **Inventory.** For a large codebase, use parallel Explore agents, split by area (structure and stack; features and screens; data and storage; external data; tests and CI). Each returns findings, not file dumps. Then write `AS-IS.md` from `${CLAUDE_PLUGIN_ROOT}/templates/AS-IS.md`:
   - the baseline results;
   - features, each with a state (works / partial / stub / broken);
   - **rules found in the code** (AS-01…), each stated plainly with its file location and marked *intended / accidental / unknown*;
   - risks;
   - open questions.
5. **Review `AS-IS.md` with the owner.** They mark each rule confirm / change / unknown and answer the open questions. Ask in batches. Log the answers in `DECISIONS.md`.
6. Run the rest of the **interview**.
7. **Scaffold** as in "New app" step 3. Fit around the existing layout:
   - **If a `CLAUDE.md` exists, add a "Playbook" section to it. Never overwrite it.**
   - Map any existing names in the Playbook map rather than renaming files.
8. **Recommend a re-entry plan**, and get the owner's yes. It's usually:
   - `/playbook:design`: recover the PLAN and SPEC, with each rule's provenance tagged (found in code AS-xx / confirmed / new);
   - `/playbook:spike`, if the app reads external data;
   - `/playbook:panel` and `/playbook:audit R` on the recovered docs;
   - **Phase A**: retro-fit the invariant tests, audit the existing code module by module, and fix the Criticals and Majors (`/playbook:phase-close A`);
   - build phases P1… for what's left.
9. Record the plan in the Playbook map's Stage row and in `CHANGELOG.md`.

## Finish

- Commit: `Playbook: start (<new|adopt>), stage <n> next`.
- Push only if there's a remote, the secret scan is clean, and the owner agrees.
- Tell the owner, in 3–5 lines:
  - what was created;
  - the size and the stage they're at;
  - anything from the scan;
  - the single next command.
