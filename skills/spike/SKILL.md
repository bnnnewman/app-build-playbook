---
name: spike
description: Run the playbook data spike - pull the owner's real data from each external source, report field coverage and fill rates (never values), find format quirks, and feed the findings back into the SPEC before expert review. Use at stage 3, or whenever a new data source is added.
argument-hint: "[source name]"
---
# Data spike

*`${CLAUDE_PLUGIN_ROOT}` is the playbook folder. If you see it literally, find the folder by searching for `PLAYBOOK.md` under `~/.claude/plugins/` or `.claude/playbook/`.*

Read `${CLAUDE_PLUGIN_ROOT}/PLAYBOOK.md` stage 3 and lessons L-01 and L-28. The spike comes **before** the expert panel. Rules built on fields that never arrive waste whole audit loops.

Run one spike per source. Name the files after the source (`spikes/<source>_spike.py`, `spikes/<source>-field-report.md`). Findings use IDs `S-nn`.

1. **List the fields the rules depend on.** Grep SPEC §5 and §7 for every input, and put them in a table: field, which SPEC section needs it, and why.
2. **Credentials.**
   - Read them from an environment variable, a secret the environment injects, or the Keychain. Never from the command line, and never echoed.
   - Ask the owner how the credential is provided here before asking them for a key.
3. **Write the spike script** (prefer the standard library only):
   - Pull a long window: a year if available.
   - Print **every field returned**, with its type and non-null count. Mark the fields the rules depend on.
   - Check any streams or sub-resources the rules need.
   - Write raw output only into a git-ignored folder (`spikes/out/`). Check `.gitignore` **before** the first run.
   - **If this session can't reach the network,** give the owner the script and the exact command to run it on their machine, and ask them to send back only the printed counts.
4. **Export files** (CSV etc.): report every column with its fill rate, the format quirks (quoting, thousands separators, empty markers, stray characters) and implausible rows. Implausible rows become test data and a plausibility rule.
5. **Write the field report** from `${CLAUDE_PLUGIN_ROOT}/templates/SPIKE-REPORT.md`:
   - counts and fill rates only;
   - **no personal values**;
   - include the redaction header comment.
   - Put practical snags (auth quirks, rate limits, blocked user agents) in its "Practical snags" section.
6. **Report back to the owner before touching the data layer.** Say plainly which needed fields never arrive, which are sparse, and what that means for the rules.
7. **Feed back.** Run `/playbook:design revise spike`:
   - rewrite rules whose inputs don't arrive (field missing ≠ bad);
   - add baselines and fallbacks;
   - note thresholds that need a **replay over real history** later (counts only).
   - Mark the effect of each change: Tightens / Loosens ⚠ / Neutral.
8. **If the panel has already run,** re-run the `data-reviewer` (or the domain's data specialist) with the field report as a recheck before the audit loop.
9. Commit the script and the redacted report. Never commit the raw output.
