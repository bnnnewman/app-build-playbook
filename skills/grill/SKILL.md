---
name: grill
description: Interview the owner relentlessly about a plan, design, phase or idea until there is a shared understanding - a design tree asked in rounds, each question with a recommended answer, facts looked up by subagents, every answer recorded in DECISIONS.md. The playbook's way of asking the owner anything. Use when the owner says "grill me", when another playbook skill says to grill, or before acting on anything the owner hasn't fully specified.
argument-hint: "[topic, e.g. plan | spec | phase 3 | start | <any idea>]"
---
# Grill

*Adapted from Matt Pocock's `grilling` skill (github.com/mattpocock/skills, MIT licence; see `${CLAUDE_PLUGIN_ROOT}/THIRD-PARTY-NOTICES.md`). The playbook additions: decisions are recorded, the gate is written down, the playbook's guardrails apply, and the depth follows the project's size.*

*`${CLAUDE_PLUGIN_ROOT}` is the playbook folder. If you see it literally, find the folder by searching for `PLAYBOOK.md` under `~/.claude/plugins/` or `.claude/playbook/`.*

Interview the owner relentlessly until you reach a shared understanding of **`$ARGUMENTS`**. If there are no arguments, ask what to grill.

## 1. Map the design tree

- Read what already exists first: the project `CLAUDE.md`, `DECISIONS.md`, and the PLAN, SPEC, handoff or `AS-IS.md` the topic touches.
- List the decisions the topic needs. Every decision branches into the decisions that depend on it.
- **Don't re-ask what's already decided** in `DECISIONS.md`, unless the topic is explicitly to revisit it.

## 2. Ask in rounds

The **frontier** is every decision whose prerequisites are already settled. These are the questions you can ask now, without guessing at answers you haven't heard yet.
- Ask the whole frontier in one round, numbered, each with your recommended answer. Then wait.
- A question that depends on another question still open in this round belongs to a **later** round.

Format each round like this:

```
**Round <n>: <topic>**

❓ **Q1 - <question title>**: <question body; may be several paragraphs; options lettered (a), (b), (c) when there is a real choice>

➡️ <your recommended answer, and the one-line reason>

---

❓ **Q2 - <question title>**: …

➡️ …
```

**Writing the questions:**
- Word each question so that **"yes" accepts your recommendation**. The owner can answer a whole round with "yes to all", or "yes except Q3: (b)".
- Plain English: one decision per question, and concrete options.
- **Each question stands alone.** The owner may be on their phone with no other context, so say in one line what it's about.
- **A ⚠ question loosens a safety rule.** Never put it in a round. Ask it alone (with AskUserQuestion if you have it, otherwise as a single chat question), saying plainly that it loosens a safety rule, so a "yes to all" can never accept it by accident.

## 3. Facts are your job; decisions are the owner's

- Never ask the owner for anything you could look up: code, files, data, docs, the web.
- When a frontier question needs a fact, **dispatch a subagent** (Explore or general-purpose) to find it.
- **Don't wait for it.** A running lookup is an unsettled prerequisite: only the questions that depend on it wait for its report. Ask the rest of the frontier now.
- **Decisions are the owner's.** Put each one to them, and wait.

## 4. Record as you go

After each round, before the next one:
- **Every answer goes into `DECISIONS.md`.** Use the next D-ID, with source `Grill <topic> R<n>`, the options, the answer (keep the owner's words when they're short), reversible?, and status `confirmed`.
- **Terms the owner defines** (what counts as a "missed" watering, which days count as "today") go into SPEC §4 Definitions, if a SPEC exists.
- **Questions the owner parks** ("not sure yet") get the conservative default as `pending-default`, and stay on the tree as open.
- Commit after each round: `Notes: grill <topic> round <n> (<D-IDs>)`.

## 5. Recompute and repeat

Each round of answers reshapes the tree. Settled decisions push the frontier outward and unblock questions that depended on them. Recompute the frontier, then ask the next round.

**Depth follows the project size** in the Playbook map:
- **Full and Standard:** visit every branch.
- **Light:** stop at branches where every option is cheap to reverse. List those as "left to defaults" in the summary instead of asking about them.

## 6. Done means shared understanding

The grill is done when the frontier is empty: every branch visited, nothing left silently assumed. Then:

1. Post a summary:
   - the decisions made (D-IDs);
   - the definitions added;
   - what was left to defaults;
   - anything still open.
2. Ask: **"Have we reached a shared understanding? Say yes and I'll go ahead."**
3. **Don't act on any of it until the owner says yes.** If the skill that called you (start, design, phase-start, decide) is waiting, hand back to it only after the yes.
