#!/usr/bin/env bash
# cleanup.sh — Full teardown and reset for the Swiss Army Knife demo sandbox.
# Usage: bash cleanup.sh
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Swiss Army Knife — Demo Cleanup"
echo "Root: $ROOT_DIR"
echo

cd "$ROOT_DIR"

# ── Restore working tree ──────────────────────────────────────────────────────
echo "==> Restoring working tree"
git reset --hard HEAD
git clean -fd

echo

# ── Remove installed packages ─────────────────────────────────────────────────
echo "==> Removing node_modules"
rm -rf "$ROOT_DIR/cli/node_modules"
rm -rf "$ROOT_DIR/ide-chat/node_modules"
echo "node_modules removed"

echo

# ── Remove git hooks config ───────────────────────────────────────────────────
echo "==> Removing commit safeguard"
git config --unset core.hooksPath 2>/dev/null || true
rm -f "$ROOT_DIR/.demo-allow-commits"
echo "Commit safeguard removed"

echo
echo "Sandbox cleaned. Re-run 'bash setup.sh' before your next demo."
