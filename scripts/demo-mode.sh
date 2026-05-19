#!/usr/bin/env bash
# Purpose: Switch between destructive reset mode and keep-my-work append mode.
# Usage: bash scripts/demo-mode.sh reset|append
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
MODE_FILE="$ROOT_DIR/.demo-mode"
MODE="${1:-}"

if [ -z "$MODE" ]; then
  if [ -f "$MODE_FILE" ]; then
    echo "Current mode: $(cat "$MODE_FILE")"
  else
    echo "Current mode: reset"
  fi
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
