# Data spike: field report (redacted)

<!-- Redacted copy: field coverage only. No personal values (min/median/max removed). Raw output is in a git-ignored folder. -->

*<date> · Source: <API/export> · Window: <dates, N days / N records> · Script: `spikes/<name>.py`*

## Fields the rules depend on

| Field | Needed by (SPEC §) | Present on | Fill rate | Verdict |
|---|---|---|---|---|
| <field> | §7.1 | 348 / 366 days | 95% | ✓ use |
| <field> | §7.2 | 0 / 366 | 0% | ✗ never arrives: rule must change |

## Every field returned

| Field | Type | Non-null | Notes |
|---|---|---|---|

## Export file (if any)

| Column | Fill rate | Used by app? | Quirks (quoting, separators, empty markers) |
|---|---|---|---|

**Implausible rows:** <count, and the pattern, e.g. "one row is 1000× too large (metres vs km)">. These become test data and a plausibility rule.

## What this changes in the SPEC

| Change | SPEC § | Effect (Tightens / Loosens ⚠ / Neutral) |
|---|---|---|

## Thresholds still unknown (replay later)

- <Threshold>: replay over real history in Phase <n>, reporting counts only.

## Practical snags

- <e.g. "API returns 403 to the default User-Agent, so set one">.
