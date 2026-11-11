# Operating <project>

*How the live tool is run, as distinct from built.*

**The record of authority:** <the register / the minutes / the source system>. It always wins over this tool.

## The update routine (about 5 minutes)
1. The owner says what changed.
2. At most five questions, only where the record would otherwise be wrong.
3. A three-line summary and one "OK?". Nothing is written until yes.
4. Writes go through `<the write helper>`: pinned to the version read; named fields with expected old values; read
   back ("10 of 10").

## Writing safely
- Other sessions may be writing too. Read the latest, merge, never overwrite.
- Never replace a whole nested object. Rehearse a bulk change on a copy.
- Real data is never committed. Exports go to <an absolute scratch path>. Run the names scan before publishing.

## Going live
One decision, asked alone: publish + merge + <routine fingerprint> + one test run. Preview first; for anything that
writes, a trial copy with made-up data first.

## Published
| Date | Version | What changed for the owner | Read back |
|---|---|---|---|

## Open live-data items (only when the owner brings them)
| Item | Waiting for | Since |
|---|---|---|

## Dated tasks only the owner can do
| Task | By | Reminder set? |
|---|---|---|

## How to run this without the session
<A one-page version for a successor.>
