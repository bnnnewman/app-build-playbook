---
name: spec
description: Write or revise SPEC.md, the software truth - invariants, definitions, data model, rules as tables, build list, acceptance items and Input→Expected tests. Use at stage 2, when recovering a spec for an adopted project, or whenever an accepted change must be applied to the spec.
argument-hint: "[write | revise <reason>]"
---
# Spec

*`${CLAUDE_PLUGIN_ROOT}` is the playbook folder. If you see it literally, find the folder by searching for `PLAYBOOK.md` under `~/.claude/plugins/`, `/opt/app-build-playbook` or `.claude/playbook/`.*

Read first: `PLAN.md`, `DECISIONS.md`, `${CLAUDE_PLUGIN_ROOT}/PLAYBOOK.md` "Stages 1–2". Engineering choices are
yours: make them, and log each as an interpretation in `work/SP/NOTES.md`. Only real choices go to the owner.

## Write

1. Start from `${CLAUDE_PLUGIN_ROOT}/templates/SPEC.md`.
2. **One home for each rule.** Each rule section cites its PLAN section and holds the numbers and the algorithm.
3. **§3 Invariants** (I1, I2…): from PLAN §2 and the Critical list. Each is testable and gets a test of the
   *promise* (`TI1a`…), not of one example. Include the standing ones: unknown input never shows a guess; nothing
   changes without the owner's yes; a loosening needs sign-off.
4. **§4 Definitions:** windows, units, time zone and daylight saving, what counts as an event, statistics.
5. **§5–6 Data:** the real field names and values, **copied from the source** (`/playbook:spike`), and the rule for
   adding a stored field later. If a store maps fields by hand, add a scan test that every model field is mapped.
6. **§7 Rules:** every lifecycle as a state table with the unknown, overlap and reopen cases. Precedence as an
   ordered list.
7. **§12 Builds:** each with a "done when" the owner can see. The first build proves the path to the device.
8. **§13 Tests:** ID | Input | Expected, exact numbers, a named fixture. Every branch of every rule, the boundaries,
   missing data, first and last rows. Then the invariant tests.
9. **§16 Acceptance:** what the owner will check, written now. Tag each item *machine* / *partly* / *device*.
10. **Grill it:** `/playbook:grill spec` (IDs `D-SP-nn`). Roots: is each invariant right, and is one missing; the
    definitions; the unknown cases; the build order.
11. **Gate:** every PLAN rule has a SPEC home and a test; invariants listed; the grill ended in a yes.

## Revise

As in `/playbook:plan` "Revise", plus: recompute every test the change touches, and run
`python3 ${CLAUDE_PLUGIN_ROOT}/scripts/coverage.py --spec SPEC.md --tests '<glob>'`. It must report 0 missing and 0
rows it couldn't read.

Commit `Spec: v<n> (<reason>)`. Next: `/playbook:spike`, or `/playbook:design` if there's no outside data.
