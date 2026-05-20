#!/usr/bin/env bash
# Purpose: Fully restore the sandbox to its prepared baseline state.
# Usage:
#   bash scripts/demo-flush.sh
#   bash scripts/demo-flush.sh --refresh
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
REFRESH="false"

for arg in "$@"; do
  case "$arg" in
    --refresh)
      REFRESH="true"
      ;;
    -h|--help)
      echo "Usage: bash scripts/demo-flush.sh [--refresh]"
      echo
      echo "Default: restore reset mode, return to main, ensure snapshots exist, then reset to scenario 0."
      echo "--refresh: also force-refresh existing scenario snapshot branches from main."
      exit 0
      ;;
    *)
      echo "Unknown option: $arg"
      echo "Usage: bash scripts/demo-flush.sh [--refresh]"
      exit 1
      ;;
  esac
done

cd "$ROOT_DIR"

if [ ! -d .git ]; then
  echo "Git repo not initialized."
  exit 1
fi

echo "==> Restoring reset mode"
bash scripts/demo-mode.sh reset

echo
echo "==> Returning working tree to main"
git checkout main >/dev/null
git reset --hard main >/dev/null
git clean -fd >/dev/null

echo
if [ "$REFRESH" = "true" ]; then
  echo "==> Refreshing snapshot branches from main"
  bash scripts/init-snapshots.sh --refresh
else
  echo "==> Ensuring snapshot branches exist"
  bash scripts/init-snapshots.sh
fi

echo
echo "==> Resetting to scenario 0 baseline"
bash scripts/demo-reset.sh 0

echo
echo "Demo sandbox flushed to prepared baseline."
echo "Current branch: $(git rev-parse --abbrev-ref HEAD)"
