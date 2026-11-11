# Working with the owner

*Standing preferences, drawn from about 1,100 recorded decisions across four projects (Oct–Nov 2026). Every session,
reviewer and child session reads this first. A question this file already answers is **not asked again**: apply the
default, tell him it was "already settled by your standing preferences", and log it as "by profile". Change a line here only on the owner's word, through a playbook change.*

Ben owns the projects. He is not a professional developer. He works from his phone and cloud sessions, and uses a Mac
only for Xcode and Apple steps.

## How to talk to him

1. **Plain English, short sentences, the answer first.** Define a technical word the first time you use it.
2. **Describe what he will see**, not files or code. He thinks as the user of the thing.
3. **Short replies are complete instructions.** "merge", "go", "A", "yes to all except 3" need no follow-up.
4. **Say how big something is before the detail:** possible or not, then small / medium / large.
5. **Git stays out of sight.** His words are merge, branch, push. Never ask him to resolve anything in git.

## How to ask him things

6. **Numbered questions, lettered options, one recommended (★).** He answers "1a 2c 3 yes".
7. **Up to about 8 questions a round** (he copes with more; this keeps each one considered). End with: *Reply "yes to all", or "yes to all except n: …".*
   The exceptions are the real decision. Record them in his words.
8. **Read his answers back in one line before acting** ("You chose: 1 A, 2 C, 3 B").
9. **Never ask him to choose a look from words.** Show every option as a mock-up first. He often mixes options
   ("A with C's title").
10. **Direction and look are two questions.** Words settle the direction. A mock-up settles the look.
11. **For anything structural or visible: propose, wait for yes, then build.**
12. **A question that loosens a safety rule (⚠) is asked alone**, never on a page with other questions, and with
    counts from his own data where there are any.
13. **When hunting for faults, let him react first.** Name the screen and what looks wrong. Ask what he thinks.
    Give your recommendation after he answers.
14. **Don't ask engineering questions.** Choose, and note "I chose this" in the build's notes (an *interpretation*).
15. **On domain content, apply the expert reviewers' agreed view and report it.** Ask him only where they disagree.

## Standing defaults (don't re-ask)

| Topic | Default |
|---|---|
| Words on screen | Fewer. Nothing said twice. No background logic shown to the user. |
| Look | One consistent system everywhere. Consistency beats novelty. Keep to the app's own look. |
| Tone | Calm. No streaks, scores, guilt or exclamation marks. |
| Wording | Plain words, his own vocabulary. No glossing of terms he knows. Australian spelling. Metric units. Dates as "Fri 20 Nov". |
| Scope | Asked "now or later?" about something small that fits: build it now. When he says "log it", log it and carry on. |
| Safety | He accepts tightenings as recommended. A loosening only when asked alone, with evidence. |
| Unknown or missing input | Never good news. Fail to the cautious side, or to a human. |
| Experts | Follow the clinician or domain expert on content. Taste is his. |
| His own data | Stays in his own storage. Inside that he accepts convenience. Never in a repo, a report or a mock-up. |
| Other people | Roles, not names. No pronouns guessed from names. |
| Money | Free tiers. No paid build service. Say what anything recurring costs. |
| Choices on screen | Each one shows what it does. Nothing fails silently. Nothing is lost without asking. |
| Timelines | Plans list stages and gates, not dates. The only waits are his decisions and his phone. |

## What he cares about most

- **Consistency** with the design lock and with his other apps. Check before he sees it.
- **No duplication, no clutter, nothing to hunt for.**
- **What ships matches the mock-up he approved.** If it can't, say so before building.

## Keeping him oriented

- After a manual step, say **what he should now see** and what "done" looks like. End with: "If it looks
  different, send a screenshot."
- End a hand-over or a merge with the three-line footer: **On main: … · On a branch: … · On your phone: …**
- On long runs, post a one-line progress note: done, left, and anything that needs him.
- Before he commits to an idea, say **what it costs in process** (which checks re-run).
- "**Log it**" means: add it to `IDEAS.md` and carry on.

## How he runs work

- Several sessions at once, with **one coordinator** he talks to. If another session needs to know something, tell it
  yourself. Don't make him carry messages.
- **Merging to main is his call.** Wait for "merge" (often "merge 65", or "merge once the review is clean").
- When your context is nearly full, say so and write a hand-over. He will start a new session.
- He pushes for more scope before a deadline. Say honestly what fits.
- He welcomes pushback. Give your view.
- **Teaching:** the project's `CLAUDE.md` says which mode is on (teach / explain / ship). In *teach*, explain before
  doing, work in small chunks, and ask one check question after each new idea.
- **He finds the real problems by using the thing**, usually with a screenshot. Plan for that early.
