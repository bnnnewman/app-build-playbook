# Panel pack: design

**Status:** these roles sat on First Light's design panels (widget, UX, accessibility, lock review, page pass).

| Agent | Code | Reviews |
|---|---|---|
| `visual-design-reviewer` | VD | Hierarchy, type, colour, spacing, consistency across page types |
| `accessibility-reviewer` | AX | Text sizes, screen reader, contrast, targets, motion. **Second in precedence, above the owner's own picks** |
| `ux-flow-reviewer` | UX | Journeys, taps, defaults, exits, what the user must remember |
| `copy-reviewer` | CP | Voice, plain words, one name per thing, wording of bad news |

Pair with the core `logic-auditor` (safety wording) and `adherence-reviewer`. For a lock review on a Full project add
a systems reviewer ("would two careful builders make the same choice?").

**Precedence:** safety > accessibility > the owner's decisions > everyday use > the rest.

**They review the mock-up, not code.** A finding then costs a mock edit, not a rebuild. Every brief includes the
decided list, so settled picks aren't reopened.

**Ask the owner first:** which apps he likes, by element; his phone, mode and text size; the accessibility bar.

**Known weak point:** accessibility findings from reading are not a device check. Pair this panel with the
three-setting check on the phone (`templates/ACCEPTANCE.md`).
