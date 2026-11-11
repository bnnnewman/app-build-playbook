# Review panel: <build or stage> (<what is being reviewed>)

> The reviewers advise. **The owner decides.** No reviewer edits a file. They read commit `<sha>` only.

## 1. Owner context (pasted into every brief, word for word)

- Who it's for and what it is: <…>. What it is **not**: <…>.
- The real numbers: <counts, intervals, sizes, dates the reviewers will need>.
- Where things stand: <built / on trial / live>.
- Hard constraints: <time per day, budget (free tiers), equipment, who else is involved (by role)>.
- **Unknown: ask if it matters (max 3 questions):** <the things you couldn't establish>.

## 2. The panel

| Agent | Code | Remit | Holds precedence on |
|---|---|---|---|
| `logic-auditor` | SA | Consistency, promises, unsafe paths, missing tests | Safety, with the harm owner |
| `adherence-reviewer` | AD | Real-life use, friction, other users | |
| `<domain>-reviewer` | <XX> | … | <harm> |

**Conflicts are settled in this order:** 1. <harm owner> and the auditor on safety; 2. <…>; 3. others in their remit.

## 3. The brief (same for all)

> "Review <files> from your specialist view. **Read `OWNER.md`, `DECISIONS.md` and `AS-IS.md` first, and say that
> you did.** Owner context: <paste>. Use the template at <path>, IDs `<build>-<your code>0-nn`, under 900 words.
> Cite the decision or profile line for any point they touch; a finding that disagrees says 'Reopens D-…'. Mark
> anything that loosens a rule ⚠. Verify each citation, or tag it [unverified]. Return the review; save nothing."

The auditor: the audit template, no word limit, no Bash on documents.

## 4. Done when

- [ ] The owner said "start" to this list of reviewers.
- [ ] Every review saved to `work/<build>/reviews/<code>0.md`; verifier run (Full, or more than 6 reviewers).
- [ ] `SUMMARY.md` written by the main session.
- [ ] Every Critical and Major has the owner's decision.
- [ ] Accepted changes applied; rechecks run where his answers changed a reviewer's facts.
- [ ] Audit loop closed at 0 Critical, 0 Major.
