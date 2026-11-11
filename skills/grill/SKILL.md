---
name: grill
description: Interview the owner about a plan, a build, a design direction or any idea until there is a shared understanding - a design tree asked in rounds of about 8 numbered questions, each with lettered options, what each option does, and one recommendation; answered "yes to all except…"; read back before acting; every answer recorded. The playbook's way of asking the owner anything. Use when the owner says "grill me", when another playbook skill says to grill, or before acting on anything not fully specified.
argument-hint: "[topic] [walkthrough]"
---
# Grill

*Adapted from Matt Pocock's `grilling` skill (MIT; see `${CLAUDE_PLUGIN_ROOT}/THIRD-PARTY-NOTICES.md`), reshaped around how the owner actually answers.*

*`${CLAUDE_PLUGIN_ROOT}` is the playbook folder. If you see it literally, find the folder by searching for `PLAYBOOK.md` under `~/.claude/plugins/`, `/opt/app-build-playbook` or `.claude/playbook/`.*

Interview the owner about **`$ARGUMENTS`** until you share an understanding. No topic: ask what to grill.

## 1. Before you ask anything

- Read `${CLAUDE_PLUGIN_ROOT}/OWNER.md`, the project `CLAUDE.md` and `DECISIONS.md`.
- List the decisions the topic needs, as a tree: each decision branches into the ones that depend on it.
- **Strike out what's already answered:**
  - by `OWNER.md` → apply it, and list it in the summary as "by profile";
  - by an earlier decision → don't re-ask (unless the topic is to revisit it);
  - by a fact you can look up → look it up (send a subagent; keep asking meanwhile);
  - an engineering choice → make it, log it as an interpretation;
  - domain content the expert reviewers agree on → apply it and report it.
- **A look is never asked in words.** If a branch is about how something looks, ask the *direction* here and send the
  *look* to `/playbook:mock`.

## 2. Ask in rounds

Ask every question whose prerequisites are settled. A question that depends on an open answer waits a round.

```
**Round <n>: <topic>** (<k> questions)

**1. <Question in plain words, one decision>**
   (a) <option> → <what it does, one line>
   (b) <option> → <what it does>
   ★ (a), because <one line>.

**2. …**

Reply "yes to all", or "yes to all except 2: b".
```

- **About 8 questions a round.** Number 1..n once per round; never restart numbering inside a round.
- **Every option says what it does.** He has approved the wrong thing when it didn't.
- **No IDs, file names or jargon in the question.** They go in the log.
- If something costs process (which checks re-run) or is medium or large, say so in the option.
- **⚠ A question that loosens a safety rule is never in a round.** Ask it alone, in its own message, say plainly that
  it loosens a rule, and show counts from a replay (`/playbook:spike replay`) where data exists.

## 3. Read back, then record

1. **Read the answers back in one line, with what each means** ("You chose: 1 a (pause in winter), 2 b (every 14
   days)") before acting on any of them. If an exception
   came with a comment ("a, but it's over-duplicating"), the comment is the decision: restate it.
2. **Record each answer in `DECISIONS.md`** as its own row: ID `D-<build or stage>-nn`, date, the question in plain
   words, **his words**, status `confirmed`. Options and reasoning go in `work/<build>/NOTES.md`.
3. **Parked answers** ("not sure yet") get the cautious default, status `pending`, and stay on the tree.
4. Terms he defines go into SPEC §4.
5. Commit after each round: `Notes: grill <topic> round <n>`.

**Mini:** record in `BRIEF.md` section 6 (`D-01`…) instead of `DECISIONS.md`.

## 4. Walkthrough mode (`walkthrough`)

For finding faults in screens or flows, he reacts first. For each item: name the screen, say what looks wrong, and
ask what he thinks. **No options and no recommendation until he has answered.** Then offer the fix.

## 5. Done

When every branch is settled:
1. Summarise: decisions made; settled already by his standing preferences (logged "by profile"); left to defaults;
   still open.
2. Ask: **"Have we got a shared understanding? Say yes and I'll go ahead."**
3. Act on nothing until he says yes. If another skill called you, hand back only then.

**Depth follows size:** Mini and Light leave cheap, reversible branches to defaults and list them; the yes is still
required.
