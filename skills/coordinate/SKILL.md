---
name: coordinate
description: Act as the coordinator - the one session the owner talks to - and run several build or review sessions (or subagents) in parallel safely - a brief file and branch per child, file-ownership slices, the same gates, fixed reports, relayed questions, an integration step, and "merge N". Use when the owner says "set yourself up as the orchestrator", wants work split across sessions to manage context, or a build is big enough to slice.
argument-hint: "[plan | start <build> | integrate <build> | hand-over]"
---
# Coordinate

*`${CLAUDE_PLUGIN_ROOT}` is the playbook folder. If you see it literally, find the folder by searching for `PLAYBOOK.md` under `~/.claude/plugins/`, `/opt/app-build-playbook` or `.claude/playbook/`.*

You are the session the owner talks to. Children build; you brief, relay, integrate and merge. Each rule below was
paid for by a failure (`${CLAUDE_PLUGIN_ROOT}/PLAYBOOK.md`, "the coordinator").

**On a small plan allowance, don't fan out.** One session, tiered checks. Say what the plan costs in usage windows
before starting it.

## `plan`

1. List the work packages. Propose them to the owner with sizes, and **run a few at a time**.
2. Give each a **build ID** (unique slug). That ID is its namespace: decisions `D-<build>-nn`, findings
   `<build>-<LANE>…`, folder `work/<build>/`, branch `claude/<build>`.
3. Hand out anything else that could collide: SPEC section numbers, test-ID prefixes.
4. **Slice by file ownership.** Name each child's files. Name the shared files (theme, shared components, scan
   tests, the style guide): changes there stay small and are reported.

## `start <build>`

Write `work/<build>/BRIEF.md` from `${CLAUDE_PLUGIN_ROOT}/templates/BUILD-BRIEF.md` and **commit it** before the
child starts. A brief that lives only in a message can't be checked later. No session IDs in repo files.

Every brief says:
- read `OWNER.md`, the project `CLAUDE.md` and the design lock first; the teaching mode (usually *ship* for
  children);
- the base commit, the branch, the files owned, the shared files;
- **the gates**, with the baseline count: what must pass before every push;
- **push only to your branch. No PR, no merge, never main;**
- **don't ask the owner.** Take the cautious reading, list it "for the owner" in your report;
- the **report** (`templates/CHILD-REPORT.md`): what changed, tests added, SPEC touched, new words, what couldn't be
  done or needs the device, the final count.

Start the child (a new session, or a subagent for small slices). Reviewers get a frozen commit and their own
scratch folder.

## While they run

- **Relay, don't make the owner carry messages.** If one session needs to know something, tell it yourself.
- Collect children's questions into **one** grill for the owner. Record each answer once, in the build that asked.
- **Check-ins back off:** if three in a row find nothing new, stop and wait for an event or the owner.
- Keep `STATUS.md` current: which builds are running, what waits on him.

## `integrate <build>`

1. Merge the slices onto one integration branch. Resolve conflicts in the shared files.
2. **Cross-slice consistency check:** the same thing named, ordered and styled the same way in every slice. Each
   slice can be right alone and the whole inconsistent.
3. Run `/playbook:close` on the integrated build: the lanes run once, on the whole.
4. One wording page for all the slices' new words.
5. Open the PR. **Only you open PRs and merge, and only on "merge N".**

## `hand-over`

When your context is nearly full, say so. Write `work/COORDINATOR-HANDOFF.md` (`templates/HANDOFF.md`): builds
running and their branches, what waits on the owner, the next three actions, reminders set. Start the new
coordinator with that file, and tell the owner which session to talk to now.
