# Panel pack: health and fitness

**Status:** used in anger on Running-App (Oct 2026): 8-reviewer panel, then 2 rechecks.

| Agent | Code | Holds precedence on | Notes |
|---|---|---|---|
| `physio-reviewer` | PH | Injury risk (with `logic-auditor`) | The harm owner |
| `endurance-coach-reviewer` | EC | Sport programming | Swap the sport as needed |
| `strength-coach-reviewer` | SC | Gym programming | |
| `sports-scientist-reviewer` | SS | Data and thresholds | Use instead of the core `data-reviewer` |
| `mobility-reviewer` | MO | Own remit | |
| `sports-dietitian-reviewer` | SD | Own remit | Strict "no diet plan" constraint |

Pair them with the core `logic-auditor` and `adherence-reviewer`. This pack plus the two core reviewers is the original 8-reviewer panel.

**Precedence used:**
1. `logic-auditor` and physio on injury risk;
2. the coach on sport programming;
3. the strength coach on gym work;
4. the sports scientist on data and thresholds;
5. others within their remit.

**What worked:**
- Specific Context blocks, with real numbers from the owner's data.
- Pointed questions that name PLAN sections.
- Asking for "exact values with sources".
- The dietitian's hard constraints.

**What to improve:**
- Rechecks cited "from memory, unverified", so verification is now in every prompt.
- The physio recheck was unplanned. Plan it in R6 if items are deferred to "physio to confirm".
