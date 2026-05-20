#!/usr/bin/env bash
# Purpose: One-shot setup after cloning the demo repo.
# Usage: bash scripts/demo-first-run.sh
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

cd "$ROOT_DIR"

echo "==> Running preflight checks"
bash scripts/preflight-check.sh

echo
echo "==> Ensuring deterministic reset mode"
bash scripts/demo-mode.sh reset

echo
echo "==> Creating scenario snapshot branches if needed"
bash scripts/init-snapshots.sh

echo
echo "==> Resetting to scenario 0 baseline"
bash scripts/demo-reset.sh 0

echo
echo "Demo sandbox is ready."
echo "Current branch: $(git rev-parse --abbrev-ref HEAD)"
echo "Next: cd sample-app && npm install"