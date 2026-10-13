#!/usr/bin/env bash
# Releases a new version: bumps plugins/devslaweekq/.claude-plugin/plugin.json,
# commits, tags, and pushes both to origin.
#
# Usage: scripts/release.sh "commit message" [patch|minor|major]
#   patch (default) 1.0.1 -> 1.0.2
#   minor           1.0.1 -> 1.1.0
#   major           1.0.1 -> 2.0.0
set -euo pipefail

MESSAGE="${1:?Usage: scripts/release.sh \"commit message\" [patch|minor|major]}"
BUMP="${2:-patch}"

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PLUGIN_JSON="$REPO_ROOT/plugins/devslaweekq/.claude-plugin/plugin.json"

CURRENT_VERSION="$(node -e "console.log(require('$PLUGIN_JSON').version)")"
IFS='.' read -r MAJOR MINOR PATCH <<< "$CURRENT_VERSION"

case "$BUMP" in
  major) MAJOR=$((MAJOR + 1)); MINOR=0; PATCH=0 ;;
  minor) MINOR=$((MINOR + 1)); PATCH=0 ;;
  patch) PATCH=$((PATCH + 1)) ;;
  *) echo "Unknown bump type: $BUMP (use patch|minor|major)" >&2; exit 1 ;;
esac

NEW_VERSION="$MAJOR.$MINOR.$PATCH"

node -e "
const fs = require('fs');
const path = '$PLUGIN_JSON';
const json = JSON.parse(fs.readFileSync(path, 'utf8'));
json.version = '$NEW_VERSION';
fs.writeFileSync(path, JSON.stringify(json, null, 4) + '\n');
"

cd "$REPO_ROOT"
git add -A
git commit -m "$MESSAGE"
git tag -a "v$NEW_VERSION" -m "$MESSAGE"
git push origin HEAD
git push origin "v$NEW_VERSION"

echo "Released v$NEW_VERSION"
