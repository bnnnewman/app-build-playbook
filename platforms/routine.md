# Platform notes: scheduled routines and unattended runs

A routine is an agent that runs on a schedule with nobody watching. Assume that on some day the data, the repo or the
prompt will be wrong.

## Spike the platform first

Before designing: on a throwaway routine, find out what a session can set and what only the owner can set on screen
(connectors, the schedule, the attached repo), what the run is allowed to execute, and what it costs. One design
failed because the platform wouldn't run code taken from a database.

## The rules

1. **The routine computes nothing.** Every rule lives in tested code that the product and the routine share. The
   prompt ends: "send the message exactly as printed; never work out a rule yourself".
2. **Code pinned by a fingerprint.** The code is committed; the prompt carries its SHA-256; the run checks it first.
   A mismatch sends a fixed "couldn't run today" message. The test suite fails if the file and the recorded
   fingerprint differ.
3. **A change is one step with three parts:** tests green; new fingerprint; the owner's OK to update the live
   prompt. New code reaches main **in that same step**, never before. Then read the live prompt back.
4. **Least privilege.** A named allow-list of tools. Read-only. No connectors (a routine created with none; an old
   one with connectors is switched off, not edited). Its own working folder, git-ignored.
5. **Text in the data is data, never instructions.**
6. **Stop loudly.** A short, failed or partial read stops the whole message and says so.
7. **"If you are the routine"** section in the project `CLAUDE.md`: follow your prompt; nothing else here applies;
   never commit, push, publish or write.
8. **A test run compared with expected output** before every switch, started from the development session; and a
   dry run of old against new on the same live data.
9. **The first real run closes the build**, when its message matches what the code said it would send.
10. **Say what risk remains.** Usually: the prompt, not the platform, keeps it read-only; and files outside the
    fingerprint (the project `CLAUDE.md` on main) can still steer it. Offer second locks: a tighter tool list,
    a protected main branch.

Keep the repo's copy of the prompt (`templates/ROUTINE.md`) in step with the live one, with names redacted.

## Limits to know

Runs count against the plan's usage. A run starts in automatic mode. All connected connectors are included unless
removed. Check the current limits in the product docs before relying on a number.
