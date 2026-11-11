---
name: ideas
description: Keep the project's ideas inbox - log an idea in one line and carry on, triage the list by value, effort and the checks each needs, turn chosen ideas into briefs and idea builds, and mark built ones. Use when the owner says "log it", "another thing for later", "ideas workshop", drops feedback while using the app, or asks what to build next.
argument-hint: "[log <idea> | triage | brief <idea> | sweep]"
---
# Ideas

*`${CLAUDE_PLUGIN_ROOT}` is the playbook folder. If you see it literally, find the folder by searching for `PLAYBOOK.md` under `~/.claude/plugins/`, `/opt/app-build-playbook` or `.claude/playbook/`.*

One inbox per project: `IDEAS.md` (from `${CLAUDE_PLUGIN_ROOT}/templates/IDEAS.md`), on main. Ideas go there, never
straight into code. There is no hard freeze: ideas are built in small batches as point releases, each with the
checks its size needs.

## `log <idea>` ("log it")

Add one row: ID (`F-nn` feature, `G-nn` gap, `U-nn` from use), the idea in his words, where it came from, date,
status `inbox`. Say "Logged" and carry on with what you were doing. Don't size it, discuss it or build it now.

## `triage`

1. For each `inbox` row fill: **value** (who benefits, when), **effort** (small / medium / large), **checks it
   needs** (from `${CLAUDE_PLUGIN_ROOT}/GLOSSARY.md`, "Sizes of change"), **merges with** (another row).
2. Check each against `DECISIONS.md` and the **"Rejected on principle"** list at the top of `IDEAS.md`. An idea
   that clashes says so.
3. Put it to the owner as a ranked list with the "if we skip it" columns (why; when it bites; fails safe?; cost in
   usage windows), in grill rounds. His default: **small and it fits the window → build it now.** Ask "now or later"
   only for medium and large.
4. Set each row `chosen <version>`, `parked`, or `rejected` (with the principle, added to the list at the top).

## `brief <idea>`

Write `work/I-<name>/BRIEF.md` for a chosen idea (via `/playbook:build I-<name>` step 2–3). Anything visible gets a
mock-up first. Bundle several idea builds into one point release so the owner gets one new version to try.

## `sweep`

- Mark rows that have shipped: `built <version>`, with the build ID. Built ideas stay in the list, marked.
- Rows `chosen` for a version that has shipped without them go back to `inbox`.
- Report in three lines: built, chosen and waiting, parked.

## The feedback inbox

When the owner keeps one session open for thoughts while he uses the app, every message is either a **bug** (→ a fix
build, `CHANGELOG.md`), a **decision** (→ `/playbook:decide`) or an **idea** (→ `log`). Say which, in one line each.
Publish the list as a phone-readable page if he asks to see it.
