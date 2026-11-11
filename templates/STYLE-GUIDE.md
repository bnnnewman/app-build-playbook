# Style guide: <project> (the design lock)

*Version 1.0 · <date> · Locked by the owner (<D-LK-nn>). This file holds only what is true now. What changed, and
when, is in `LEDGER.md`.*

**Precedence: safety (§6) > accessibility (§7.5) > the owner's decisions > everyday use > the rest.**

**The test of this file:** would two careful builders make the same choice? Where they wouldn't, a rule is missing.

## 1. Voice
- Second person, present tense. What it means today first, then why. One idea per line.
- Calm. No exclamation marks, streaks, scores or guilt.
- Bad news has one shape: the fact; what it means today; what happens next.
- A symptom and an action, never a diagnosis.
- Reading level: <the owner's test sentence>.
- <Locale> spelling, sentence case. Numbers and units: <rules>. Dates: <"Fri 20 Nov">.

## 2. Words we don't show
| Don't show | Show instead |
|---|---|
| Internal names, IDs, raw error text | The plain word for it |
| Symbols inside sentences | The word |
| <Banned words for this project> | |

## 3. Glossary: one name per thing
| The thing | The one name | Never |
|---|---|---|

## 4. Buttons and choices
<Levels (primary, secondary, link); one filled button per card; every choice shows what it does.>

## 5. Errors, empty states, "can't save"
<Nothing fails silently. Nothing is lost without asking.>

## 6. Safety wording
- **What counts as a safety line:** <definition>.
- **The inventory:** every safety line, word for word, with where it shows.
- **One component draws them.** They are never hidden, shrunk, greyed, softened or moved behind a tap.
- **Each is pinned by an exact-text test.** A pin is never loosened to "contains".
- **A scan fails** any new line that looks like a safety line and isn't in the inventory.
- A change to any of this goes through the safety lane, asked on its own (⚠).

## 7. Visual rules
7.1 Tokens: colour (light, dark, increased contrast), type, spacing, radius, stroke, motion. One source file.
7.2 Components: each shared piece, its states, where it may be used.
7.3 Warning ladder: how urgency is shown, in order.
7.4 Symbols and art.
7.5 **Accessibility** (from the brief's bar): text sizes, labels, contrast, targets, motion.
7.6 Charts and tables.

## 8. Page types
<The few page types (e.g. home, list, detail, form, sheet, settings), each with its layout, order of attention and
what it never contains.> **8.x A screen agrees with itself, and a flow is complete** (numbers that should match do;
each flow has an entry, an exit, an undo and a refusal).

## 9. Checklist for any new string or screen
1. Would the owner understand it in the moment it's used?
2. Is anything said twice?
3. Does it show background logic the user doesn't need?
4. Does it use the shared pieces and tokens only?
5. Is it the same as other screens of its type?
6. Does every choice show what it does?
7. Is any safety line untouched and in its place?
8. Does it survive the largest text, dark mode and increased contrast?

## 10. How this file changes
- **Conformance:** a screen moves onto an existing rule. A build note with before and after. No decision needed.
- **Pattern:** a new piece, layout or wording. Finding → mock-up (now vs options) → the owner's decision → the lock
  text with its decision ID → code → a scan rule. **The lock change and its code land in one commit.**
- **Safety:** any safety line, the glossary, or the order of attention. Audited; asked alone.
- The version goes up 0.1 per round of decisions. The scan test's allow-list takes an entry only with a decision ID.
- A sub-surface (a widget, a watch face) has its own short lock that inherits this one and lists each difference as a
  **named override** with a reason.
