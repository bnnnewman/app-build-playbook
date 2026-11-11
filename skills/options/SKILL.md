---
name: options
description: Research, then options, then the owner picks - for a platform or tool choice, an approach, or a "how do other products do this" question. States the goal in his words, sets a yardstick, researches with graded sources, compares 3 to 5 options, recommends one with a runner-up, and answers his stated doubt directly. Use when the owner has a hunch or a choice with lasting consequences, or says "what are my options", "not sold on X", "is there a better way".
argument-hint: "<the choice>"
---
# Options paper

*`${CLAUDE_PLUGIN_ROOT}` is the playbook folder. If you see it literally, find the folder by searching for `PLAYBOOK.md` under `~/.claude/plugins/`, `/opt/app-build-playbook` or `.claude/playbook/`.*

Don't recommend from memory. Output: `work/<build>/OPTIONS-<topic>.md` from
`${CLAUDE_PLUGIN_ROOT}/templates/OPTIONS.md`.

1. **The goal, in his words.** Quote what he said, including his doubt ("not sold on it sitting in X, feels clunky").
2. **Constraint questions first** (one short grill): who else uses or edits it; budget (his default: free tiers);
   who must approve (IT, a manager); phone or desk; what must not change.
3. **The yardstick:** what today's version does, as a short feature list. Every option is scored against it.
4. **Research** with subagents, **with sources**. Grade each source: *Opened* (read it), *Summary* (search snippet
   only), *Not verified*. List sites that couldn't be reached. Never invent a feature, price or limit.
5. **Three to five options**, each: what it is; what he'd see and do; against the yardstick; cost (money, and usage
   windows to build); what he'd need from someone else; the main risk.
6. **A comparison table**, a ★ recommendation, and a **runner-up**.
7. **Answer his doubt directly:** where he was right, where the evidence says otherwise.
8. **Questions only he or a third party can answer.** Draft the message to the third party for him (by role, no
   names).
9. A "not verified" list at the end.
10. For a choice about how something **looks or feels**, the options are a mock-up page (`/playbook:mock`), not prose.

Put the pick to him with `/playbook:decide`. Record it once. If a third party's answer later changes the facts,
reopen it explicitly.
