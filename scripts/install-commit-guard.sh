#!/usr/bin/env bash
# Purpose: Install the demo pre-commit safeguard so accidental commits are blocked by default.
# Usage: bash scripts/install-commit-guard.sh
set -euo pipefail

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/demo-common.sh"

cd "$ROOT_DIR"
ensure_git_repo

git config core.hooksPath .githooks
bash "$ROOT_DIR/scripts/block-commits.sh" >/dev/null

echo "Commit safeguard installed."
echo "Hooks path: $(git config --get core.hooksPath)"
echo "Commits are blocked by default until you intentionally allow them."
