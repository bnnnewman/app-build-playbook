# <Name>: the brief

*Mini size: this one file is the plan, the rules, the decisions and the checks. Fill it in about 20 minutes. It
grows in place. If the grow check at the bottom ever says yes, split it into the full documents.*

## 1. What and why
<Name. One sentence on what it does. One on what it does **not** do.>

## 2. Who uses it, and who must agree
| Role (never a name) | Uses it to… | Must sign off? |
|---|---|---|

## 3. The worst it could get wrong
- Does it show or store data about real people? <yes / no>
- Could one person see another's data? <yes / no>
- Could a wrong answer cost money or a deadline, or affect health or safety? <yes / no>

**Any yes: stop. This is not Mini.** Run `/playbook:start` again at Standard, with a privacy reviewer.

## 4. Data: pretend and real
- Where the real data lives: <…>
- **Field names and values, copied from the source** (not typed from memory): <…>
- Pretend data only: <the made-up set, and any reserved test range>
- What must never reach the page or the repo: <…>

## 5. Rules that must always hold
| # | Rule, in plain words | The test case that shows it |
|---|---|---|
| 1 | <e.g. "Anything we don't recognise shows 'contact us', never a guess."> | |

## 6. Decisions
| ID | Date | Decision | Why | Who decided |
|---|---|---|---|---|
| D-01 | | | | |

## 7. Waiting on
| Question | Who decides (role) | By when |
|---|---|---|

## 8. Checks before publishing
- [ ] It builds.
- [ ] Each test case in section 5 shows the right thing.
- [ ] Phone width; keyboard only; an accessibility scan.
- [ ] Links open. Wording read aloud.
- [ ] Dates and times right for the owner's time zone, including daylight saving.
- [ ] No real data or personal names anywhere.
- [ ] One review pass done; findings listed in section 10.

## 9. How to publish, and what is live
1. <numbered steps; who has permission>

| Date | Version / commit | Where | Who |
|---|---|---|---|

## 10. Feedback and findings
| Date | From (role) or review | What | What changed |
|---|---|---|---|

## 11. Hand-over
Where the latest work is: <"main holds the latest work">. How to change the three likeliest things: <…>.
Who to ask (by role): <…>. Words explained: <…>.

---
**Grow check** (asked at every session start): has an answer in section 3 changed? Is there now a second system, a
second builder, or a date set by someone else? **If yes, move up a size.**
