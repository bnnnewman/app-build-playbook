---
name: start
description: Start a new project on the playbook, adopt an existing one, or upgrade a project from an older playbook version. Asks the harm questions, sets the size (Mini, Light, Standard, Full), the project type (phone app, web tool, tool with a routine) and the teaching mode, proves the set-up, and scaffolds the project. Use when the owner says "start a new app/tool", "set this up", or "adopt/onboard this project" or "upgrade this project to the new playbook".
argument-hint: "[new | adopt | upgrade]"
---
# Start or adopt a project

*`${CLAUDE_PLUGIN_ROOT}` is the playbook folder. If you see it literally, find the folder by searching for `PLAYBOOK.md` under `~/.claude/plugins/`, `/opt/app-build-playbook` or `.claude/playbook/`.*

Read first: `${CLAUDE_PLUGIN_ROOT}/OWNER.md`, then `${CLAUDE_PLUGIN_ROOT}/PLAYBOOK.md` ("Three choices at the start", "Stage 0", "Project layout").

**Mode:** from `$ARGUMENTS`. If none: a project `CLAUDE.md` that names an older playbook version means **upgrade**;
other code in the repo means **adopt**; none means **new**. Say which, in one line.

## 1. The interview (one grill, via `/playbook:grill start`)

Skip anything `OWNER.md` or the repo already answers. Ask the harm questions **before** the size.

1. **What it is for**, in one sentence, and what it is *not* for.
2. **Who uses it, and who must agree.** Roles, not names. Anyone besides the owner?
3. **Harms.** Does it show or store data about real people? Could one person see another's? Could a wrong answer
   cost money or a deadline? Could it affect health or safety? Could a pet or child be harmed?
4. **Size**, recommended from the harm answers (PLAYBOOK table): Mini / Light / Standard / Full. Any "yes" in 3 means
   at least Standard.
5. **Type:** "Where will you use it: on your phone, in a browser, or does it run by itself on a schedule?"
6. **Teaching mode:** teach / explain / ship.
7. "Does it need information from somewhere else, like a spreadsheet, a watch or a website? Is anyone else
   building part of it?"
8. **How it works today with no app.**

The harm answers become "What Critical means here" in `CLAUDE.md`.

## 2. Prove the set-up (before any feature)

- **Can this session build and test it?** Run it once. If it can't (for example an iOS screen on Linux), set up what
  stands in, from `${CLAUDE_PLUGIN_ROOT}/platforms/<type>.md`, and record "what runs where".
- **How does a change reach the owner?** Write it as one paragraph. Every session must give the same answer.
- **CI:** prove it runs once, or record "no CI" on purpose with the pre-push checks that replace it.
- **`.gitignore`** from `${CLAUDE_PLUGIN_ROOT}/templates/gitignore` before the first commit.

## 3. Scaffold

From `${CLAUDE_PLUGIN_ROOT}/templates/`, into the layout in PLAYBOOK "Project layout":
- **Mini:** `BRIEF.md` (it holds the plan, rules, decisions and checks), `CLAUDE.md` from
  `PROJECT-CLAUDE-MINI.md`, `STATUS.md`. Stop there. Mini decisions are `D-01`… in the brief's section 6. The path
  from here: `/playbook:spike mini` → `/playbook:build` (mock-up before anything visible) → `/playbook:close` →
  publish → one retro.
- **Other sizes:** `CLAUDE.md` (from `PROJECT-CLAUDE.md`), `STATUS.md`, `DECISIONS.md`, `IDEAS.md`, `CHANGELOG.md`,
  `docs/owner/`, `work/`, `retros/`, `spikes/`; `design/` if it has a screen.
- If a `CLAUDE.md` exists, **add** the playbook sections. Never overwrite the owner's own words.
- Optional: `.claude/settings.json` from `templates/settings.json`, so local sessions load the plugin.

Scaffold `DECISIONS.md` (Mini: `BRIEF.md`) **before** the grill, so answers have somewhere to go. Decision IDs here
are `D-S0-nn` (Mini: `D-01`… in the brief's section 6).

## 4. Adopt only

Do these before the interview finishes. Don't redesign anything yet.
1. **Baseline** on this session's branch: git state; build and tests if they can run here. If not: write "not run",
   and ask the owner to run them. Never state a count no command produced.
2. **Scan for secrets and personal data**, in the tree and in `git log -p`. Report before any push.
3. **Ask for existing notes** and read them first.
4. **`AS-IS.md`** from the template: features and their state, rules found in the code (AS-01…, each *intended /
   accidental / unknown*), risks, questions. For a large codebase, use parallel Explore agents by area.
5. **Grill the as-is rules** (confirm / change / unknown).
6. **A bug that touches a Critical harm is fixed now**, with its own decision and a check on the device.
7. **One decision log:** import an older log's rows as `P-nn`.
8. **Re-entry plan**, for the owner's yes: `plan` and `spec` (recovered, with provenance) → `spike` → `design` if
   wanted → `panel` and `audit` → `build A` (audit the existing code first, then plan fixes from the findings).

## 5. Upgrade only (a project on an older playbook version)

Skip sections 1 to 4. Nothing about the product changes. **Propose the list below, wait for yes, then do it** on a
branch, in one PR. Never during an open build.
1. **Read what the project already decided.** Its own `CLAUDE.md` rules and decisions win over the playbook's
   defaults. List each place they differ and keep the project's, unless the owner says otherwise.
2. **Keep every ID** (decisions, findings, tests) and the project's own numbering. Add a ranges table if needed.
3. **Size, type and teaching mode:** take them from the project; ask only for what is missing.
4. **Replace the old copy of the playbook** under `.claude/` with the current one, and remove skills it no longer
   ships. Keep the project's own tailored reviewers.
5. **Map the old words to the new** in `CLAUDE.md`: a phase is a build; `phase-start` and `phase-close` are `build`
   and `close`; `design` (plan and spec) is `plan` and `spec`; `NOTES-FOR-OWNER.md` is `STATUS.md` plus
   `docs/owner/`. Closed phases keep their names and files.
6. **Add what is missing**, from the templates: `STATUS.md`, `IDEAS.md`, the "Every build, every session" section.
   Don't move existing files here: that is `/playbook:tidy layout`, offered as a separate step.
7. **Carry lessons home:** anything in `retros/playbook-proposals.md` goes to `/playbook:retro sync`.
8. Say what was left as it is, and why.

## 6. Finish

- Write `STATUS.md` (run `/playbook:status`).
- Commit: `Playbook: start (<new|adopt|upgrade>): <size>, <type>, <mode>`. Push this session's branch (no remote: commit
  locally and say so).
- Tell the owner in five lines: what was set up, the size and why, how a change reaches him, anything the scan
  found, and the one next step.
