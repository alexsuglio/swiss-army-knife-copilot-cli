#!/usr/bin/env bash
# Purpose: Intentionally allow the next commit(s) in the reusable demo sandbox.
# Usage: bash scripts/allow-commits.sh
set -euo pipefail

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/demo-common.sh"

touch "$COMMIT_OVERRIDE_FILE"
git -C "$ROOT_DIR" config --local demo.allowCommits true

echo "Commits are temporarily allowed for this repo."
echo "Run 'bash scripts/block-commits.sh' when you want demo protection turned back on."
