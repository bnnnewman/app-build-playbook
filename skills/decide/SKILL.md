---
name: decide
description: Batch open questions, proposals, flags and pending conservative defaults for the owner, ask them as options with a recommendation, and record every answer in DECISIONS.md (and NOTES-FOR-OWNER.md for flags) with a Notes commit. Use whenever decisions are waiting - after a panel synthesis, at audit exit, or before a phase plan is fixed.
---
# Owner decisions

The owner decides. Your job is to make deciding fast and to record it exactly.

1. **Gather what's waiting.** Look at:
   - `reviews/SUMMARY.md` IDs with no decision;
   - `DECISIONS.md` rows with status `pending-default`;
   - ⚠ loosening items;
   - unanswered Flags in `NOTES-FOR-OWNER.md`;
   - open questions in the latest handoff or phase plan;
   - PLAN §9 "Still open".
2. **Deduplicate and order them:**
   - Critical first, then ⚠ loosenings, then Major, then the rest.
   - Put things that block the next step ahead of things that don't.
3. **Ask.**
   - **If you have AskUserQuestion:** up to 4 questions a call, 2–4 options each, the recommended option first, marked "(Recommended)".
   - **Otherwise:** ask in chat as a short numbered list, with lettered options and your recommendation. Then wait.
   - Each question is self-contained. The owner may be on their phone with no other context, so say what it's about in one line.
   - A ⚠ loosening is **always its own question**, saying plainly that it loosens a safety rule.
   - For panel proposals, ask accept / reject / modify. Minors can be batched: "Accept all Minors except…?"
   - For `pending-default` items: "We've been using <default>. Keep it?"
4. **Record each answer immediately** in `DECISIONS.md`:
   - its ID, the date, the source, the options, the answer, who decided, whether it's reversible, and its status (`confirmed` / `changed` / `rejected`);
   - keep the owner's words where they're short ("go with your recommendation").
   - Answer any Flag in `NOTES-FOR-OWNER.md` as "(Owner, date): …".
   - Update SUMMARY's decision section if it's from the panel.
   - Rejected items keep their row.
5. **Commit straight away**, separate from code: `Notes: <short summary> (<IDs>)`.
6. If an answer changes a rule, follow up with `/playbook:design revise decision <IDs>`. If it reopens a closed area, run one narrow audit round on it.
7. **Tell the owner what changed**, in 2–4 lines.
