#!/usr/bin/env bash
# Purpose: Reset the repo to a clean scenario baseline branch for repeatable demos.
# Usage: bash scripts/demo-reset.sh <scenario-id>
set -euo pipefail

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/demo-common.sh"
SCENARIO_ID="${1:-}"

if [ -z "$SCENARIO_ID" ]; then
  echo "Usage: bash scripts/demo-reset.sh <scenario-id>"
  exit 1
fi

MODE="$(current_demo_mode)"
TARGET_BRANCH="scenario-${SCENARIO_ID}-init"

cd "$ROOT_DIR"
ensure_git_repo

if [ "$MODE" = "append" ]; then
  echo "Append mode enabled. Skipping hard reset."
  echo "Current branch: $(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo no-git)"
  exit 0
fi

if ! git show-ref --verify --quiet "refs/heads/$TARGET_BRANCH"; then
  echo "Branch $TARGET_BRANCH not found. Run: bash scripts/init-snapshots.sh"
  exit 1
fi

bash "$ROOT_DIR/scripts/block-commits.sh" >/dev/null
git reset --hard HEAD >/dev/null
git clean -fd >/dev/null
git checkout "$TARGET_BRANCH" >/dev/null
git reset --hard "$TARGET_BRANCH" >/dev/null

echo "Reset complete. Active branch: $TARGET_BRANCH"
