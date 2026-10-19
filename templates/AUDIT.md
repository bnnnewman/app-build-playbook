# <Stage> safety-logic audit, round <n>: <scope in a few words>

*<date> · logic-auditor (read-only; probes in a scratch copy only) · Scope: <docs + versions, or commit range a1b2c3..d4e5f6> · Could not check: <e.g. platform builds> · No personal data is quoted.*

**Critical: <n> · Major: <n> · Minor: <n> · Nit: <n>**

## 1. Are the previous findings closed?

| ID | Status | Note |
|---|---|---|
| R-SA2-01 | Closed / Partly / Not closed / Regressed | |

## 2. Invariants checked

| ID | Holds? | How I checked (path, counter-example or probe) |
|---|---|---|
| I1 | ✓ / ✗ | |

## 3. New issues

Labels:
- **[Defect]:** wrong now.
- **[Latent]:** wrong once X happens.
- **[Hypothetical]:** only on an unlikely path.
- **[Disagree]:** a judgment call.

| ID | Severity | Label | Location | Problem (with a concrete scenario: before X, after Y) | Fix |
|---|---|---|---|---|---|

## 4. Tests recomputed

| Test ID | Expected in SPEC | Recomputed | Match? |
|---|---|---|---|

## 5. Missing tests (input → expected; made-up values)

| Proposed ID | Input | Expected |
|---|---|---|

## 6. Safety rules checked for weakening

- <Any change in this diff that loosens a rule, and whether the owner signed it off (⚠ in DECISIONS.md).>

## 7. Other paths I checked and found sound

- …

## 8. Dropped after checking

- <Suspected issues I disproved, and how.>

## Verdict

<One paragraph.>

---
> **Status (added after fixes, <date>):** <IDs fixed in commit …; IDs left as is with reasons>
