# App build playbook

How I build apps and tools with Claude Code, written down so every session works the same way.

It is two things in one repo:
- **Something to read:** [`PLAYBOOK.md`](PLAYBOOK.md) (the process and why), [`GLOSSARY.md`](GLOSSARY.md) (plain
  words), [`OWNER.md`](OWNER.md) (how to work with me).
- **A Claude Code plugin:** skills that run each step, reviewers, templates and checks.

Version 2 was rebuilt in November 2026 from four projects and about 1,100 recorded decisions. What changed and why:
[`examples/2026-11-deep-dive.md`](examples/2026-11-deep-dive.md).

---

## You don't need to remember commands

Say what you want. The session picks the right step. These are the things worth knowing:

| Say this | What happens |
|---|---|
| **"Where are we?"** | A short status: what's merged, what's waiting for you, what's on your phone, the one next step. |
| **"Start a new app"** / **"adopt this project"** | Sets it up: asks what could go wrong, sizes the process, picks a teaching mode. |
| **"Grill me on this"** | A round of numbered questions with a recommendation each. Answer "yes to all except 3: b". |
| **"Show me options"** | A mock-up page with A / B / C on made-up data. Pick one, or mix them. |
| **"Log it"** | Adds the idea to the list and carries on. Nothing gets built yet. |
| **"Merge 65"** | Puts that finished change into the real project. Nothing reaches it until you say so. |
| **"Is that done?"** (with a screenshot) | Tells you what you should be seeing, and what "done" looks like. |
| **"What are my options for…"** | Researches it, compares 3–5 ways, recommends one, and answers your doubt directly. |
| **"Hand off to a new session"** | Writes a hand-over so a fresh session carries on. |
| **"Tidy this repo"** | Proposes a clean-up. Changes nothing until you agree. |

Three choices are made once per project and can change later:
- **Size:** Mini (a few days' tool, one file) · Light · Standard · Full (health, safety, money).
- **Type:** a phone app · a web tool or page · a tool with a scheduled routine.
- **Teaching mode:** teach me as we go · explain decisions · just ship.

A picture of the stages: [`docs/stage-map.html`](docs/stage-map.html).

### What you'll be asked, from start to first release (a Standard phone app)

| When | What you do |
|---|---|
| Start | One round of questions: what it's for, what could go wrong, how you want to work |
| Plan and spec | Two or three rounds: "yes to all except…" |
| Design | Say which apps you like; pick from one mock-up page; say "lock it" |
| Expert panel | Say "start"; then one or two rounds on what they found. Anything that loosens safety is asked alone |
| Each build | Agree the scope; pick a mock-up if it's visible; "words fine"; "merge N"; one optional question: anything slow, confusing or great? |
| Release | Tick through a checklist on your phone; send screenshots of anything odd |

That's it. Everything else is the session's job.

---

## All the skills

| Skill | When |
|---|---|
| `start` · `status` | Set a project up · say where it stands |
| `plan` · `spec` · `spike` | Write what it's for · the exact rules and tests · check what's really there |
| `design` · `mock` · `critique` · `art` | The look, before the first screen · mock-ups to choose from · a design critique · drawn art |
| `panel` · `audit` | Expert reviewers · the safety check, sized to the change |
| `grill` · `decide` · `options` | Ask me things · clear what's waiting on me · research and options |
| `build` · `close` · `coordinate` | One build · its review lanes and "merge N" · running several sessions |
| `release` · `ideas` · `gaps` · `logic-review` · `operate` | Acceptance on my phone · the ideas list · what's missing · do the rules add up · run a live tool |
| `retro` · `handoff` · `tidy` | Five-minute retro that feeds this repo · hand-over · housekeeping |

Invoked as `/playbook:<name>`. Seven reviewers ship with it, each looking for one kind of problem (safety and
logic, real-life use, data, privacy, design, automation, and one that checks the others). Domain packs in
`panels/`: health and fitness, plant care, governance, design.
Platform notes in `platforms/`: iPhone apps, web tools, routines.

---

## Install

### On my own computer (every project)

On a computer, in Claude Code (on the phone, use the next section instead):

```
/plugin marketplace add bnnnewman/app-build-playbook
/plugin install playbook@bnnnewman-playbook
```

Restart. To update later: `/plugin marketplace update bnnnewman-playbook`, then
`/plugin update playbook@bnnnewman-playbook`.

To teach as we build: `/output-style` and pick **Playbook Teach**.

### In every cloud session (claude.ai/code and the phone app)

Do this once. Easiest: ask any cloud session, **"update my environment's setup script from the playbook"**. It will
show you the change to approve.

By hand:
1. In any cloud session, open the environment menu in the title bar, then **Edit**.
2. Paste everything below the `# ---` line of [`scripts/cloud-setup.sh`](scripts/cloud-setup.sh) into **Setup
   script**. Save.
3. Start a **new** session and say "where are we?".

The script installs the playbook and adds `OWNER.md` to every session's standing instructions. After that the
playbook keeps itself up to date.

**If you set this up before version 2, do this step again**: the new one also installs the owner profile.

### Per project, with nothing installed (fallback)

If the playbook isn't showing up in a project, say **"copy the playbook into this project"**. The session copies the
skills (as `/playbook-<name>`), reviewers and templates into the project's `.claude/` folder, using
`scripts/vendor.sh`.

---

## How it gets better

1. Every PR summary asks me one question: "anything slow, confusing or great?"
2. At each release, a five-minute retro: numbers filled in by a script, my answers, and what the project learned,
   written to `retros/playbook-proposals.md`.
3. `/playbook:retro sync` brings those here as a branch: new lessons in [`LESSONS.md`](LESSONS.md), numbers in
   [`METRICS.md`](METRICS.md), and the edits themselves.
4. I merge playbook changes like any other.

Rules for editing this repo: [`.claude/CLAUDE.md`](.claude/CLAUDE.md).

## Credits

`/playbook:grill` is adapted from the `grilling` skill in [mattpocock/skills](https://github.com/mattpocock/skills)
(MIT). The scorecard idea in `/playbook:critique` is adapted from pbakaus/impeccable (Apache 2.0) and
pjt222/agent-almanac (MIT). See [`THIRD-PARTY-NOTICES.md`](THIRD-PARTY-NOTICES.md).
