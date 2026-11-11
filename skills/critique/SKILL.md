---
name: critique
description: Design critique of the product (not a code review) - workflow, features, visual cleanliness and how tight the design lock is, judged against benchmark apps people already use, with a scorecard. Ends in proposals the owner picks from, never in code. Use when the owner asks for a critique of the app, a journey, a screen or the lock, and for every new screen a build adds.
argument-hint: "app | journey <flow> | screen <name> | lock"
---
# Design critique

*`${CLAUDE_PLUGIN_ROOT}` is the playbook folder. If you see it literally, find the folder by searching for `PLAYBOOK.md` under `~/.claude/plugins/`, `/opt/app-build-playbook` or `.claude/playbook/`.*

Judge the product as a product designer would, against the best apps people use every day. The question is always:
**where can this be tighter, calmer, faster or more useful for this person, in the moment they use it?**

Not a code review. Read code only to confirm what a screen really shows.

## Read first

1. `${CLAUDE_PLUGIN_ROOT}/OWNER.md` and the project `CLAUDE.md` (who it's for, when it's used, what it is not).
2. `design/STYLE-GUIDE.md` (note its version), `design/FLOW-MAP.md`, `design/PAGE-INVENTORY.md`, the newest mock-ups.
3. **What's decided:** `DECISIONS.md`, the ledger, earlier reports in `design/critiques/`. Don't re-raise a settled
   point. If a decision looks wrong, say so and label it **"Reopens D-…"** with new evidence.
4. `design/BENCHMARKS.md`: the comparison apps (start it from `${CLAUDE_PLUGIN_ROOT}/templates/BENCHMARKS.md`).

## Hard limits

- **Safety first:** safety > accessibility > the owner's decisions > everyday use > the rest. Never propose hiding,
  shrinking, greying, softening or moving a safety line behind a tap.
- **Patterns, not looks.** Take what a benchmark does (fewer taps, a better default). Never its look, names or brand.
- **Check before you claim.** Confirm what an app does now (store page, help pages). Mark each comparison *checked*
  with a link, or *from memory*. Never invent tap counts.
- Made-up data only. No code.

## Four lenses

1. **Workflow.** Walk each journey from the real starting moment. Count taps, screens, decisions, typed fields. Is
   the commonest case the fastest? Are exits, undo and "can't save" calm?
2. **Features.** Missing; not earning its place; right but the wrong size for how often it's used. Say who benefits
   and when.
3. **Cleanliness.** In two seconds, what is this screen for and what do I do next? **Anything said twice. Background
   logic shown to the user.** Same page type, same look. Large text and dark mode look intended.
4. **The lock itself.** Too loose (screens drift)? Too tight? Gaps? Hard to apply? What could the scan test check?

For `app`: after your own pass, give one fresh subagent the product summary and the lenses but **not your
findings**; merge, and mark what both raised.

## Scorecard (0–4 each; one line of reason)

You can tell what's going on · Speaks the user's language · Easy to back out · Consistent · Prevents mistakes ·
Shows rather than makes you remember · Fast for the common case · Calm and uncluttered · Helps when something goes
wrong · Explains itself only where needed. Compare with the last critique of the same scope.

## Report

In chat first, short. Then `design/critiques/<scope>-<date>.md`: the top five; findings ranked, each with ID
`DC-<date>-n`, lens, type (Tighten / Improve / Add / Drop / Lock), where, what's wrong for the user in that moment,
what benchmarks do, a proposal small enough to mock, priority P1–P3, size, ⚠ if it touches safety wording; where the
product is already better; the scorecard.

**Next:** the owner picks which findings go to `/playbook:mock`. Record with `/playbook:decide`. Build nothing.

*The scored-review idea is adapted from pbakaus/impeccable (Apache 2.0) and pjt222/agent-almanac (MIT); see
`THIRD-PARTY-NOTICES.md`.*
