#!/usr/bin/env bash
# Copies the playbook into a project's .claude/ folder so any session (local or cloud) can use it
# without installing the plugin. Re-run it to update. Commit the result in the project repo.
#
#   ./scripts/vendor.sh /path/to/project
#
# Result in the project:
#   .claude/skills/playbook-<name>/SKILL.md   -> /playbook-<name>
#   .claude/agents/<core agent>.md            -> logic-auditor, adherence-reviewer, ...
#   .claude/playbook/                          -> PLAYBOOK.md, LESSONS.md, templates/, panels/, scripts/, VERSION
#
# .claude/playbook/ is owned by the playbook and replaced on every run: don't edit files there.
# Agent files the playbook didn't put there (e.g. a project-tailored adherence-reviewer) are never overwritten.
# Works with GNU and BSD (macOS) sed.
set -euo pipefail

src="$(cd "$(dirname "$0")/.." && pwd)"
dest="${1:?usage: vendor.sh /path/to/project}"
[ -d "$dest" ] || { echo "No such directory: $dest" >&2; exit 1; }
dest="$(cd "$dest" && pwd)"
[ "$dest" != "$src" ] || { echo "Refusing to vendor into the playbook repo itself" >&2; exit 1; }

root="$dest/.claude/playbook"
manifest="$root/VENDORED"
version="$(sed -n 's/.*"version": *"\([^"]*\)".*/\1/p' "$src/.claude-plugin/plugin.json")"

mkdir -p "$root" "$dest/.claude/skills" "$dest/.claude/agents"
touch "$manifest"

# Rewrites plugin references so the copies work without the plugin.
rewrite() {
  sed -E \
    -e 's#\$\{CLAUDE_PLUGIN_ROOT\}#.claude/playbook#g' \
    -e 's#/playbook:([a-z<>-]+)#/playbook-\1#g' \
    -e 's#`playbook:([a-z-]+)`#`\1`#g' \
    -e 's#playbook:(logic-auditor|adherence-reviewer|data-reviewer|privacy-reviewer)#\1#g'
}

# Reference material (owned by the playbook; replaced each run).
rm -rf "$root/templates" "$root/panels" "$root/scripts"
mkdir -p "$root/scripts"
cp -R "$src/templates" "$src/panels" "$root/"
cp "$src/scripts/coverage.py" "$root/scripts/"
find "$root/templates" "$root/panels" -name '*.md' | while read -r f; do
  rewrite < "$f" > "$f.tmp" && mv "$f.tmp" "$f"
done
for f in PLAYBOOK.md LESSONS.md; do rewrite < "$src/$f" > "$root/$f"; done
echo "$version" > "$root/VERSION"

# Skills, renamed playbook-<name>.
shipped=()
for dir in "$src"/skills/*/; do
  name="$(basename "$dir")"
  out="$dest/.claude/skills/playbook-$name"
  mkdir -p "$out"
  rewrite < "$dir/SKILL.md" | sed -e "s/^name: $name\$/name: playbook-$name/" > "$out/SKILL.md"
  shipped+=("skills/playbook-$name")
  grep -qxF "skills/playbook-$name" "$manifest" || echo "skills/playbook-$name" >> "$manifest"
done

# Core agents. Never overwrite a file the playbook didn't create.
skipped=()
for f in "$src"/agents/*.md; do
  name="$(basename "$f")"
  target="$dest/.claude/agents/$name"
  shipped+=("agents/$name")
  if [ -e "$target" ] && ! grep -qxF "agents/$name" "$manifest"; then
    skipped+=("$name")
    continue
  fi
  rewrite < "$f" > "$target"
  grep -qxF "agents/$name" "$manifest" || echo "agents/$name" >> "$manifest"
done

# Anything vendored earlier that this version no longer ships.
stale=()
while read -r entry; do
  [ -n "$entry" ] || continue
  found=0
  for s in "${shipped[@]}"; do [ "$s" = "$entry" ] && found=1 && break; done
  [ $found -eq 1 ] || stale+=("$entry")
done < "$manifest"

echo "Vendored playbook v$version into $dest/.claude"
echo "Commands: $(ls "$dest/.claude/skills" | grep '^playbook-' | sed 's#^#/#' | tr '\n' ' ')"
if [ ${#skipped[@]} -gt 0 ]; then
  echo "Kept the project's own agent(s), not overwritten: ${skipped[*]}"
fi
if [ ${#stale[@]} -gt 0 ]; then
  echo "No longer shipped by the playbook (delete them under .claude/ if unused): ${stale[*]}"
  for s in "${stale[@]}"; do grep -vxF "$s" "$manifest" > "$manifest.tmp" || true; mv "$manifest.tmp" "$manifest"; done
fi
