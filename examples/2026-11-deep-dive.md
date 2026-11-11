# The November 2026 deep dive: why version 2 looks the way it does

*Nine readers went through everything built between 19 Oct and 11 Nov 2026 and reported on what the owner actually
does and decides. This is the summary. No personal data, health values or third-party names are included. Projects:
**First Light** (a training app; 1,562 commits and 86 PRs in 23 days), **Flobbadob** (a plant-care app, adopted onto
the playbook), **a work policy tracker** (a published page with a weekly routine, adopted), and **a work enrolment
checklist** (a web page built with no playbook).*

## The headline

Playbook v1.1 described how the owner worked on 19 October. In the three weeks after, he invented a better process
across four projects, and **none of it flowed back**: one retro in 60 audit loops; 16 proposed lessons that never
arrived; three projects that each claimed the same lesson numbers.

## What he does that v1 didn't know about

| What | Evidence | Now in |
|---|---|---|
| Runs a **coordinator** session with child sessions per work package | Up to 207 commits a day; broke on ID, section and integration collisions | `/playbook:coordinate` |
| Works in **builds with parallel review lanes**, not phases | A six-step "every build, every session" rule written after he saw drift | `/playbook:build`, `/playbook:close` |
| Decides every look from a **mock-up**, and mixes options | 82 decisions cite a mock-up page; "A with C's title" | `/playbook:mock` |
| Built a whole **design lock** after the app existed | 480 design decisions; 853 copy findings; a 1,347-line style guide | `/playbook:design`, stage 4 |
| **Tiers** the checks to the change | "Do we need to restart audits every time I bring new ideas?" | `/playbook:audit` tiers |
| Finds the real faults by **using it, with screenshots** | 4 screenshots, 32 faults a 12-reviewer panel missed | `/playbook:release` |
| Keeps an **ideas inbox** and ships small releases; a freeze lasted a day | 8 idea builds in two weeks | `/playbook:ideas` |
| **Operates** a live tool weekly, with a scheduled routine | A third of one project was running it | `/playbook:operate`, `platforms/routine.md` |
| Asks for **research and options** before a lasting choice | Three options papers, each decided in one step | `/playbook:options` |
| Plans for **life without a session** | An owner's manual, a renewals table, an in-app expiry warning | `/playbook:release` owner docs |
| Wants to be **taught** as he builds | Written by him before the playbook existed; the playbook never mentioned it | Teaching mode |

## How he decides (about 1,100 recorded decisions)

- Takes the recommendation **about 90% of the time**, usually in bulk, with one or two named exceptions. The
  exceptions carry the real content.
- Overrides in two directions only: **"build it now, not later"**, and **taste on a picture** (always toward fewer
  words, no duplication, one consistent look).
- Never overrides engineering choices, a tightening of a safety rule, expert consensus on domain content, or
  accessibility floors.
- Loosens a safety rule only when asked alone and shown counts from his own data.
- Reversals came from three causes: approving a batch without seeing one item's effect; first real use; a later
  session not knowing an earlier decision. Never from changing his mind on a principle.
- About eleven standing preferences were re-asked as if new, many times each.

→ `OWNER.md`, and the grill's answer format.

## What it cost when things were missing

| Missing | Cost |
|---|---|
| A design stage before building | 853 copy findings; 8 Critical and 134 Major on a "finished" app |
| A way to compile screens in the cloud | 7 broken builds reaching the phone's build service |
| A readable decision log | 405 KB, out of order; two reviews re-raised refused ideas; 43 "pending" never closed |
| A loop exit other than "fix and recheck" | 18 audit rounds on one small feature |
| A size for small tools | A prototype grew into a programme handling personal data with no plan, tests or decision log |
| A spike of real field names | A spelling difference that could have shown the wrong person's page, found on day 9 |
| A place for what projects learn | 16 lessons lost; this rebuild |

## What worked and stays

Spike first. Narrow re-audits. Loop breakers. Conservative defaults while waiting. Reviewers that never edit.
"Merge N". Regression tests named for findings. Handoffs. No paid CI. And being grilled.

## Measured against v1's own targets

| Target | First Light (after v1) | Flobbadob | Policy tracker |
|---|---|---|---|
| Design audit loop ≤ 5 rounds | Median 3; three loops over (8, 7, 6+3) | 4 | 6, then 18 on one feature |
| First code audit: 0 Critical | Met in the safety lane; Criticals moved to compile and code review | Met (0 Critical, 10 Major) | Met |
| No CI exhaustion | Met (paid CI off; free build hours) | Met | CI never started; switched off |
| On the device early | Met from day 3 | Met | Preview and trial pages |

## What is still unproven

- Whether the plugin's session-start hook runs in cloud sessions (the set-up script covers it either way).
- The Mini size and the grow check have not been used on a real project yet.
- Flobbadob's design phase stopped at round-0 mock-ups, so the design track's later steps rest on First Light alone.
- Accessibility has only ever been checked by reading, never on a device.
