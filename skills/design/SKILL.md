---
name: design
description: Write or revise the domain PLAN (human-facing truth) and the SPEC (agent-facing software truth) for a playbook project, including invariants, definitions, state tables, build phases and Input→Expected acceptance tests. Use for stages 1-2, when recovering design docs for an adopted app, or whenever an accepted change must be applied to the docs.
argument-hint: "[plan | spec | revise <reason>]"
---
# Design: PLAN and SPEC

*`${CLAUDE_PLUGIN_ROOT}` is the playbook folder. If you see it literally, find the folder by searching for `PLAYBOOK.md` under `~/.claude/plugins/` or `.claude/playbook/`.*

Read `${CLAUDE_PLUGIN_ROOT}/PLAYBOOK.md` stages 1–2, plus lessons L-04, L-06, L-08, L-09, L-11, L-15 and L-16 in `${CLAUDE_PLUGIN_ROOT}/LESSONS.md`. Read the project `CLAUDE.md`, `DECISIONS.md`, and, for an adopted app, **`AS-IS.md` and the owner's notes before anything else**.

When you ask the owner something, use AskUserQuestion if you have it (lettered options, the recommended one first). Otherwise ask in chat and wait. Log each answer in `DECISIONS.md`.

## `plan`: write PLAN.md

1. Start from `${CLAUDE_PLUGIN_ROOT}/templates/PLAN.md`.
2. Fill §1 from **real data** the owner has (exports, history, the AS-IS code). Summarise facts. Commit no personal values.
3. Draft the §6 decision rules. For each, state:
   - its inputs;
   - its precedence ("first match wins" / "lowest wins" / "strictest wins");
   - what happens when an input is missing.
   - **For adopted apps,** tag each rule's provenance: found in code (AS-xx) / confirmed by owner / new.
4. Write §2 principles. These become SPEC invariants.
5. Write §8 "Doing it by hand", so the domain works with no app.
6. Write §0 last: one screen.
7. **Gate:** ask the owner, "Could you run this by hand from the document alone?" Fix whatever they say is missing.

## `spec`: write SPEC.md

1. Start from `${CLAUDE_PLUGIN_ROOT}/templates/SPEC.md`.
2. **One home for each rule.** Each SPEC rule section cites its PLAN section ("§7.2 (plan 6B)") and holds the exact numbers and algorithm. Don't restate meaning the PLAN already gives.
3. **§3 Invariants.** Derive them from PLAN §2 and from the harms in the Critical definition. Each must be testable, and each gets a §13.I invariant test (`TI1a` …).
4. **§4 Definitions.** Cover statistics, windows, units, time zone, the device-clock fail-safe policy, and what counts as an event. Ask the owner about anything that's a real choice.
5. **§6 Data model.** Fields are split into synced / manual / computed, plus the schema-evolution rule. Settle the rule with the owner now (L-16).
6. **§7 Rules.** Write every lifecycle as a state/transition table, including overlap, reopen and unknown cases. Write precedence as an ordered list. Tag provenance for adopted apps.
7. **§12 Build phases.**
   - Phase 0 (spike) and Phase R come first. For adopted apps, add Phase A.
   - Each phase has a "Done when" the owner can observe.
   - A way to run the app on the real device, for this platform, belongs in Phase 2.
   - Platform CI starts in the first phase that touches platform code. A local-only project may not need CI.
8. **§13 Acceptance tests.**
   - Use IDs `T001` …, with Input | Expected, exact numbers and a named fixture.
   - Cover every rule's normal case, each precedence branch, boundaries (exactly at a threshold), missing data, and first/last rows.
   - Then add invariant tests `TI…`.
9. **§14:** point to `DECISIONS.md`. Every open question gets a D-ID, with the conservative default in use.
10. **Gate:** every PLAN rule has a SPEC home and at least one test, and the invariants are listed. Self-check it: grep each PLAN §6 heading for a matching SPEC section.

## `revise <reason>`: change either document

Apply the **fix-impact checklist** (L-05) to every change ID. List every surface the ID touches, edit every one, and grep for the old wording:
- PLAN section;
- SPEC prose, table and data model;
- screens and notifications;
- tests (including recomputing affected expected values);
- `DECISIONS.md`;
- `CHANGELOG.md`.

Then:
- Mark any loosening ⚠ and get the owner's separate yes.
- **Bump only the document(s) that changed:** PLAN v<a>.<b+1> and/or SPEC v<x>.<y+1>. Update the other document's companion-version line.
- Add a CHANGELOG entry. The heading lists both current versions, then the trigger, then the IDs, then the sections touched.

## Finish

- Commit, e.g. `Design: PLAN v1.0, SPEC v1.0`. Update the Playbook map.
- Tell the owner the next step: usually `/playbook:spike`, or `/playbook:panel` if there's no external data.
