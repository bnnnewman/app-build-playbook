# <<PIECE>>, round <<N>> brief (<<DATE>>)

What the piece is, where it shows, at what size (pt), in which states and modes. Where its generator lives.

## Fixed inputs (do not change)
- Decisions the owner has already made (cite them: (Owner, date)).
- Shared elements that other pieces use (e.g. the one tree, the logo).
- The palette source (one token file); the export lint must pass.
- The app's rules the art must keep (e.g. no colours that belong to status lights).

## What this round changes
1. The style-sheet rule each change serves (line weight, ground, dark mode, …), with today's measured number.

## Three directions (one per Maker)
- **A · <<name>>.** One sentence.
- **B · <<name>>.**
- **C · <<name>>.**

## Look to avoid
- Name the wrong look as well as the numbers (a measurable brief can describe the wrong thing).

## Composition check
- A continuous ground; every object stands on it; one treatment per depth layer.

## Gates (`tools/gates.py`, after `tools/sheet.mjs`)
- Line weight at display size (median, share under the floor, share over the ceiling).
- Contrast against the paper, light and dark.
- Dark mode: no outline more than <<2.5>>:1 brighter than its fill.
- Quiet or monochrome state: neutral.
- Build: no gradients, size budget, colours are tokens.
- Today's art scores: <<x/y>>.

## Rubric (critics, 1–5)
Subject and place truth, line quality, value structure (both modes), 1× legibility, family match, calm, composition.

## Every Maker delivers
Its changed generator files only, `make.py` (rebuilds byte-identical from the base), `NOTES.md` (direction, what changed, gate numbers, 3 weak points), `gates.json`, and the export for the board. Shape changes need a one-line justification first.
