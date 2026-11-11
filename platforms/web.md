# Platform notes: web tools and pages

For a page on a website, a dashboard, or a published artifact.

## The "device" is the live link

Try-out means: open it in light and dark, at desktop width and phone width (about 390 px), with the keyboard only,
and run an accessibility scan. Headless browser checks in the session catch errors; the owner's look catches the
rest.

## Preview, then trial, then live

1. A **private preview** the owner looks at.
2. For anything that **writes**: a **trial copy with made-up data** and its own empty store, that he actually uses.
   One trial page found what ten rounds of document review could not.
3. **Go-live is one named decision** (`/playbook:operate go-live`). A check refuses to publish a test or trial build.

## What is live?

Git doesn't say, when publishing is a paste or an upload. So:
- a **publish log** (`STATUS.md` and `docs/owner/MAINTAINING.md`): date, version, commit, where, who;
- **stamp the built file** with the version and date, so the live page can be matched to its source;
- commit the built file, never edit it by hand, and have the build refuse to run if it would produce a broken page.

## Data about people

If the page shows anything about a real person:
- **Real records never reach the browser** except the one person's own, after a check on the server side.
- An identifier that can be guessed needs limits on guessing, and one message for "no match" (don't reveal which
  part was wrong).
- **Pretend data only** while building, in a parallel test copy with a reserved ID range, switched by a setting.
- **Copy the real field names and values from the source** on day one. A spelling difference between pretend and
  real data once risked showing one person's page to another.
- Anything unknown, blank, duplicated or out of scope shows "contact us", never a guess.
- Dates: the source's time zone, the owner's time zone, daylight saving. Test "today" at the boundaries.

## When someone else builds part of it

Write an **interface agreement** (`templates/INTERFACE-AGREEMENT.md`): access, inputs, the rules in order, result
shapes, time, privacy limits, decisions still needed, and acceptance tests they run. If the rules will live in two
places, the acceptance tests are the only guard: make them runnable.

## Other people use it

- **A user-testing round** (`templates/TEST-SCRIPT.md`): scripted steps per role, a practice copy, a problem log; a
  read-through first, a try-out second. Feedback by email needs no account.
- One document per reader: the README for colleagues, the interface agreement for builders, `CLAUDE.md` for
  sessions. Roles, never names.
- Gates with a named decider (by role) and a date; a "stop if" line.

## No CI?

Fine, on purpose: record "no CI" and the pre-push checks that replace it (tests, render check, coverage,
`git status`). Say what that weakens.
