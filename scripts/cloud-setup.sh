#!/usr/bin/env bash
# Setup script for a Claude Code cloud environment (claude.ai/code): installs the playbook plugin
# for every session in that environment. Paste the lines below the "---" marker into the
# environment's Setup script box (cloud environment menu in a session's title bar -> Edit).
#
# Needs: an environment variable PLAYBOOK_GITHUB_TOKEN holding a fine-grained GitHub token with
# access to bnnnewman/app-build-playbook only, Contents: Read-only. Not needed if the repo is public.
# Never prints the token, and doesn't leave it in the clone's git config.
# ---
if [ ! -d /opt/app-build-playbook ]; then
  if [ -n "${PLAYBOOK_GITHUB_TOKEN:-}" ]; then
    git clone --quiet --depth 1 "https://x-access-token:${PLAYBOOK_GITHUB_TOKEN}@github.com/bnnnewman/app-build-playbook" /opt/app-build-playbook
    git -C /opt/app-build-playbook remote set-url origin https://github.com/bnnnewman/app-build-playbook
  else
    git clone --quiet --depth 1 https://github.com/bnnnewman/app-build-playbook /opt/app-build-playbook
  fi
fi
claude plugin marketplace add /opt/app-build-playbook || true
claude plugin install playbook@bnnnewman-playbook --scope user || true
echo "Playbook installed: $(sed -n 's/.*"version": *"\([^"]*\)".*/\1/p' /opt/app-build-playbook/.claude-plugin/plugin.json)"
