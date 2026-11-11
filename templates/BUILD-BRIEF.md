# Build brief: <build id>: <outcome in a few words>

*Written <date> by <the coordinator | this session>. Base: `<commit>`. Branch: `claude/<build>`. Teaching mode: <…>.*

## Done when
> <In the owner's words: what he will be able to see or do.>

## Read first
The playbook's `OWNER.md` · the project `CLAUDE.md` · <SPEC sections> · <the design lock and the approved mock-up,
with its link, if anything is visible>.

## Scope
- In: …
- Out (don't build): …
- Decided already (don't reopen): <IDs>

## Checks this build needs
Tier: <words only | looks only | a rule gets stricter | a loosening or wide change | new feature>.
Lanes at close: <SA · CR · DL · LR · PV · SE · AU>.

## What you own
- **Your files:** <paths>
- **Shared files** (keep changes small, and report them): <paths>
- **Your namespaces:** decisions `D-<build>-nn`; SPEC sections <§x.y–§x.z>; test IDs <prefix or range>.

## Gates, before every push
```bash
<the exact commands>
```
Baseline: <N> tests, 0 failures, at the base commit. What can't run here: <…> (label it "draft, not run"; at most one
step of it before something real runs it).

## Steps (commit after each)
1. **<Outcome>.** SPEC §… Tests: <IDs>.
2. …
k. **End to end.** One test of the "done when".

## Rules for a child session
- Push only to your branch. No PR, no merge, never main.
- Don't ask the owner. Where a decision doesn't cover something, build the cautious reading and list it "for the
  owner" in your report.
- Collect every new user-facing word for the wording page.
- Report with `CHILD-REPORT.md` when done or blocked.
