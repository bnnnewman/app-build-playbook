# <App>: as it stands (before the playbook)

*Inventory taken <date> at commit `<sha>`. For adopted apps only. It records what existed before the playbook, so nothing is lost or silently redesigned.*

## Baseline

| | |
|---|---|
| Branch, last commit | |
| Builds? | yes / no / **not run** (why) |
| Tests | <N pass, n fail: the count a command produced> / **not run** |
| Secrets or personal data found | <none, or what and where; never the value> |

## Summary

<3–5 lines: what the app does today, how far along it is, and what state it's in.>

## Stack and layout

| Area | What's there | Notes |
|---|---|---|
| Language / framework | | |
| Modules / folders | | |
| Data storage | | |
| External data (APIs, sensors) | | |
| Tests (count, what they cover) | | |
| CI | | |
| Build / run instructions | | |

## Features

| Feature | State (works / partial / stub / broken) | Where in code | Notes |
|---|---|---|---|

## Rules found in the code

Each rule the code implements, stated plainly. These seed PLAN §6 and SPEC §7.

| ID | Rule as the code does it | Where | Intended / accidental / unknown | Owner says (confirm / change) |
|---|---|---|---|---|
| AS-01 | | | | |

## Risks spotted

| What | Why it matters | Severity guess |
|---|---|---|

## Open questions for <owner>

1. …

## Recommended re-entry

<Which playbook stage to start at and why. Usually: data spike → panel on the recovered PLAN and SPEC → audit loop → build A (audit the existing code first, then plan fixes from the findings) → the remaining builds.>
