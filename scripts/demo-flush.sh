#!/usr/bin/env bash
# Purpose: Backward-compatible wrapper for the full clean-slate reset flow.
# Usage:
#   bash scripts/demo-flush.sh
#   bash scripts/demo-flush.sh --refresh
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
exec bash "$ROOT_DIR/scripts/demo-clean-slate.sh" "$@"
