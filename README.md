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

Invoked as `/playbook:<name>`. Reviewers (`playbook:<name>`): `logic-auditor`, `adherence-reviewer`,
`data-reviewer`, `privacy-reviewer`, `design-reviewer`, `automation-reviewer`, `finding-verifier`.
Domain packs in `panels/`: health and fitness, plant care, governance, design.
Platform notes in `platforms/`: iPhone apps, web tools, routines.

---

## Install

### On my own computer (every project)

In Claude Code:

```
/plugin marketplace add bnnnewman/app-build-playbook
/plugin install playbook@bnnnewman-playbook
```

Restart. To update later: `/plugin marketplace update bnnnewman-playbook`, then
`/plugin update playbook@bnnnewman-playbook`.

To teach as we build: `/output-style` and pick **Playbook Teach**.

### In every cloud session (claude.ai/code and the phone app)

Cloud sessions start from a saved snapshot, so the **environment** installs the playbook.

1. In any cloud session: the cloud environment menu in the title bar → **Edit**.
2. Paste everything below the `# ---` line of [`scripts/cloud-setup.sh`](scripts/cloud-setup.sh) into **Setup
   script**. Save.
3. Start a **new** session and say "where are we?".

What the script does: clones this repo to `/opt/app-build-playbook`, installs the plugin, and adds `OWNER.md` to the
session's standing instructions. After that the plugin keeps its own copy up to date in the background.

**If you set this up before version 2, paste the script again**: the new one also installs the owner profile.

### Per project, with nothing installed (fallback)

```bash
./scripts/vendor.sh /path/to/project
```

Copies the skills (as `/playbook-<name>`), reviewers, templates and scripts into the project's `.claude/`. Re-run to
update. If a session won't run a script from another repo, ask it to do the same copy by hand.

---

## How it gets better

1. Every merge ends with a five-minute retro: numbers filled in by a script, and one question to me.
2. Each project writes what it learned to `retros/playbook-proposals.md`.
3. `/playbook:retro sync` brings those here as a branch: new lessons in [`LESSONS.md`](LESSONS.md), numbers in
   [`METRICS.md`](METRICS.md), and the edits themselves.
4. I merge playbook changes like any other.

Rules for editing this repo: [`.claude/CLAUDE.md`](.claude/CLAUDE.md).

## Credits

`/playbook:grill` is adapted from the `grilling` skill in [mattpocock/skills](https://github.com/mattpocock/skills)
(MIT). The scorecard idea in `/playbook:critique` is adapted from pbakaus/impeccable (Apache 2.0) and
pjt222/agent-almanac (MIT). See [`THIRD-PARTY-NOTICES.md`](THIRD-PARTY-NOTICES.md).
