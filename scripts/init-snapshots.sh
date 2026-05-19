#!/usr/bin/env bash
# Purpose: Create or refresh the scenario-N-init snapshot branches from main.
# Usage: bash scripts/init-snapshots.sh
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

cd "$ROOT_DIR"

MAIN_BRANCH="main"

current_branch="$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo $MAIN_BRANCH)"

if [ ! -d .git ]; then
  git init >/dev/null
  git branch -M "$MAIN_BRANCH"
fi

if ! git config user.email >/dev/null; then
  git config user.email "demo@example.com"
fi
if ! git config user.name >/dev/null; then
  git config user.name "Copilot Demo"
fi

if [ -z "$(git status --porcelain)" ]; then
  echo "Working tree clean."
else
  git add .
  git commit -m "chore: initialize copilot cli demo sandbox" >/dev/null || true
fi

for id in 0 1 2 3 4; do
  branch="scenario-${id}-init"
  if git show-ref --verify --quiet "refs/heads/$branch"; then
    if [ "$current_branch" = "$branch" ]; then
      echo "Snapshot current branch left as-is: $branch"
      echo "To fully refresh it from $MAIN_BRANCH, checkout $MAIN_BRANCH first and rerun this script."
    else
      git branch -f "$branch" "$MAIN_BRANCH"
      echo "Refreshed snapshot branch from $MAIN_BRANCH: $branch"
    fi
  else
    git branch "$branch" "$MAIN_BRANCH"
    echo "Created snapshot branch from $MAIN_BRANCH: $branch"
  fi
done

echo "Snapshot initialization complete."
