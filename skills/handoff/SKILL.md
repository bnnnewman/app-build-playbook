---
name: handoff
description: Write a hand-over so a fresh session can carry on cold - when this session's context is nearly full, at the end of a stage, or to brief a different chat (for example one that writes papers). Use when the owner says "hand off to a new session/chat", when context is high, or before stopping mid-build.
argument-hint: "[session | chat <purpose>]"
---
# Hand-over

*`${CLAUDE_PLUGIN_ROOT}` is the playbook folder. If you see it literally, find the folder by searching for `PLAYBOOK.md` under `~/.claude/plugins/`, `/opt/app-build-playbook` or `.claude/playbook/`.*

Say when your context is nearly full; don't wait to be asked.

## `session` (default): for the next Claude Code session

1. Commit and push everything (no remote: commit, and say "not pushed" at the top of the hand-over). A hand-over that points at uncommitted work is useless.
2. Write `work/<build>/HANDOFF.md` from `${CLAUDE_PLUGIN_ROOT}/templates/HANDOFF.md`. Keep it under 80 lines:
   - the branch to start from, and the footer (On main · On a branch · On your phone);
   - where things stand: steps done, checks and the count a command produced, lanes closed or open;
   - **read first**, in order, and what *not* to re-read;
   - what is decided (IDs) and must not be reopened; what is `pending`;
   - **questions the owner still has to answer**, ready to ask as a grill round;
   - the next three actions;
   - set-up facts a fresh container needs (the install command, what can't run here);
   - the teaching mode.
3. Update `STATUS.md`.
4. Tell the owner the one line to start the next session with: *"Continue from `work/<build>/HANDOFF.md`."* If
   you can start the session yourself and he has asked you to, do it, and tell him its title.

## `chat <purpose>`: a brief to paste into a different chat

Separate chats share nothing. Write a self-contained brief he can paste: what the project is in three lines; the
facts that chat needs (by role, no names, no personal data); what's decided; what you want back and in what form.
Save it to `work/<build>/BRIEF-for-<purpose>.md` and show it in the reply.
