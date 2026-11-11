# <Build> <lane> review, round <n>: <scope in a few words>

*<date> · <agent> · Scope: <documents and versions, or commits a1b2c3..d4e5f6> · Read first: OWNER.md ✓ DECISIONS.md ✓ · Not run / could not check: <…> · No personal data is quoted.*

**Critical: <n> · Major: <n> · Minor: <n> · Nit: <n>**

## 1. Earlier findings
| ID | Closed / Partly / Not closed / Came back | Note |
|---|---|---|

## 2. Promises checked (invariants, by ID)
| ID | Holds? | How I checked (the path, a counter-example or a probe) |
|---|---|---|
| I1 | ✓ / ✗ | |

## 3. New issues
Labels: **[Defect]** wrong now · **[Latent]** wrong once X happens · **[Hypothetical]** only on an unlikely path ·
**[Disagree]** a judgement call. ⚠ = loosens a rule. "Introduced by the fix for <ID>" where so.

| ID | Severity | Label | Where | Problem (a concrete case: before X, after Y) | Fix |
|---|---|---|---|---|---|

## 4. Tests recomputed
| Test | Expected in the SPEC | Recomputed | Match? |
|---|---|---|---|

## 5. Missing tests (input → expected; made-up values)
| Proposed ID | Input | Expected |
|---|---|---|

## 6. Checked and found sound
- …

## 7. Dropped after checking
- <What I suspected, and how I disproved it.>

## Verdict
<One paragraph, plain words.>

---
> **Status (added after fixes, <date>):** <IDs fixed in commit …; IDs left as they are, each with its reason.>
