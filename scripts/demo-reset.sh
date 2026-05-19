#!/usr/bin/env bash
# Purpose: Reset the repo to a clean scenario baseline branch for repeatable demos.
# Usage: bash scripts/demo-reset.sh <scenario-id>
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
MODE_FILE="$ROOT_DIR/.demo-mode"
SCENARIO_ID="${1:-}"

if [ -z "$SCENARIO_ID" ]; then
  echo "Usage: bash scripts/demo-reset.sh <scenario-id>"
  exit 1
fi

if [ -f "$MODE_FILE" ]; then
  MODE="$(cat "$MODE_FILE")"
else
  MODE="reset"
fi

TARGET_BRANCH="scenario-${SCENARIO_ID}-init"

cd "$ROOT_DIR"

if [ "$MODE" = "append" ]; then
  echo "Append mode enabled. Skipping hard reset."
  echo "Current branch: $(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo no-git)"
  exit 0
fi

if [ ! -d .git ]; then
  echo "Git repo not initialized. Run: git init"
  exit 1
fi

if git show-ref --verify --quiet "refs/heads/$TARGET_BRANCH"; then
  git reset --hard HEAD >/dev/null
  git clean -fd >/dev/null
  git checkout "$TARGET_BRANCH" >/dev/null
  git reset --hard "$TARGET_BRANCH" >/dev/null
  echo "Reset complete. Active branch: $TARGET_BRANCH"
else
  echo "Branch $TARGET_BRANCH not found. Run: bash scripts/init-snapshots.sh"
  exit 1
fi
