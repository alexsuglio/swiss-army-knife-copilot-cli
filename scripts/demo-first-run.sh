#!/usr/bin/env bash
# Purpose: Backward-compatible wrapper for the primary setup/bootstrap flow.
# Usage: bash scripts/demo-first-run.sh
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
exec bash "$ROOT_DIR/scripts/demo-setup.sh" "$@"
