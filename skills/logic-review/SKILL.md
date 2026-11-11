---
name: logic-review
description: Review whether the product holds one coherent, current model of its rules (not a code review, not a design critique) - one source of truth per concept, what overrides what, what progress means, and drift between docs and code - with a simulated period of use read by a domain expert. Ends in proposals, never code. Use before a first release, and in every build that changes what the product plans, counts, caps, gates or decides.
argument-hint: "engine | concept <name> | clash <rule> + <rule> | drift"
---
# Logic review

*`${CLAUDE_PLUGIN_ROOT}` is the playbook folder. If you see it literally, find the folder by searching for `PLAYBOOK.md` under `~/.claude/plugins/`, `/opt/app-build-playbook` or `.claude/playbook/`.*

Per-change audits check each change against its own spec. Green tests check examples. Neither shows whether the
whole model adds up over weeks of use. The question here: **does the product hold one clear, current model, and
does every rule still serve the goal?**

## Scope

- `engine`: everything. All four lenses, the logic map, the simulation and the panel. The longest run.
- `concept <name>`: one concept end to end. Lenses 1, 3, 4.
- `clash <rule> + <rule>`: one meeting of rules. Lens 2, with a simulated case.
- `drift`: lens 4 only.

## Read first

`OWNER.md`; the project `CLAUDE.md` (the goal every rule serves, and the Critical list); PLAN; SPEC (rules,
invariants, locked constants); `DECISIONS.md`; the acceptance list; the code that owns the rules and its tests;
earlier reports in `work/*/reviews/LR*.md`. Don't re-raise a settled point. A decision that looks wrong gets
**"Reopens D-…"** with new evidence.

## Hard limits

- **Safety never loosens quietly.** A proposal that makes a rule less strict gets ⚠ and goes to the owner alone.
- **Made-up data only.** To check a rule against real history use `/playbook:spike replay`: counts only.
- **Test-only code.** The simulation lives with the tests and never ships. No source changes during the review.

## Four lenses

1. **One source of truth.** For each concept: where is it defined (PLAN, SPEC, decisions, code)? Who owns it in
   code? Which tests pin the *rule*, not one example? Duplicates; contradictions. → the **logic map**: concept →
   defined where → the rule in one line → owner → tests → status (coherent / duplicated / contradicts /
   undocumented / untested).
2. **What overrides what.** A precedence matrix for rules that meet on the same day or week. Gaps (nothing decides);
   fights (two rules, or docs and code, pick different winners). The stricter rule wins a tie; a fight the looser
   rule wins is a P1.
3. **What progress means.** Trace how one period becomes the next. Does it reward what the goal says it should? Is
   any path stuck, or looping? Can the user tell why?
4. **Drift.** Docs against code; superseded decisions still in code; dead paths; settings and stored fields nothing
   reads; tests that pin an old rule.

## The simulation (`engine`, or one case for `clash`)

A test-only harness runs a **made-up stretch of real use** (for a training app, a 16-week season; for a tracker, a
term of meetings) through the product's **real entry points**, with disruptions: illness, travel, missed days, bad
data, a deadline. Fixed seed. It prints a period-by-period timeline in plain tables: what the product planned, what
happened, what it decided and why.

Read the timeline as the domain expert would. Mark every point where the product's choice is surprising,
unexplained or wrong. Each is evidence.

## Panel (`engine`)

`/playbook:panel` with the domain experts, the adherence reviewer and the logic auditor. Give them the goal, the
logic map and the timeline, but **not your findings**. Merge; mark what two or more raised.

## Scorecard (0–4 each)

One source of truth · Clear precedence · Progress rewards the right thing · Safety holds under every disruption ·
Docs match the code · Every rule pinned by a test of the rule · The product can say why · Nothing dead.

## Report

In chat first, short. Then `work/<build>/reviews/LR<n>.md`; publish the logic map and the timeline as pages he can
read. Findings ranked: ID `<build>-LR<n>-nn`; type Merge / Order / Fix / Gap / Drop / Doc; where; what's wrong and
when it bites; a proposal small enough to test; P1 (unsafe, or a wrong plan he'd follow) / P2 / P3; size; ⚠.

**Next:** `/playbook:grill` the findings. Accepted ones become **one** build.
