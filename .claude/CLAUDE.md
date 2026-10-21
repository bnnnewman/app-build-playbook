# Working on the playbook itself

This repo is both a readable playbook and a Claude Code plugin (`playbook`, published through the `bnnnewman-playbook` marketplace in `.claude-plugin/`).

## Layout

| Path | What |
|---|---|
| `PLAYBOOK.md` | The process: stages, gates, conventions. The source of truth for *why* |
| `LESSONS.md` | Numbered lessons (L-nn), Keep/Change, with evidence. Never renumber |
| `METRICS.md` | One block per project, one row per stage |
| `CHANGELOG.md` | Playbook versions |
| `skills/<name>/SKILL.md` | The `/playbook:<name>` commands. They reference files as `${CLAUDE_PLUGIN_ROOT}/…` |
| `agents/` | Core reviewers, loaded as `playbook:<name>` |
| `templates/` | Doc templates the skills copy into projects |
| `panels/<domain>/` | Domain reviewer templates with `<<PLACEHOLDERS>>`. Not loaded as agents |
| `examples/` | Case studies of finished projects |
| `THIRD-PARTY-NOTICES.md` | Licences for adapted work (e.g. the grill skill). Keep it current when adapting anything else |
| `scripts/vendor.sh` | Copies the plugin into a project's `.claude/` for cloud sessions (must work with GNU and BSD sed) |
| `scripts/coverage.py` | SPEC test ID → test coverage matrix |

## Rules for changes

- **Every process change traces to a lesson.** Add or cite an L-ID in `LESSONS.md`, then change PLAYBOOK, the template or the skill so they agree. Grep for the old wording across all files: skills restate parts of PLAYBOOK.
- **Keep skills operational.** Skills say what to do, step by step; PLAYBOOK says why. Keep each SKILL.md under about 150 lines, and put detail in templates.
- **Versioning (semver)** in `.claude-plugin/plugin.json`:
  - patch: wording;
  - minor: a process or template change;
  - major: a restructure that changes stage numbers or file layout.
  Update the version in the PLAYBOOK.md header too, and add a CHANGELOG entry.
- **Validate before committing:** `claude plugin validate . --strict`.
- **Generic over specific.** Domain content goes in panel packs or examples, never in core skills, agents or templates.
- **Style:** plain English, short sentences, concrete numbers. Match the existing files.
- No model names in commits or code. No personal health data or other personal data in examples.
