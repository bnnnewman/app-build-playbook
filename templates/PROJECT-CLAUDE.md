# <App name>

<One paragraph: what the app does, for whom, platform.>

This project follows the **app build playbook** (`bnnnewman/app-build-playbook`, v<x.y.z>). Run `/playbook:status` to see where things stand.

## Playbook map

| Role | Path | Version / state |
|---|---|---|
| Stage | <0–7, and phase number> | <date> |
| Size | Light / Standard / Full (see PLAYBOOK "Sizing the process") | <why> |
| Environment | Local <machine> / cloud sessions / both | <what runs where> |
| Remote | <git remote URL, or "none: commit locally, PR bodies go in phases/"> | |
| Plan (domain truth) | `PLAN.md` | v1.0 |
| SPEC (software truth) | `SPEC.md` | v1.0 |
| Decisions log | `DECISIONS.md` | |
| Notes for the owner | `NOTES-FOR-OWNER.md` | |
| Changelog | `CHANGELOG.md` | |
| Panel config | `REVIEW-PANEL.md` | |
| Reviews | `reviews/` | |
| Phase docs | `phases/` | |
| Spikes | `spikes/` | |
| Retros | `retros/` | |
| As-is inventory (adopted only) | `AS-IS.md` | |
| Test coverage matrix | `TESTS.md` | |

## What "Critical" means here

<Domain definition, e.g. "could plausibly kill or harm a plant or a pet, or make the app give unsafe advice; or any path that loosens a guardrail or acts without the owner's Confirm".>

## Guardrails

- <Owner> decides. Reviewers advise and never edit.
- Decisions in `DECISIONS.md` are final. Don't reopen them.
- If PLAN and SPEC disagree, ask <owner>. Don't guess.
- Never weaken a safety rule without <owner>'s explicit, separate confirmation (mark loosenings ⚠).
- Never commit real personal data. Fixtures are hand-written; spikes report counts only.
- No model names in commits or code.

## Build and test

```bash
<exact commands: toolchain install (for a fresh cloud container if used), build, test>
python3 <path-to-playbook>/scripts/coverage.py --spec SPEC.md --tests '<test glob>'   # writes TESTS.md
```

**What runs where:**
- **Cloud (Linux), if used:** <tested here>
- **CI:** <tested by CI, and on which triggers>
- **Owner's machine or device only:** <list>

## Writing style

Plain English. Short sentences. Concrete numbers. Lead with the answer. Questions to <owner> go as lettered options with a recommendation.
