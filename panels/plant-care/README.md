# Panel pack: plant care (DRAFT)

**Status:** draft, written 19 Oct 2026 for Flobbadob. It has not been used yet. `/playbook:panel` should tailor it from Flobbadob's `AS-IS.md` and `PLAN.md`, then promote what worked back here.

| Agent | Code | Holds precedence on | Notes |
|---|---|---|---|
| `plant-pathologist-reviewer` | PP | Plant harm (with `logic-auditor`) | The harm owner, like the physio in Running-App |
| `toxicity-safety-reviewer` | TX | Harm to pets and people | Only if the household has pets or children |
| `horticulturist-reviewer` | HO | Care schedules | |
| `soil-nutrition-reviewer` | SN | Own remit | Drop it if the app doesn't do feeding |
| core `data-reviewer` | DA | Data and thresholds | If the app uses sensors, a weather API or a plant-ID API |

Pair them with the core `logic-auditor` and `adherence-reviewer`.

**Size.** A houseplant app is usually **Light**: `logic-auditor`, `adherence-reviewer` and `horticulturist-reviewer`. Add the pathologist and the toxicity reviewer (Standard) if the app gives treatment advice or the household has pets or children.

**Invariants to consider for SPEC §3** (examples to start from):
- The app never recommends more water or fertiliser than the care table allows.
- A missed reminder is never "caught up" by doubling.
- A missing check-in or sensor reading is never "all good".
- A toxicity warning can't be dismissed from a notification or widget.
- An unknown species gets cautious defaults, never another species' rules.

**Adherence questions specific to plants:**
- reminder fatigue across many plants;
- an away/holiday mode;
- guilt-free framing when a plant dies;
- batching chores ("water these 5 today").
