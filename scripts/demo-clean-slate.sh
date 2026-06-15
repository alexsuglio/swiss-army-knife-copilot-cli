#!/usr/bin/env bash
# Purpose: Primary full reset flow for the combined Copilot demo sandbox.
# Usage:
#   bash scripts/demo-clean-slate.sh
#   bash scripts/demo-clean-slate.sh --refresh
set -euo pipefail

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/demo-common.sh"

REFRESH="false"
for arg in "$@"; do
  case "$arg" in
    --refresh)
      REFRESH="true"
      ;;
    -h|--help)
      echo "Usage: bash scripts/demo-clean-slate.sh [--refresh]"
      echo
      echo "Default: return to the baseline branch, restore safe defaults, ensure snapshots exist, then reset to scenario 0."
      echo "--refresh: also force-refresh existing scenario snapshot branches from the baseline branch."
      exit 0
      ;;
    *)
      echo "Unknown option: $arg"
      echo "Usage: bash scripts/demo-clean-slate.sh [--refresh]"
      exit 1
      ;;
  esac
done

cd "$ROOT_DIR"
ensure_git_repo

baseline_branch="$(resolve_baseline_branch)"

if ! git show-ref --verify --quiet "refs/heads/$baseline_branch"; then
  echo "Baseline branch '$baseline_branch' not found locally. Re-run: bash scripts/demo-setup.sh"
  exit 1
fi

echo "==> Restoring reset mode"
bash "$ROOT_DIR/scripts/demo-mode.sh" reset

echo
echo "==> Re-enabling commit safeguard"
bash "$ROOT_DIR/scripts/block-commits.sh"

echo
echo "==> Returning working tree to $baseline_branch"
git checkout "$baseline_branch" >/dev/null
git reset --hard "$baseline_branch" >/dev/null
git clean -fd >/dev/null

echo
if [ "$REFRESH" = "true" ]; then
  echo "==> Refreshing snapshot branches from $baseline_branch"
  bash "$ROOT_DIR/scripts/init-snapshots.sh" --refresh
else
  echo "==> Ensuring snapshot branches exist"
  bash "$ROOT_DIR/scripts/init-snapshots.sh"
fi

echo
echo "==> Resetting to scenario 0 baseline"
bash "$ROOT_DIR/scripts/demo-reset.sh" 0

echo
echo "Demo sandbox restored to its prepared baseline."
echo "Current branch: $(git rev-parse --abbrev-ref HEAD)"
