# SPEC: <App name>

*Version 1.0 · <date> · Companion: `PLAN.md` v1.0 · Revisions are logged in `CHANGELOG.md`.*

> **For Claude Code.** `PLAN.md` is the source of truth for what the rules *mean*. This SPEC says how to turn them into software: exact algorithms, numbers, data and tests. If the two ever disagree, flag it and ask <owner>. Don't guess.
>
> <One line on scope: e.g. "Single user. Not a medical device. The app recommends; <owner> decides.">

---

## 0. Before writing any app code

Do these in order. Stop and report back where it says so. **No app code until all are met.**

1. **Read `PLAN.md` in full.**
2. **Summarise the real data** <owner> already has (exports, history): every column, fill rate, format quirks. Facts only, no values committed.
3. **Data spike (Phase 0; mandatory if the app reads any external data).** Run `/playbook:spike`. Confirm these fields actually arrive: <list the exact fields the rules depend on>. **Report back to <owner> before building the data layer.**
4. **Expert review done (Phase R).** The panel (`REVIEW-PANEL.md`) has run, <owner> has decided every Critical and Major item, and the audit loop is closed at 0 Critical, 0 Major.
5. **Ask the §14 open questions** that are still open.

## 1. Goal

<What the user sees and does each day / week, in 3–5 bullets.>

**Design principle (measurable):** <e.g. "the daily check-in takes under 20 seconds".>

## 2. Constants (seed data)

| Key | Value | Editable in app? | Source |
|---|---|---|---|
| <key> | <value> | Yes / No (locked) | PLAN §n |

**Locked safety constants.** These are hard-coded and can't be edited in the app. Changing one is a code change that needs <owner>'s explicit confirmation. Each has a test that proves it is not editable.

**Rolling baselines and formulas** (if any): <exact formula, window, inclusivity, what happens with too little data>.

## 3. Invariants (the auditor checks every one, every round)

Numbered, testable statements that must hold on every path. Each has at least one **invariant test** (not just example tests) (lesson L-08). Example shapes:

| ID | Invariant | Test(s) |
|---|---|---|
| I1 | The engine never raises <load/amount> above <the table / last confirmed value>. | TI1a, TI1b |
| I2 | Nothing advances without the user's Confirm. | |
| I3 | Missing data is never treated as good, and never as bad. It is "missing". | |
| I4 | A hard flag blocks <risky action> until cleared by a deliberate two-step action, never from a widget, notification or background task. | |
| I5 | Every reduction is one-way: a later record can't restore a higher level. | |
| I6 | Every loosening of a rule needs <owner>'s separate, explicit sign-off. | (process, not code) |

## 4. Definitions

Settle the small things that otherwise become 25 "interpretations" later (lesson L-09):
- Statistics conventions (sample vs population SD, rounding, units, integer storage).
- Window inclusivity ("the last 7 days" includes today? excludes the current week?).
- What counts as a <session / event / entry>; minimum thresholds.
- Time: the user's time zone, day boundaries, what happens if the device clock is wrong (fail-safe policy, lesson L-15).

## 5. Data sources

### 5.1 Automatic (API / sensors)
Endpoints, auth (credentials only from the Keychain or env, never the command line), sync cadence, plausibility checks, what "not synced yet" looks like.

### 5.2 Manual input
Required vs conditional fields. How long it takes.

### 5.3 One-off import
Format quirks found in the real file, the plausibility rule for bad rows.

## 6. Data model

For each entity: fields split into **synced / manual / computed**. Note where each piece of data lives and why (e.g. "pain is stored on the session log, not the activity, because sync order varies").

**Schema-evolution rule (decide before the first persisted byte, lesson L-16):** <strict vs tolerant decoding; how a new field gets a safe default>.

## 7. Rules engine

"All rules in one pure, framework-free module. 'Now' is injected. Every output carries human-readable reasons."

### 7.1 <Rule family> (plan 6A)
- **Provenance** (adopted apps): found in code (AS-xx) / confirmed by <owner> / new.
- Inputs → output.
- **Precedence:** written as an ordered list. "The first match wins. Each bullet list is OR."
- Missing-data behaviour per input.

### 7.n State machines
Any lifecycle (levels, flags, holds, overrides) is a **table**, not prose (lesson L-06):

| State | Event | Guard | Next state | Effect | Test |
|---|---|---|---|---|---|

Include the overlap, reopen and "unknown / indefinite" cases from the start.

## 8. Plan configuration (seed data as data)

The core table as JSON (or similar), plus **load-time validation** rules.

## 9. Screens

Behaviour and copy rules only, no pixel design. Which actions are possible from which surface (e.g. "never from the widget"). Copy rules for warnings: symptom + action, never a diagnosis.

## 10. Widget and notifications

## 11. Tech stack and architecture

- Layers: pure logic (tested on Linux) → data/sync → app-state (pure, tested) → UI (holds no rules) → app shell (lesson L-13).
- One write path.
- Time and privacy rules: what may leave the device, and in what form.
- CI: a cheap per-push job; expensive platform jobs only on PR, `main` and manual runs (lesson L-17).

## 12. Build phases

| Phase | Deliverable | Done when |
|---|---|---|
| 0 | Data spike + field report | <owner> has seen which fields arrive; SPEC updated to match |
| R | Expert review panel + audit loop | Every Critical/Major decided; rechecks done; audit loop at 0 Critical, 0 Major |
| 1 | Pure logic + tests | Every §13 test ID passes; invariant tests pass; `coverage.py` shows 0 missing |
| 2 | Persistence, import, sync (+ CI, + a way to run it on the real device for your platform) | <observable outcome> |
| 3… | <feature slice> | <one end-to-end scenario a person can try on the device> |

## 13. Acceptance tests

Written as **ID | Input | Expected**, with exact numbers. A named fixture (e.g. "All normal = …") keeps rows short.
- **IDs:** `T001`, `T002` … for examples. `TI1a`, `TI1b` … for invariant tests (I1 = invariant 1).
- **Never renumbered:** new ones take suffixes (`T006b`), and removed ones stay as tombstones ("(Removed in v1.4: …)").
- **Versioned blocks:** new blocks carry the version that added them.
- **Test function names carry the ID:** `test_T047_capsLongRun`, `test_TI1a_neverRaises`. One function may cover several IDs (`test_T047_T048_…`).
- **Coverage:** the playbook's `scripts/coverage.py` maps IDs to tests, writes `TESTS.md` and fails on any missing ID.

### 13.1 <Rule family>
| ID | Input | Expected |
|---|---|---|
| T001 | <fixture + change> | <exact output, with the reason text> |

### 13.I Invariant tests
| ID | Invariant | Property checked |
|---|---|---|
| TI1a | I1 | <e.g. "for every write path except Confirm, the new level ≤ the old level"> |

## 14. Open questions

Point to `DECISIONS.md`. Every question gets an ID there, with the conservative default in use until <owner> answers.

## 15. Out of scope and guardrails

- <Things the app must not do.>
- Never weaken a safety rule without <owner>'s explicit, separate confirmation.
- Never commit real personal data. Fixtures are hand-written.
