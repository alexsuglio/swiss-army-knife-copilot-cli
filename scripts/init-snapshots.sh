#!/usr/bin/env bash
# Purpose: Safely create or refresh scenario-N-init snapshot branches from main.
# Usage:
#   bash scripts/init-snapshots.sh            # create missing snapshot branches only
#   bash scripts/init-snapshots.sh --refresh  # also refresh existing snapshot branches from main
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
MAIN_BRANCH="main"
REFRESH="false"

for arg in "$@"; do
  case "$arg" in
    --refresh)
      REFRESH="true"
      ;;
    -h|--help)
      echo "Usage: bash scripts/init-snapshots.sh [--refresh]"
      echo
      echo "Default: create missing snapshot branches only."
      echo "--refresh: force-move existing snapshot branches to main."
      exit 0
      ;;
    *)
      echo "Unknown option: $arg"
      echo "Usage: bash scripts/init-snapshots.sh [--refresh]"
      exit 1
      ;;
  esac
done

cd "$ROOT_DIR"

if [ ! -d .git ]; then
  echo "Git repository not initialized. Run: git init"
  exit 1
fi

if ! git show-ref --verify --quiet "refs/heads/$MAIN_BRANCH"; then
  echo "Main branch '$MAIN_BRANCH' not found. Create it first."
  exit 1
fi

current_branch="$(git rev-parse --abbrev-ref HEAD)"

if [ "$REFRESH" = "true" ]; then
  if [ "$current_branch" != "$MAIN_BRANCH" ]; then
    echo "--refresh must be run from '$MAIN_BRANCH'. Current branch: $current_branch"
    echo "Run: git checkout $MAIN_BRANCH"
    exit 1
  fi

  if [ -n "$(git status --porcelain)" ]; then
    echo "Working tree is dirty. Commit or stash changes before --refresh."
    exit 1
  fi
fi

for id in 0 1 2 3 4; do
  branch="scenario-${id}-init"
  if git show-ref --verify --quiet "refs/heads/$branch"; then
    if [ "$REFRESH" = "true" ]; then
      if [ "$current_branch" = "$branch" ]; then
        echo "Skipped active branch: $branch"
      else
        git branch -f "$branch" "$MAIN_BRANCH"
        echo "Refreshed snapshot branch from $MAIN_BRANCH: $branch"
      fi
    else
      echo "Exists (left unchanged): $branch"
    fi
  else
    git branch "$branch" "$MAIN_BRANCH"
    echo "Created snapshot branch from $MAIN_BRANCH: $branch"
  fi
done

if [ "$REFRESH" = "true" ]; then
  echo "Snapshot refresh complete."
else
  echo "Snapshot initialization complete (create-only mode)."
  echo "Use --refresh to update existing snapshot branches from $MAIN_BRANCH."
fi
