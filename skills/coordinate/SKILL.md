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

## Who does this job (decide before every helper or child session)

Take the **first row that fits**. A helper starts cold and its report loses detail, so the first row wins often.

| The job | Who | Why |
|---|---|---|
| A handful of steps, or a look-up whose place you know | **You, no helper** | A helper costs more than it saves |
| Find, list, count, check links, gather status, collect new words, list branches | **Haiku** helper | Nothing to judge |
| One review lane, a verifier, a contained fix with tests, a doc from a template | **Sonnet** helper | Judgement inside clear limits |
| A build session, connected rules, integration, synthesis, the safety lane on a Full project | **Opus** | Many things must agree |
| Opus has tried and failed, or the harm of a miss is Critical and the reasoning is long | **Fable, only after the owner's yes** | See below |

- **You, the coordinator, run on Opus.** If this session is on Fable and the owner hasn't agreed to it for this
  work, say so in one line and suggest he switches.
- **Name the model on every helper and every child session.** A child left unset inherits your model. Never let a
  child inherit Fable.
- **Asking for Fable** (a question on its own, never in a round): what the job is; what Opus got wrong, or why a
  miss here would be Critical; roughly what it costs against Opus; what happens if he says no. Wait for yes. The yes
  covers that one job.
- **Record the cost.** When a helper finishes, add a line to `work/<build>/NOTES.md` → Cost: the job, the model, the
  tokens its finish notice gives, and whether it found anything. The retro adds these up, so the playbook learns
  which steps are worth their cost.

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
- **push only to your branch (no remote, or a push refused: commit locally and say "not pushed"). No PR, no
  merge, never main;**
- **don't ask the owner.** Take the cautious reading, list it "for the owner" in your report;
- the **report** (`templates/CHILD-REPORT.md`): what changed, tests added, SPEC touched, new words, what couldn't be
  done or needs the device, the final count.

- **report back yourself:** message the session that started you when you finish, when you are stuck, and when you
  have a question for the owner. Don't wait to be asked.

Start the child (a new session, or a subagent for small slices), **with its model named** and titled
`<project> · <build> · <what it is doing>`, with the tags `pb:<project>` and `pb:<project>:<build>`. The title is how
you, the owner and the next coordinator find it. Reviewers get a frozen commit and their own scratch folder.

## While they run

- **Relay, don't make the owner carry messages.** If one session needs to know something, tell it yourself.
- Collect children's questions into **one** grill for the owner. Record each answer once, in the build that asked.
- **Check-ins back off:** if three in a row find nothing new, stop and wait for an event or the owner.
- **Keep the board.** `STATUS.md` → Running now has one line per child: build, what it is doing, its state
  (working · waiting on you · waiting on a check · done · stuck), the model, and when it last reported. Update it on
  every report. Before answering "where are we?", list your sessions by title and check any child that has been
  quiet: a child that finished cleanly may not have said so.
- **The board as a page:** when two or more children run, publish the board as one private page the owner can open
  on his phone, and republish it to the same link on every change. The link goes in `STATUS.md`.

## `integrate <build>`

1. Merge the slices onto one integration branch. Resolve conflicts in the shared files.
2. **Cross-slice consistency check:** the same thing named, ordered and styled the same way in every slice. Each
   slice can be right alone and the whole inconsistent.
3. Run `/playbook:close` on the integrated build: the lanes run once, on the whole.
4. One wording page for all the slices' new words.
5. Open the PR. **Only you open PRs and merge, and only on "merge N".**

## `hand-over`

When your context is nearly full, say so. Write `work/COORDINATOR-HANDOFF.md` (`templates/HANDOFF.md`): the board
(builds running, their branches, session titles, models and states), what waits on the owner, the next three actions, reminders set. Start the new
coordinator with that file, and tell the owner which session to talk to now.
