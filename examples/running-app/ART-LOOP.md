# Running-App: the art loop (21–23 Oct 2026)

*The worked example behind PLAYBOOK "The art loop" and lessons L-33 to L-41. First Light's art: pen-and-ink drawings for an iOS running app. The project's own record is `design/iterate/` on the Running-App branch `claude/art-iteration`.*

**The short version:** go wide, check hard, and the owner chooses. Agents make the variants and check them against
numbers. Blind critics rank them, with today's art hidden as a control. Ben makes every taste call. Every iteration
goes on one page, the family board, so the pieces are always judged together.

---

## How Ben works (the owner's preferences)
- **On his phone:** short, plain messages; pictures over prose; no wall of numbers.
- **Options with a recommendation,** asked as a multiple-choice question, never an open "what do you think?".
  He often answers with a free-text note instead of an option; read it literally and act on what it says.
- **One page for everything:** the family board (`board.py`) shows every drawing at its real size, light then
  dark, with each piece's history below. Updated in place at the same link after every round. No separate pages.
- **He decides on taste; reviewers advise.** Reviewer points go to him as a tick list ("agree with which?"), with
  a note where a point clashes with something he already decided. He rejects freely (e.g. "quiet the jacaranda":
  no, it is the family tree).
- **Propose before building** anything big; small, clear notes ("the balconies need a frame") are just done.
- **Ends a piece with a final review:** "final review from reviewers, their edits, and we should be done". The last
  round's fixes are applied without another ask, then he locks it.
- **Nothing ships by accident:** art lives on branches; no merge to main (each push is an Xcode Cloud build) until
  he asks.

## Stages and gates

| Stage | What happens | Output | Gate (done when) |
|---|---|---|---|
| A0 Coherence | Reviewers look at every drawing together (illustrator, art director, colour/accessibility, vector production) | `COHERENCE.md`: the family style sheet | Ben OKs the style sheet: line weights in pt at display size, one pen, one colour source, dark-mode rule, ground rule, build rules |
| A1 Foundation | Mechanical: one size table, one token file, a lint | `tokens.json`, `lint.py` | Exports byte-identical except the agreed changes |
| A2 Brief | Fixed inputs, what changes, three directions, a "look to avoid", gates, rubric | `<piece>/BRIEF.md` | Ben picks the directions (or the recommended set) |
| A3 Gates first | A gate script and a renderer, calibrated on today's art (v0) | `<piece>/tools/` | v0's numbers match the coherence measure; the gate fails v0 where v0 is known to be wrong |
| A4 Wide round | Three Makers in parallel, one direction each, each in its own copy of the generator | `<piece>/<v>1a…c/` with NOTES, gates.json, changed files | Every variant passes every gate (a fail goes back once) |
| A5 Blind critics | Two critics (illustrator, art director), variants relabelled, v0 hidden among them | Scores and top-3 flaws per variant | Critics' average and ranking recorded; v0 ranked last confirms the review works |
| A6 Ben picks | Board updated; one question with a recommendation | Ben's pick in the README | Ben has picked, mixed or redirected |
| A7 Directed edits | One Maker applies only the agreed fixes and Ben's notes; "must not change" list in every brief | `<v>2…` | Gates pass; rebuilds byte-identical (`make.py`); Ben's next note, or a lock |
| A8 Final review | Two reviewers, told what's decided and not to reopen it; at most 5 small fixes | Fix list | Fixes applied; Ben locks |
| A9 Verify | Every final vector: valid XML, viewBox, no gradients, colours all tokens, size budget; rebuild check | Check output | All pass |

