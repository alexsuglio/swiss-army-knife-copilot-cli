#!/usr/bin/env bash
# Purpose: Switch between destructive reset mode and keep-my-work append mode.
# Usage: bash scripts/demo-mode.sh reset|append
set -euo pipefail

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/demo-common.sh"
MODE="${1:-}"

if [ -z "$MODE" ]; then
  echo "Current mode: $(current_demo_mode)"
  echo "Usage: bash scripts/demo-mode.sh reset|append"
  exit 0
fi

case "$MODE" in
  reset|append)
    echo "$MODE" > "$MODE_FILE"
    echo "Demo mode set to: $MODE"
    ;;
  *)
    echo "Invalid mode: $MODE"
    echo "Allowed values: reset, append"
    exit 1
    ;;
esac
