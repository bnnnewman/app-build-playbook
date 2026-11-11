# Panel pack: plant care

**Status:** used on Flobbadob (Oct 2026): logic auditor, adherence, pathologist, toxicity (plus a recheck),
horticulturist, soil. The plan-and-spec audit closed in 4 rounds. All 3 Criticals came from the dog.

| Agent | Code | Holds precedence on | Notes |
|---|---|---|---|
| `toxicity-safety-reviewer` | TX | **Anything touching a pet or child. It wins.** | Run a recheck once the owner has said what the pet can reach |
| `plant-pathologist-reviewer` | PP | Plant harm (with `logic-auditor`) | Defers to TX on pets |
| `horticulturist-reviewer` | HO | Care schedules | |
| `soil-nutrition-reviewer` | SN | Own remit | Defers to TX on products. Drop it if the app doesn't do feeding |
| core `data-reviewer` | DA | Data and thresholds | Only with sensors, weather or a plant-ID service |

Pair them with the core `logic-auditor` and `adherence-reviewer`.

**Size.** Standard if any pet or child can reach a plant or a product. Light (auditor, adherence, horticulturist)
only when the household has neither.

**Ask the owner first** (five of six reviewers asked these, so they belong in the start interview):
- the species he actually has;
- whether a pet or child can reach the plants, the pots or the products;
- which products he uses (feeds, pest treatments).

**Invariants to start from:**
- The app never recommends more water or feed than the care table allows; a missed task is never "caught up".
- A missing check-in is never "all good". A task that is due is never hidden or shown as done.
- An unknown species gets cautious defaults, never another species' rules.
- **Never name a product. Never say "natural", "organic", "gentle", "pet-friendly" or "safe".** Enforce it with a
  deny-list test over every user-facing string, with the one allowed sentence listed.
- An emergency line ("pet ate something?") is always first, has no switch to hide it, names the verified national
  helpline and adds "or your nearest emergency vet". Its wording is pinned by an exact-text test.

**Adherence, for plants:** reminder fatigue across many plants; an away mode; guilt-free framing when a plant dies;
batching ("water these 5 today").