## Roles
| Role | Who | Does | Doesn't |
|---|---|---|---|
| Orchestrator | Main session | Briefs, gates, blinding, the board, asks Ben | Decide on taste |
| Maker | Subagent, one per direction | Edits its own generator copy, renders, looks at its own PNGs, writes NOTES (3 weak points) | Touch shared code or other variants; commit |
| Critic | 2 subagents, blind | Scores the rubric, ranks, names concrete fixes | See names, notes or gates; pick for Ben |
| Reviewer (final) | 2 subagents, not blind | Lists at most 5 small fixes, verdict | Reopen decided points |
| Gate script | Code | Pass/fail on line weight, contrast, colour, gradients, size | — |
| Ben | Owner | Picks, notes, locks | — |

## Numbers (21–23 Oct)
| Piece | Rounds | Result | Critic avg (pick vs today) |
|---|---|---|---|
| Widget jacaranda (pilot) | 3 wide + directed edits | w2: the spot tree exactly | 3.67 vs 2.0 |
| Spot jacaranda | 1 wide + 1 edit | s2 | 4.0 vs 2.0 |
| Launch mark | 1 wide + 1 edit | l2 | 4.2 vs 2.6 |
| Body map | 1 wide, 2 edits, a blind A-vs-B check | m3b, locked | 3.75 vs 2.75 |
| Street scene | tree swap, 1 wide, 8 edits (6 from Ben's notes), final review | r9c, locked | 4.0–4.1 vs 2.75 |

Street: line median 0.44 → 0.69 pt; dark terrace lines 3.2:1 → 2.4:1 over their fills; terrace strokes 238 → 115.

## Lessons (now L-33 to L-41 in LESSONS.md)

**Keep · Gates before taste.** Agents can't judge fine detail at true size, so every visual verdict carries numbers
from a script (line width at display size, contrast, dark-mode ratio, gradients, tokens). Calibrate the gate on
today's art first: the street's v0 measured 0.44 pt, matching the coherence measure, before any Maker ran.

**Keep · Blind critics with a hidden control.** Today's art, hidden among the variants, ranked last in every round
across five pieces. When the control doesn't come last, the review is broken. Two critics, averaged: one critic's
score moved ±0.4 on the same image.

**Keep · Ben picks straight after the wide round; polish is directed edits.** Open-ended polish rounds drifted on
taste (the widget pilot's tree became an acacia while meeting every number). Each later edit lists exactly what
changes and what must not.

**Keep · One board, every piece, real size, light and dark.** Consistency problems (two pens, three dark modes,
2× spread in line weight) only showed when everything sat side by side.

**Change · The owner's eye catches what the rubric misses.** On the street the critics scored r2c well, but Ben saw
at once that there was no ground and that a half-outlined city looked wrong. The rubric had no "does it stand on
something?" item, so add a composition check: ground, horizon, every object grounded (his later note: "make sure
the bins sit on it").

**Change · Reviewers re-raise decided points unless told.** Critics twice asked to redraw the shared jacaranda,
the family's one tree. Final-review briefs now list what's decided.

**Change · Cutting detail can strip a form.** Halving the terrace lines turned the balconies into "just a shade";
Ben asked for a frame back. When cutting interior lines, keep each element's frame (rails, posts, edges) and cut the
infill.

**Change · Keep the board under the page limit.** The board reached 15.9 MB of 16 MB with every street round in
both states; older rows now show light and dark only.

**Keep · Reproducible variants.** Every variant folder holds only its changed generator files plus a `make.py` that
rebuilds byte-identical from the base branch, so a round can be resumed after a restart and diffed.

## Tools (in the Running-App repo)
- `board.py`: the family board; `board-inputs/` holds each variant's renders.
- Per piece: `tools/sheet.mjs` (Playwright renders at 1×/3×, zoom, and an 8 px/pt measure render) and
  `tools/gates.py` (built on `widget-jacaranda/tools/gates.py`'s Euclidean line-width measure, checked by
  `linetest.py`).
- Generators on `design/scene-foundation`: `pen.py` (street), `jacaranda.py` (the one tree), `widget.py`,
  `legs.py`, `export.py` (asset catalog with a lint), `tokens.json` (the one colour source).
