#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

cd "$ROOT_DIR"

if [ ! -d .git ]; then
  git init >/dev/null
  git branch -M main
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
    echo "Snapshot already exists: $branch"
  else
    git branch "$branch" main
    echo "Created snapshot branch: $branch"
  fi
done

echo "Snapshot initialization complete."
