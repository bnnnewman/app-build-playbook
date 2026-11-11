---
name: gaps
description: Whole-project gap analysis before a release - specialist reviewers plus loose-end sweeps, each followed by a verifier told to refute it, merged into one ranked list of build clusters with an "if we skip it" table the owner decides from. Use before a first release, before a long pause, or when the owner asks "what's missing" or "is this done".
argument-hint: "[scope]"
---
# Gap analysis

*`${CLAUDE_PLUGIN_ROOT}` is the playbook folder. If you see it literally, find the folder by searching for `PLAYBOOK.md` under `~/.claude/plugins/`, `/opt/app-build-playbook` or `.claude/playbook/`.*

The question is "is this actually finished, for this owner?", asked of the whole project, not of one change. Files:
`work/GAPS/reviews/`. This is a heavy step: say what it costs in usage windows first, and run it early while the
allowance lasts.

## 1. Reviewers and sweeps

Tell the owner which will run and wait for "start". Freeze a commit; all read that.

**Specialists** (pick by size): the core reviewers, the domain pack, and one persona: **"the owner in six months"**
(what will have expired, been forgotten, or stopped working?).

**Loose-end sweeps** (one subagent each):
1. Open and `pending` decisions.
2. Device steps written but never reported done.
3. Markers in the code (TODO, draft, not run, stubs).
4. PLAN vs SPEC vs code: where they disagree.
5. Follow-ups promised in handoffs, PRs and notes.
6. Review items accepted but never built.
7. The end game: what happens with no session to help (expiry dates, renewals, keys, backups, a new device).

## 2. Verify

Each raw report goes to a `playbook:finding-verifier` told to **refute** it against the files. Keep: confirmed,
corrected (with the correction), already decided. Drop: refuted. Expect about half of raw findings to change.

## 3. One list

`work/GAPS/GAP-ANALYSIS.md`: gaps `G-001…`, grouped into **build clusters** `K1…`. For each cluster, in plain words:

| Cluster | Why it matters | If we skip it | When it first bites | Fails safe? | Cost (usage windows) | Could it break the build? | ★ |
|---|---|---|---|---|---|---|---|

Publish a one-page summary he can read on his phone.

## 4. He decides

`/playbook:decide`, one round over the clusters: build now / park / no. Parked gaps go to `IDEAS.md`. Chosen
clusters become builds (`/playbook:coordinate plan` if several).

What this finds that nothing else does: things that are nobody's change. One run's top finding was an expiry date
that nine reviewers reached independently and no per-build audit could have.
