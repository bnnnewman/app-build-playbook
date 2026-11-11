---
name: mock
description: Make a mock-up page the owner can open on his phone and choose from, before anything visible is built - "Now vs options" for a change, a round-0 page of directions, or a wording page of every new string. Made-up data only. Use before any new screen or visible change, whenever a question is about how something looks or reads, and at the end of a build for new wording.
argument-hint: "[change <what> | round0 | wording <build>]"
---
# Mock-up

*`${CLAUDE_PLUGIN_ROOT}` is the playbook folder. If you see it literally, find the folder by searching for `PLAYBOOK.md` under `~/.claude/plugins/`, `/opt/app-build-playbook` or `.claude/playbook/`.*

The owner does not choose a look from words, and he rejects anything he hasn't seen. So every visible question is a
picture.

## Rules for every mock-up

- **Read the lock first** (`design/STYLE-GUIDE.md`, the ledger, design decisions). Check your options against it
  before he sees them. Name the lock rules the change touches.
- **Made-up data only.** Never his real data, names or places.
- **True size, light and dark,** and the largest text size where layout could break.
- **Each option is labelled** (A, B, C) and its parts are named, so he can say "A with C's title".
- **Under each option, one line: what it does** and what it costs.
- **Say what the picture can't show**, in plain words ("the phone's top and bottom bars, real text sizes,
  movement: you'll check those on the phone"), and which device check covers it.
- One page per topic, **republished to the same link** as it changes. Put the link in `work/<build>/NOTES.md` (Mini:
  `BRIEF.md` section 10).
- Publish as a private artifact where the session can; otherwise write `design/mocks/<build>/<name>.html` and tell
  him how to open it.

## `change <what>`: Now vs options

1. "Now": the current screen, built from the real code's layout with made-up data.
2. Two or three options beside it. One ★ with a one-line reason.
3. Number each choice on the page 1..n. He replies "1 B, 2 A, 3 mix: A with C's title".
4. **Read his picks back** before building. Record each with `/playbook:decide` (direction and look are separate
   rows).
5. The build must match the picked mock-up. If it can't, say so **before** building.

## `round0`

For `/playbook:design round0`: 2–3 named directions; font and colour choices; the main screen in every state.

## `wording <build>`

From `${CLAUDE_PLUGIN_ROOT}/templates/WORDING-PAGE.md`. Every new or changed string of a build on one page: where it shows, the words, and for a change the old words beside
the new. Safety lines are marked and are **not** approved here: they go through the safety lane, asked alone. He
replies "words fine" or names the lines to change.
