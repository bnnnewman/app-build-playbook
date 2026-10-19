#!/usr/bin/env bash
# Setup script for a Claude Code cloud environment (claude.ai/code): installs the playbook plugin
# for every session in that environment. Paste the lines below the "---" marker into the
# environment's Setup script box (cloud environment menu in a session's title bar -> Edit).
#
# The repo is public, so no token is needed. If it is ever made private, add an environment variable
# PLAYBOOK_GITHUB_TOKEN holding a fine-grained token (this repo only, Contents: Read-only).
# Never prints the token, never leaves it in the clone's git config, and never fails the session
# start: if the install can't happen it says why and carries on.
# ---
export GIT_TERMINAL_PROMPT=0
pb_token="${PLAYBOOK_GITHUB_TOKEN:-}"
if [ -n "$pb_token" ]; then
  echo "Playbook: PLAYBOOK_GITHUB_TOKEN is set (${#pb_token} characters)."
else
  echo "Playbook: PLAYBOOK_GITHUB_TOKEN is NOT set in the setup script. Check the variable's exact name in the environment settings."
fi
if [ ! -d /opt/app-build-playbook/.git ]; then
  rm -rf /opt/app-build-playbook
  if [ -n "$pb_token" ]; then
    url="https://x-access-token:${pb_token}@github.com/bnnnewman/app-build-playbook"
  else
    url="https://github.com/bnnnewman/app-build-playbook"
  fi
  if git clone --quiet --depth 1 "$url" /opt/app-build-playbook 2>/tmp/playbook-clone.err; then
    git -C /opt/app-build-playbook remote set-url origin https://github.com/bnnnewman/app-build-playbook
  else
    echo "Playbook: clone failed: $(sed "s/${pb_token:-NO_TOKEN}/<token>/g" /tmp/playbook-clone.err | tail -1)"
  fi
  rm -f /tmp/playbook-clone.err
fi
if [ -d /opt/app-build-playbook/.git ]; then
  claude plugin marketplace add /opt/app-build-playbook >/dev/null 2>&1 || true
  if claude plugin install playbook@bnnnewman-playbook --scope user >/dev/null 2>&1; then
    echo "Playbook installed: v$(sed -n 's/.*"version": *"\([^"]*\)".*/\1/p' /opt/app-build-playbook/.claude-plugin/plugin.json)"
  else
    echo "Playbook: cloned, but 'claude plugin install' failed."
  fi
fi
unset pb_token url
true
