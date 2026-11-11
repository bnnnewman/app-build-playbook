# Platform notes: iPhone apps (built from cloud sessions)

Learned on two apps. A cloud session runs Linux: it can't build, run or see an iOS screen. Set these up **before the
first feature**, not when the first build breaks.

## How a change reaches the phone (put this in the project `CLAUDE.md`)

Branch → the owner says "merge N" → main → **Xcode Cloud** builds it and sends it to **TestFlight** → it updates on
the phone by itself. The owner never pulls or builds on the Mac.

- **No paid CI.** Xcode Cloud's free hours (25 a month with the developer membership, shared by every app) are the
  only build service. A GitHub macOS workflow, if one exists, is manual only.
- **One merge to main is one build.** Bundle docs-only changes with the next real change.
- **A weekly scheduled build**, so a test build never passes its 90-day expiry. Show the expiry in the app too.
- **Pin the Xcode version** in the workflow. Record the version and the date in `docs/owner/SETUP-APPLE.md`.
- Build errors arrive as an email to the owner. Ask for "the first red line, word for word".
- **Never commit to main from Xcode.** If Xcode offers "recommended settings", don't accept it on main.

## What stands in for a compiler here

1. **The rules in a plain Swift package** with no Apple frameworks, so `swift test` runs in the session. Add the
   Swift install line to the cloud environment's setup script. This is the single most useful step: hundreds of
   tests in under a minute.
2. **Pull each rule out of the screen code** in the same step that changes it, so it can be tested here.
3. **A type-check harness** for the screen code: type-check the SwiftUI files against small stand-in frameworks.
   Give each run its own build folder. Stand-ins must refuse an API they don't know; never invent or loosen one.
4. **Scan tests** that read the source as text and run here:
   - every stored model field appears in the store's mapping (a field was silently dropped twice in one day);
   - the design-pattern scan (shared components, tokens, no shrinking text);
   - every text field can dismiss the keyboard.
5. **A test-only run on the build service, started from the session.** Tag pushes are refused from cloud sessions,
   so use a trigger file: a workflow that starts only when `ci-test-request.txt` changes on the branch. The session
   writes `<run-name> <commit>` into it in a commit of its own. Never touch that file in a docs-only commit.
6. **A debug gallery screen** in the app showing every shared piece and symbol, for the owner's screenshot pass.

Code written without any of these is *draft, not run*. At most one step of it before something real runs it.

## What only the owner can do (one step at a time, with what he should see)

Apple Developer portal: identifiers, capabilities, containers. App Store Connect: the Xcode Cloud workflows, the
start conditions, TestFlight groups, automatic updates. Use `templates/SETUP-PLATFORM.md`; fill in "done on" and
what was set when he reports each step.

## What reviews miss here, and the cheap check for each

| What gets through | The check |
|---|---|
| Doesn't compile on Apple's tools | The type-check harness, from the first screen |
| A stored field silently dropped | The store-field scan |
| Layout on a real screen (clipping, large text, dark) | The owner's screenshot pass: light, dark, largest text |
| Real-device behaviour (background, kill, offline, next morning, keyboard) | The first-run checks in `ACCEPTANCE.md` |
| Right rule, wrong experience | Three days of real use before polish; a logic review with a simulated period |
| A wrong belief about an outside service | A spike; and no merge until its device step is ticked |

## Fixed for life

App and widget identifiers, the App Group, the team. Record them in the project `CLAUDE.md` and never change them.
