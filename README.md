# App build playbook

My process for building apps with Claude Code. It runs from first idea, through design docs, a real-data spike, an expert review panel and safety-logic audit loops, to phased builds with handoffs. Retros at the end of each phase and project make the process better each time.

A one-page visual of the stages is in [`docs/stage-map.html`](docs/stage-map.html) (also published as a private Claude artifact: https://claude.ai/artifact/78qq2AYskPcS2u81k5QxSL).

It comes in two forms in one repo:
- **A readable playbook:** [`PLAYBOOK.md`](PLAYBOOK.md) explains every stage, gate and convention, and why.
- **A Claude Code plugin:** `/playbook:*` skills run each stage, plus core review agents, templates and domain panel packs.

The first version was mined from the Running-App project (Oct 2026). See [`examples/running-app/CASE-STUDY.md`](examples/running-app/CASE-STUDY.md) for what happened there, and [`LESSONS.md`](LESSONS.md) for what changed because of it.

---

## Commands

| Command | Stage | What it does |
|---|---|---|
| `/playbook:start [new\|adopt]` | 0 | Set up a new app, or adopt a half-built one (baseline, secret scan, `AS-IS.md`, recovered docs); sizes the process (Light / Standard / Full) |
| `/playbook:status` | any | Where are we, what's open, what's next |
| `/playbook:design [plan\|spec\|revise …]` | 1–2 | Write or revise PLAN.md and SPEC.md (invariants, definitions, state tables, tests) |
| `/playbook:spike [source]` | 3 | Real-data field coverage, before review |
| `/playbook:panel [pack]` | 4 | Expert review panel: tailor, run in parallel, synthesise, owner decides, apply |
| `/playbook:audit [R\|A\|P<n>]` | 5 / 6 | Safety-logic audit loop to 0 Critical / 0 Major |
| `/playbook:decide` | any | Batch questions to the owner; record answers |
| `/playbook:phase-start <n>` | 6 | Handoff → questions → phase plan → build step by step |
| `/playbook:phase-close <n\|A>` | 6 | Freeze → audit + code review → fix → CI → device → PR → handoff |
| `/playbook:retro [stage]` | 7 | Numbers, lessons, and playbook improvements |

**Also:** `scripts/coverage.py` maps SPEC test IDs to tests and writes `TESTS.md`.

**Agents** (namespaced `playbook:<name>`):
- `logic-auditor`
- `adherence-reviewer`
- `data-reviewer`
- `privacy-reviewer`

**Panel packs** (copied into a project and tailored):
- `panels/health-fitness/` (used on Running-App)
- `panels/plant-care/` (draft, for Flobbadob)

---

## Install

### On your own computer: every project (Claude Code CLI or desktop)

In Claude Code:

```
/plugin marketplace add bnnnewman/app-build-playbook
/plugin install playbook@bnnnewman-playbook
```

Restart Claude Code.

**First run on a project.**
- For a half-built app (like Flobbadob): open Claude Code in the app's folder and run `/playbook:start adopt`.
- For a new app: use an empty folder and `/playbook:start new`.

After that, `/playbook:status` always tells you the next command. If the `/playbook:` commands don't appear, use the vendor script below instead.

**To update later:**

```
/plugin marketplace update bnnnewman-playbook
/plugin update playbook@bnnnewman-playbook
```

### In every cloud session (claude.ai/code)

Cloud sessions start from a fresh container, so the cloud **environment** installs the playbook each time a session starts. Set it up once and every session in that environment has `/playbook:*`.

1. **Add the setup script.**
   - In any cloud session, open the cloud environment menu in the title bar, then **Edit**.
   - Paste everything below the `# ---` line of [`scripts/cloud-setup.sh`](scripts/cloud-setup.sh) into **Setup script**, then save.
   - The repo is public, so no token is needed. (If you ever make it private again, add a read-only fine-grained token as the environment variable `PLAYBOOK_GITHUB_TOKEN`, and the script will use it.)
2. **Check it.** Start a **new** session and type `/playbook:status`.
   - If the command is there, you're done.
   - If not, open the setup log, find the failing line, and bring it to a session that has this repo.

Every new session clones the latest playbook, so improvements reach cloud sessions automatically.

### Per project, without installing (fallback)

If a session can't install plugins, copy (vendor) the playbook into the project instead:

```bash
# from a clone of this repo
./scripts/vendor.sh /path/to/your-app
```

This copies the skills, agents, templates and scripts into `your-app/.claude/`, where every session, local or cloud, picks them up.
- Vendored commands drop the namespace: `/playbook-status` instead of `/playbook:status`. They can sit alongside an installed plugin.
- Re-run the script to update, and commit the result in the app repo.
- `.claude/playbook/` is replaced on every run, so don't edit files there. Project-specific agents in `.claude/agents/` are never overwritten.
- If a session's safety check won't run scripts from another repo, ask Claude to do the same copy with `cp` and `sed`, following `vendor.sh` step by step. Then check that `grep -rn 'CLAUDE_PLUGIN_ROOT\|/playbook:' .claude/` finds nothing.

---

## Improving the playbook

This is meant to grow with every app:
1. **Every phase close** ends with a short `/playbook:retro`: the numbers and one question to you.
2. **At project end,** `/playbook:retro project` turns those into new lessons in `LESSONS.md` (Keep / Change, with evidence) and a block in `METRICS.md`. It then proposes edits to this repo.
3. **Check the numbers** against the targets in `METRICS.md`. That shows whether the changes helped.
4. **Changes** land as PRs on this repo. Bump the version in `.claude-plugin/plugin.json` and add a `CHANGELOG.md` entry. Each project records which playbook version it used.
5. **Panel packs grow.** After each project, promote its tailored reviewers back into `panels/<domain>/`.

See [`.claude/CLAUDE.md`](.claude/CLAUDE.md) for the rules on editing the playbook itself.
