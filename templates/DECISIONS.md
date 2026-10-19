# Decisions

The one place for every decision, every conservative default waiting on <owner>, and every interpretation. It is append-only: never delete a row; supersede it with a new one. Cite the ID in commits ("Notes: D-014 …").

**Status values:**
- `pending-default`: the conservative answer is in use and is reversible, waiting on <owner>.
- `confirmed`: <owner> agreed.
- `changed`: <owner> chose differently, applied.
- `rejected`: the proposal was not accepted. It stays recorded so it is not raised again.

⚠ marks any decision that loosens a safety rule. These always need <owner>'s explicit, separate yes.

## Decisions

| ID | Date | Source | Question | Options (★ = recommended) | Answer | By | Reversible? | Status |
|---|---|---|---|---|---|---|---|---|
| D-001 | | R-SUMMARY C01 | | A ★ / B | A | <owner> | yes | confirmed |

## Interpretations

Readings taken inside the stated rules where the text allowed two. The conservative one is always taken.

| ID | Date | Rule (SPEC §) | Reading taken | Why | Test |
|---|---|---|---|---|---|
| I-001 | | | | | |

## Left as is

Minor findings not fixed, with the reason, usually that the behaviour errs in the safe direction.

| Finding ID | Why it stays |
|---|---|

## Rules carried forward

Constraints that bind later phases, from audits and decisions.

| ID | Rule | From |
|---|---|---|
