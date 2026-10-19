# <App name>: the plan

*Version 1.0 · <date> · Written by <owner> with Claude. Revisions are logged in `CHANGELOG.md`.*

> **For Claude Code.** This is the domain truth: what the app is for and the rules it serves, in plain language. It must be usable **by hand, with no app** (see §8). `SPEC.md` says how to turn it into software. If the two ever disagree, flag it and ask <owner>. Don't guess.
>
> **One home for each rule.** This document says *what* a rule means and *why*. The SPEC holds the exact algorithm, numbers and tests and points back here ("SPEC §7.2 (plan 6B)"). Don't restate a rule's numbers in both places (lesson L-04).

---

## 0. If you read nothing else

<One screen. The 3–6 rules that matter most, the normal weekly/daily shape, and the core decision in one line. People read this; they skim the rest.>

## 1. Who this is for, and what the data says

| Fact | Value | Source |
|---|---|---|
| <user/context fact> | <value> | <where it came from: export, interview, measurement> |

**What the real data says.** <Summarise real data the owner already has (exports, history). Facts, not hopes.>

**Recommended expert check.** <Any one-off real-world check worth doing (e.g. an appointment, a soil test).>

## 2. Principles (the invariants in plain words)

<Rules that must never break. Each one becomes an invariant in SPEC §3. Example shape:>
1. <"Never increase X by more than Y.">
2. <"Missing information is never treated as good news.">
3. <"The app recommends; <owner> decides.">

## 3. – 5. Static configuration

<The fixed parts of the domain in human form: schedules, categories, zones, catalogues, routines. Tables beat prose.>

## 6. The decision rules

<One subsection per rule family (6A, 6B, …). For each:>
### 6A. <Rule family>
- **What it decides:** …
- **Inputs:** …
- **Rule:** <plain words + a table if there is more than one case>
- **Order when rules collide:** <first match wins / lowest wins / strictest wins>
- **What happens if an input is missing:** …
- **Provenance** (adopted apps only): found in code (AS-xx) / confirmed by <owner> / new.

## 7. The core data table

<The main table the rules move through (a block of weeks, a care calendar, a level ladder…).>

## 8. Doing it by hand

<Paper logs or a checklist so the domain works with no app. This keeps the app's lateness from ever blocking the owner (lesson L-11).>

## 9. Still open

- [ ] <Open question, who decides, by when>
