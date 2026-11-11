# Plain-words glossary

For the owner, and for any session writing to him. Use the left-hand word; mean the right-hand thing.

## Where your work is

| Word | What it means | What it proves |
|---|---|---|
| **Branch** | A separate copy of the project where a change is being made. | Nothing yet. It hasn't reached you. |
| **Push** | Saving a branch to GitHub so it isn't lost. | The work is safe. Still not on your phone. |
| **Pull request (PR)** | A change waiting for your "merge". It has a number. | The change is ready to look at. |
| **Merge** | Putting a finished change into **main**. You say "merge 65". | The change is now part of the real project. |
| **Main** | The real, current version of the project. | For an app: the next build for your phone is made from this. |
| **Build** | Turning the code into something that runs. "Build succeeded" means it compiled. | It **does not** mean the tests passed or that it works. |
| **Tests** | Automatic checks that the rules give the right answers. | The rules behave as written. Not how it looks or feels. |
| **TestFlight build** | A version of the app sent to your phone by Apple. | You can now try it for real. |
| **Published / live** | The version other people (or you) actually use. | This is what counts. The publish log says which version it is. |

The three-line footer you'll see: **On main** (merged) · **On a branch** (waiting for "merge") · **On your phone / live**
(what you can use now).

## The checks, and what each one catches

| Check | Catches | Runs |
|---|---|---|
| **Safety audit** | A rule that could do harm, contradictions, missing tests. | Every build that touches rules or stored data. |
| **Code review** | Bugs: wrong results, crashes, lost data. | Every build. |
| **Design-lock check** | A screen that drifts from the agreed look or wording. | Every build that changes what you see. |
| **Logic review** | Rules that are each right but don't add up over weeks of use. | When a rule changes; whole app before a release. |
| **Privacy review** | Personal data going where it shouldn't. | Builds that store, send or log data. |
| **Security review** | Someone getting in, or reaching what isn't theirs. | Builds that change sign-in, access, stored keys or a connection to another system. |
| **Design critique** | Screens that work but could be calmer, faster, clearer. | New screens; whole app before a release. |
| **Acceptance** | What only real use on your phone shows. | You, after each build reaches you. |

**"0 Critical, 0 Major"** means: nothing found that could cause harm or a wrong result. Minor things are listed and
either fixed in one go or left with a reason.

## Sizes of change, and what each costs

| Change | Checks it needs |
|---|---|
| **Words only** (not safety wording) | Wording page for your OK. No audit. |
| **Looks only** (same information, same rules) | Mock-up first, design-lock check, code review. |
| **A rule gets stricter** | One narrow safety audit of the change, code review. |
| **A rule gets looser** ⚠, a change that reaches many areas, or new stored data | Asked alone, full safety audit, logic review. |
| **New feature** | A brief, mock-up if visible, all the lanes that apply, acceptance on your phone. |

So a new idea does **not** restart everything. It gets the checks its size needs.

## Other words sessions use

| Word | Meaning |
|---|---|
| **Mock-up** | A picture of a screen with made-up data, to choose from before anything is built. |
| **Design lock** | The file that settles how everything looks and reads, so builders don't guess. |
| **Spike** | A quick look at real data or a real service to see what is actually there. |
| **Invariant** | A promise that must always hold ("never show another person's data"). |
| **Pending default** | A cautious choice made while waiting for you. Easy to reverse. |
| **Coordinator** | The one session you talk to. It runs the others. |
| **Hand-over** | A note that lets a fresh session carry on when one is full. |
| **Usage window** | Your plan's 5-hour allowance. Costs are quoted in windows. |
| **★** | The recommended option. "Yes" accepts it. |
| **⚠** | This would loosen a safety rule. It is always asked on its own. |
| **Tightening / loosening** | Making a rule stricter / less strict. |
| **Freeze** | Stop changing the code while the checks read it. |
| **Round** | One pass of a check. "3 rounds" means it was checked, fixed and re-checked twice. |
| **Lane** | One kind of check (safety, code, design…). They run side by side. |
| **Verifier** | A second reviewer whose only job is to catch the first one's mistakes. |
| **Critical / Major / Minor** | Could cause real harm / materially wrong / polish. |
| **Scan test** | An automatic check that reads the code as text, for example "no one-off colours". |
| **Ledger** | The list of what changed in the design lock, and when. |
| **By profile** | Not asked, because your standing preferences already answer it. |
| **Interpretation** | A small technical choice a session made for you, written down in case you disagree. |
| **Fails safe** | If it goes wrong, it goes wrong on the cautious side. |
| **Tag** | A named marker on a released version, so it can be found again. |
| **Acceptance batch** | A set of your results from trying a build, turned into fixes. |
| **Grown out of its size** | The project now does more, or riskier things, than its size allows for. |
| **Child session** | A session the coordinator started to do one piece of work. |
