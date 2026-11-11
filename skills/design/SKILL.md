---
name: design
description: Run the visual design track for anything with a screen - the look-and-feel brief, round-0 mock-ups with directions to pick or mix, and the design lock (style guide plus a scan test) - before the first screen is built. Use at stage 4, when the owner wants a redesign or "my visual imprint", or when a new surface (widget, watch, web page) needs its own lock.
argument-hint: "[brief | round0 | lock | surface <name>]"
---
# Design

*`${CLAUDE_PLUGIN_ROOT}` is the playbook folder. If you see it literally, find the folder by searching for `PLAYBOOK.md` under `~/.claude/plugins/`, `/opt/app-build-playbook` or `.claude/playbook/`.*

Read first: `${CLAUDE_PLUGIN_ROOT}/OWNER.md` (taste defaults), `${CLAUDE_PLUGIN_ROOT}/PLAYBOOK.md` "Stage 4", the
SPEC's screen list. Decision IDs here are `D-LK-nn`. No argument: do the next step that's missing.

**By size.** *Mini:* a mock-up before anything visible; no lock. *Light:* a five-question brief, one mock round, a
one-page style guide. *Standard:* all three steps and a scan test of about 10 rules. *Full:* plus a panel on the
lock, a page inventory, a flow map, and `/playbook:art` for drawn art.

## `brief` → `design/DESIGN-BRIEF.md`

From `${CLAUDE_PLUGIN_ROOT}/templates/DESIGN-BRIEF.md`. Grill (skip what `OWNER.md` settles):
- **Apps he likes, by element** ("small grey label over a big bold number"), and what he does *not* want from each.
- Who uses it and in what moment (a glance at 6 am; one-handed; at a desk).
- His phone, light or dark, text size.
- Spelling and units; a **reading-level line** ("could he follow it at 6 am without the plan open?").
- **Font licence** (free to embed) and **where art comes from** (drawn for this, never traced; references as links).
- **The accessibility bar**, set as a decision now: largest text sizes, screen reader, contrast, 44 pt targets.
- Does it sit beside another of his apps? Then say what carries over.

## `round0` → one mock-up page

Use `/playbook:mock round0`. One page, opened on his phone: 2–3 named directions; fonts; colours; the main screen in
**every state**, true size, light and dark, largest text. Made-up data only. He picks, or mixes. Repeat until he
says lock. A design panel (`${CLAUDE_PLUGIN_ROOT}/panels/design/`) may review the **mock-up**, never code.

## `lock` → `design/STYLE-GUIDE.md`, `design/LEDGER.md`, a scan test

From `${CLAUDE_PLUGIN_ROOT}/templates/STYLE-GUIDE.md`:
1. Fill voice, words we don't show, the glossary, tokens, components, page types, from his picks.
2. **Safety wording:** list every safety line; one component draws them; pin each with an exact-text test; add a scan
   that fails a stray safety-looking line.
3. **A scan test** that reads the UI code as text: no one-off colours or fonts, the shared components used, no
   shrinking text, banned words. An allow-list entry needs a decision ID.
4. Test the lock with one question: **would two careful builders make the same choice?** Where not, add the rule.
5. Start `design/LEDGER.md` from `${CLAUDE_PLUGIN_ROOT}/templates/DESIGN-LEDGER.md`. Full: also `FLOW-MAP.md` and `PAGE-INVENTORY.md` from their templates.
6. The owner locks it (one grill). Add the design block to the project `CLAUDE.md` (from
   `templates/PROJECT-CLAUDE.md`).

After the lock, changes follow the three lanes in the style guide: *conformance* (no decision), *pattern* (mock-up →
decision → lock text → code, one commit), *safety* (audited, asked alone). History goes to the ledger.

## `surface <name>`

A widget, watch face or web page gets its own short lock that **inherits** the main one and lists each difference as
a named override with a reason. Anything else that differs is a defect.
