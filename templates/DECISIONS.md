# Decisions

The owner's decisions, one line each, in order. Appended only. This is the **only** decision record.
Options, build notes, interpretations and "left as is" live in `work/<build>/NOTES.md`. Bug fixes go to `CHANGELOG.md`.

**Status:** `confirmed` · `pending` (a cautious default in use, waiting on the owner) · `rejected` (do not raise
again) · `replaced` (see "Settled by").
⚠ marks a decision that loosens a safety rule. It was asked on its own.
When a later row settles an earlier one, **update both rows**.

IDs are `D-<build>-nn`, so two sessions can't collide: `D-S0-` start, `D-PL-` plan, `D-SP-` spec, `D-LK-` look,
`D-R-` panel, `D-GAPS-` gap analysis, then the build's own ID.

| ID | Date | Question, in plain words | The owner's answer, in his words | Status | Replaces / Settled by |
|---|---|---|---|---|---|
| D-S0-01 | <20 Nov> | <What size should this project be?> | <"Standard"> | confirmed | |

## By profile
Questions not asked, because `OWNER.md` already answers them.

| Date | Question | Default applied |
|---|---|---|

## Rules carried forward
Standing constraints that bind every later build.

| ID | Rule | From |
|---|---|---|
