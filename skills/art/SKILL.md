---
name: art
description: Make or polish drawn art (illustrations, icons, widget art) with the art loop - a family style sheet, numeric gates calibrated on today's art, three Makers, blind critics with today's art hidden as a control, the owner's pick, directed edits, and a family review. Agents catch faults; the owner makes every taste call. Use when a project needs drawn art made or improved by code.
argument-hint: "[<piece> | family | light <piece>]"
---
# The art loop

*`${CLAUDE_PLUGIN_ROOT}` is the playbook folder. If you see it literally, find the folder by searching for `PLAYBOOK.md` under `~/.claude/plugins/`, `/opt/app-build-playbook` or `.claude/playbook/`.*

Agents are good at catching faults and poor at taste. So they make variants and check them against numbers, and
**the owner makes every taste call**. The art is code (generators, fixed seeds), so every variant can be rebuilt and
compared (L-33 to L-42). Worked example: `${CLAUDE_PLUGIN_ROOT}/examples/running-app/ART-LOOP.md`.

This needs art made by code. For bought or hand-made art, only A2, A6 and A9 apply.

| Step | What | Done when |
|---|---|---|
| A0 Coherence | Reviewers (illustrator, art director, colour and accessibility, vector production) look at every drawing together and draft a family style sheet: line weights at display size, one pen, one colour source, the dark-mode rule, how things stand on the ground | The owner OKs the style sheet |
| A1 Foundation | One size table, one token file, a lint over every finished vector | Exports identical apart from agreed changes |
| A2 Brief | `${CLAUDE_PLUGIN_ROOT}/templates/ART-BRIEF.md`: fixed inputs, what changes, three directions, a look to avoid, gates, rubric | The owner picks the directions |
| A3 Gates | A renderer and a gate script, **calibrated on today's art first** | Today's numbers match the coherence measure |
| A4 Wide round | Three Makers in parallel, one direction each, each in its own copy | Every variant passes every gate (a fail goes back once) |
| A5 Blind critics | Two critics; variants shuffled; **today's art hidden among them as a control** | Scores recorded. If the control doesn't rank last, the review is broken |
| A6 Owner picks | The family board updated (one link, real size, light and dark); one question with a recommendation | Picked, mixed or redirected |
| A7 Directed edits | One Maker per edit: the exact changes, a "must not change" list, and a byte-identical rebuild of the last version first | Gates pass; his next note or a lock |
| A8 Final review | Two reviewers, **told what's decided**; at most 5 small fixes; points go to him as a tick list with clash notes | Ticked fixes applied; he locks |
| A9 Verify | Every final vector: valid, no gradients, colours all tokens, size budget; rebuild check | All pass |
| A10 Family review | After the last piece: every panellist reviews all locked pieces as one set; points merged, clashes marked; he ticks; one Maker per area (one owns the token file); then A9 again | He locks the family |

**Rules.**
- Rubric (1–5): subject and place truth, line quality, value structure in both modes, legibility at 1×, family match,
  calm, and composition (a continuous ground; every object stands on it; one treatment per depth layer).
- After the wide round the owner picks straight away. Open-ended polish drifts on taste while passing every number.
- When cutting detail, cut infill before frames.
- At most one wide round plus directed edits per brief. If nothing passes the gates, rethink the brief with him.
- References are for analysis, never traced. Links and licences in `design/SOURCES.md`. No third-party images in the
  repo.

**`light <piece>`** (Light and Standard projects): brief → one wide round → the owner picks → directed edits → A9.

**`family`**: run A10 on the pieces already locked.
