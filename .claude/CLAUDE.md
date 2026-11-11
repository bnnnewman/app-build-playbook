# Working on the playbook itself

This repo is a readable playbook and a Claude Code plugin (`playbook`, published through the `bnnnewman-playbook`
marketplace in `.claude-plugin/`). It is **public**: no personal data, no employer or third-party names, no health
values, in any file or example. The owner's own apps may be named. Work projects are described, never named.

**Main is live.** Cloud sessions pull this repo's main branch. Work on a branch; the owner merges.

## Layout

| Path | What |
|---|---|
| `OWNER.md` | The owner's standing preferences. Printed into every session by the hook. Change a line only on his word |
| `PLAYBOOK.md` | The process and why: stages, gates, conventions |
| `GLOSSARY.md` | Plain words for the owner; what each check catches; what each size of change costs |
| `LESSONS.md` | Numbered lessons (L-nn), Keep or Change, with evidence. **Only this repo assigns L-numbers.** Never renumber |
| `METRICS.md` | One block per project; targets for the next |
| `skills/<name>/SKILL.md` | The `/playbook:<name>` commands. They cite files as `${CLAUDE_PLUGIN_ROOT}/…` |
| `agents/` | Core reviewers, loaded as `playbook:<name>` |
| `panels/<domain>/` | Domain reviewer templates with `<<PLACEHOLDERS>>`. Not loaded as agents |
| `platforms/` | Set-up notes per kind of project |
| `templates/` | Documents the skills copy into projects |
| `hooks/hooks.json`, `scripts/orient.sh` | The session-start hook. It must never fail a session start |
| `scripts/` | `cloud-setup.sh`, `vendor.sh` (GNU and BSD sed), `coverage.py`, `decisions.py`, `metrics.py` |
| `output-styles/` | The Playbook Teach style |
| `examples/` | Case studies. `THIRD-PARTY-NOTICES.md`: licences for adapted work |

## Rules for changes

- **Every process change traces to a lesson** with evidence from a project. Add the lesson, then change PLAYBOOK,
  the skill and the template so they agree. Search for the old wording everywhere: skills restate parts of PLAYBOOK.
- **Lessons arrive from projects** as `<project>-L<n>` in their `retros/playbook-proposals.md`. Number them here.
- **Skills say what to do; PLAYBOOK says why.** Keep each SKILL.md under about 120 lines. Detail goes in templates.
- **Write for the owner's reading:** plain English, short sentences, concrete numbers, no jargon he'd have to look
  up. He is not a professional developer.
- **Generic over specific.** Domain content goes in `panels/`, platform content in `platforms/`, stories in
  `examples/`. Never in core skills, agents or templates.
- **Versioning** in `.claude-plugin/plugin.json` and the `PLAYBOOK.md` header, with a `CHANGELOG.md` entry: patch for
  wording, minor for a process or template change, major for a restructure.
- **Before committing:** `claude plugin validate . --strict`; `bash -n` on the shell scripts; run `vendor.sh` into a
  scratch folder and check no `${CLAUDE_PLUGIN_ROOT}` or `/playbook:` is left in it.
- No model names in commits or code.
