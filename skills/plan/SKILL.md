---
name: plan
description: Write or revise PLAN.md, the human-facing truth of what the tool is for and the rules it serves, usable by hand with no app. Use at stage 1, when recovering a plan for an adopted project, or when a decision changes what a rule means.
argument-hint: "[write | revise <reason>]"
---
# Plan

*`${CLAUDE_PLUGIN_ROOT}` is the playbook folder. If you see it literally, find the folder by searching for `PLAYBOOK.md` under `~/.claude/plugins/`, `/opt/app-build-playbook` or `.claude/playbook/`.*

Read first: `${CLAUDE_PLUGIN_ROOT}/OWNER.md`, the project `CLAUDE.md`, `DECISIONS.md`, and for an adopted project
`AS-IS.md` and the owner's notes. Mini projects have no PLAN: the same content goes in `BRIEF.md`.

## Write

1. Start from `${CLAUDE_PLUGIN_ROOT}/templates/PLAN.md`.
2. **§1 from real facts** the owner already has (exports, history, the as-is code). Summaries only; no personal
   values.
3. **§6 decision rules.** For each: inputs; the order when rules collide ("first match wins", "strictest wins");
   what happens when an input is missing or unknown (never good news). Adopted projects tag each rule: found in code
   (AS-xx) / confirmed / new.
4. **§2 principles.** These become the SPEC's invariants. Start from the harms in "What Critical means here".
5. **The smallest group it goes live for**, and a **"stop if"** line.
6. **§8 Doing it by hand**, so the thing works with no app.
7. **§0 last:** one screen.
8. **Grill it:** `/playbook:grill plan`. Roots: each rule, its order and its missing-data case; the principles; by
   hand. Decision IDs `D-PL-nn`.
9. **Gate:** the grill ends in a yes, and the owner confirms he could run it by hand from this page alone.

## Revise

For each change: list every place it touches (PLAN section, SPEC rule, tables, tests, screens, `CHANGELOG.md`), edit
all of them, and search for the old wording. A loosening is ⚠ and asked alone. Bump the version of the file that
changed, and add a `CHANGELOG.md` line: the trigger, the IDs, the sections.

Commit `Plan: v<n> (<reason>)`. Next: `/playbook:spec`.
