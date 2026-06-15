#!/usr/bin/env bash
# Purpose: Re-enable the default commit block in the reusable demo sandbox.
# Usage: bash scripts/block-commits.sh
set -euo pipefail

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/demo-common.sh"

rm -f "$COMMIT_OVERRIDE_FILE"
git -C "$ROOT_DIR" config --local --unset demo.allowCommits >/dev/null 2>&1 || true

echo "Commit safeguard is active again."
