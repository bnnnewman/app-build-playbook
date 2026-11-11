#!/usr/bin/env bash
# SessionStart hook: orients every session. Prints the owner profile and, in a playbook project, where things stand.
# Its output becomes context for the session. It must never fail a session start: every path exits 0.
root="${CLAUDE_PLUGIN_ROOT:-$(cd "$(dirname "$0")/.." 2>/dev/null && pwd)}"
proj="${CLAUDE_PROJECT_DIR:-$PWD}"
[ -f "$root/.claude-plugin/plugin.json" ] || root="$(cd "$(dirname "$0")/.." 2>/dev/null && pwd)"
{
  ver="$(sed -n 's/.*"version": *"\([^"]*\)".*/\1/p' "$root/.claude-plugin/plugin.json" 2>/dev/null | head -1)"
  echo "## App build playbook v${ver:-?} is installed"
  echo "The owner's standing preferences follow. Apply them in every reply. Don't re-ask what they answer."
  echo
  if [ -f "$root/OWNER.md" ]; then
    # The whole profile is under 6,000 characters; keep a hard cap anyway.
    head -c 7000 "$root/OWNER.md"
    echo
  fi
  if [ -f "$proj/STATUS.md" ]; then
    echo "## This project: STATUS.md"
    head -n 30 "$proj/STATUS.md" | head -c 2000
    echo
    echo "(Run /playbook:status to refresh. Skills: /playbook:<name>; the owner usually just says what he wants.)"
  elif grep -qs "app build playbook" "$proj/CLAUDE.md" 2>/dev/null; then
    echo "## This project follows the playbook but has no STATUS.md yet. Run /playbook:status."
  elif [ -f "$proj/BRIEF.md" ]; then
    echo "## This project is Mini size: BRIEF.md holds the plan, rules and decisions. Check its grow check."
  fi
} 2>/dev/null
# In a cloud session the playbook is a clone under /opt: keep it current for the next session, quietly.
if [ "${CLAUDE_CODE_REMOTE:-}" = "true" ] && [ -d "$root/.git" ]; then
  ( cd "$root" && timeout 15 git pull -q --ff-only ) >/dev/null 2>&1 &
fi
exit 0
