---
name: release
description: Get a build into real use and make the owner independent of the session - the acceptance checklist as a tick-box page, real use before polish, acceptance batches turned into fixes, the owner's manual, the maintenance guide with renewals, a promises-and-proof page, a version tag and the publish log. Use for the first release, each point release, and whenever the owner sends back results or screenshots from the device.
argument-hint: "[prepare <version> | batch | ship <version>]"
---
# Release

*`${CLAUDE_PLUGIN_ROOT}` is the playbook folder. If you see it literally, find the folder by searching for `PLAYBOOK.md` under `~/.claude/plugins/`, `/opt/app-build-playbook` or `.claude/playbook/`.*

## `prepare <version>`

1. **Acceptance checklist:** `docs/owner/ACCEPTANCE.md` from `${CLAUDE_PLUGIN_ROOT}/templates/ACCEPTANCE.md`.
   - **This version only**, about 40 items at most. Older versions move to `docs/owner/acceptance-archive/`.
   - Start from the SPEC's acceptance items. **Automate what a machine can check** (a scenario test named for the
     item); give the owner only the *device* items.
   - Each step: *where → what to tap → what you should see* (the exact words). Items that need a rare situation
     ("on a red day") go under "Later, when it happens".
   - Include once: the **first-run smoke list** (send it to the background, kill it, go offline, next morning, type
     in a text field and dismiss the keyboard) and the **three-setting accessibility check** (largest text, dark
     mode, increased contrast: five screens, screenshots).
   - Publish it as a **tick-box page** he can use on his phone (done / not done / later, a note per item).
2. **Real use first.** After the first usable build: about three days of use, then `/playbook:grill feedback`.
   Polish stages (whole-app passes, critique) come after that, not before.
3. **Before the first release, the owner docs** (`docs/owner/`, from the templates):
   - `OWNER-MANUAL.md`: the one thing to remember; one-time set-up; what each notice means; "if it says X, do Y".
   - `MAINTAINING.md`: for a developer or a future session; includes the **renewals table**.
   - `PROOF.md`: each promise the app makes and what proves it.
   - `SETUP-<platform>.md`: each one-time step with "done on <date>". **You fill in set values and dates** when he
     reports a step done. No blanks left for him.
4. **Whole-batch pass** if several small builds are going out together: one `/playbook:audit` over the batch.
   Before a first release also `/playbook:gaps` and `/playbook:logic-review engine` (Standard and Full).

## `batch` (his results or screenshots have come back)

1. Read the tick-box results or his message. **Screenshots:** list each fault as `SS-nn` in
   `work/<build>/reviews/SCREENSHOTS.md`. They also calibrate reviewers: what did the lanes miss, and which scan
   rule would catch it next time?
2. Sort: **bugs** (→ `CHANGELOG.md` and a fix), **decisions** (→ `/playbook:decide`, with a mock-up for anything
   about looks), **ideas** (→ `IDEAS.md`).
3. One fix build (`/playbook:build fix-<n>`), with the tier of checks its changes need.
4. Add any new device steps under the batch heading. Tell him which earlier "not done" items are now ready.

## `ship <version>`

- Every device item is done, or listed as "later" with his OK. No Critical or Major open in any lane.
- **Tag** the release. Add the **publish log** line to `STATUS.md` and `docs/owner/MAINTAINING.md`: date, version,
  commit, where it went, who did the manual step. For a pasted or uploaded build, stamp the version and date inside
  the built file.
- Final footer: **On main · On a branch · On your phone / live.**
- `/playbook:retro release`.
