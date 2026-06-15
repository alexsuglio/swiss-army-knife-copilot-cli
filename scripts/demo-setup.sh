#!/usr/bin/env bash
# Purpose: Primary setup/bootstrap flow for the combined Copilot CLI + VS Code Chat demo sandbox.
# Usage: bash scripts/demo-setup.sh
set -euo pipefail

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/demo-common.sh"

cd "$ROOT_DIR"
ensure_git_repo

baseline_branch="$(resolve_baseline_branch)"
write_baseline_branch "$baseline_branch"

echo "==> Running preflight checks"
bash "$ROOT_DIR/scripts/preflight-check.sh"

echo
echo "==> Installing sample app dependencies"
(
  cd "$APP_DIR"
  npm install
)

echo
echo "==> Installing commit safeguard"
bash "$ROOT_DIR/scripts/install-commit-guard.sh"

echo
echo "==> Enabling safe demo defaults"
bash "$ROOT_DIR/scripts/demo-mode.sh" reset
bash "$ROOT_DIR/scripts/block-commits.sh"

echo
echo "==> Recording baseline branch"
echo "Baseline branch: $baseline_branch"
write_baseline_branch "$baseline_branch"

echo
echo "==> Ensuring scenario snapshot branches exist"
bash "$ROOT_DIR/scripts/init-snapshots.sh"

echo
echo "==> Resetting to scenario 0 baseline"
bash "$ROOT_DIR/scripts/demo-reset.sh" 0

echo
echo "Demo sandbox is ready."
echo "CLI track: bash scripts/run-scenario.sh 1"
echo "IDE Chat track: open the repo in VS Code and use scenarios/ide-chat-scenarios.json"
