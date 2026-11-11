# Acceptance: <project> <version>

*This version only. Earlier versions are in `acceptance-archive/`. Also published as a tick-box page: <link>.*

**Never do on the Mac** (if there is one): <e.g. "don't commit to main from Xcode: each push is a build">.

## How to send results back
For each step: **done / not done / later**, plus the exact words of any message. Screenshots are welcome for how
things *look*. No screenshots that show personal data.

## <Build id>: <what it is> (about <n> minutes)
<Use a test item for steps x–y, so your real data isn't touched.>

| # | Where | What to tap or do | What you should see (exact words) | Checks |
|---|---|---|---|---|
| 1 | Settings → Export | Tap Export | The share sheet opens straight away. Cancel it. | T041 |

If you see "<expected oddity>" before then, that's expected.

## Once per release: first-run checks
| # | Do this | You should see |
|---|---|---|
| S1 | Send the app to the background for a minute, come back | The same screen, up to date |
| S2 | Close it completely and reopen | No data lost |
| S3 | Turn on aeroplane mode, open it | A calm "offline" state, nothing lost |
| S4 | Open it the next morning | Today is today |
| S5 | Type in a text field, then dismiss the keyboard | The keyboard goes; you can save |

## Once per release: looks and accessibility (screenshots, please)
Open <the five main screens> in each of: **dark mode · the largest text size · increased contrast.**
Send a screenshot of anything cut off, overlapping, unreadable or just odd.

## Later, when it happens
Steps that need a rare situation. Covered meanwhile by automatic scenario tests where marked.

| # | When | What you should see | Automatic test |
|---|---|---|---|
