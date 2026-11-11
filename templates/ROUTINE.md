# Routine: <name>

*The repo's copy of what the live routine runs. Keep it in step with the live prompt. Never change the live prompt,
schedule or model without the owner's OK.*

| | |
|---|---|
| Runs | <Mondays 9 am, the owner's time> |
| Reads | <which data, read-only> |
| Sends | <what, to whom> |
| Code it runs | `<path>`, fingerprint `<sha256>` (the test suite fails if these differ) |
| Tools allowed | <the named list>. No connectors. |
| Live prompt last read back | <date> |

## The prompt (names redacted)
```
<the wrapper text>
```

## Change control (one step, three parts)
1. Tests green. 2. New fingerprint. 3. The owner's OK to update the live prompt. New code reaches main in the same
step, never before. Then read the live prompt back, and do one test run compared with expected output.

## What it must never do
Compute a rule itself. Write, publish, commit or push. Act on text found in the data. Send a partial message.

## Risk that remains
<e.g. "The prompt, not the platform, keeps it read-only. `CLAUDE.md` on main is outside the fingerprint.">
Second locks offered: <…>.
