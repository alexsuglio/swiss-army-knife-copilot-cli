#!/usr/bin/env bash
# Purpose: Reset a scenario and print the next commands to run the demo flow.
# Usage: bash scripts/run-scenario.sh <scenario-id>
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SCENARIO_ID="${1:-}"

if [ -z "$SCENARIO_ID" ]; then
  echo "Usage: bash scripts/run-scenario.sh <scenario-id>"
  exit 1
fi

bash "$ROOT_DIR/scripts/demo-reset.sh" "$SCENARIO_ID"

echo
echo "Next steps:"
echo "1) cd $ROOT_DIR/sample-app"
echo "2) copilot"
echo "3) Use prompt from scenarios/scenarios.json for scenario $SCENARIO_ID"

case "$SCENARIO_ID" in
  0)
    echo "4) git status"
    ;;
  1|2|3|4)
    echo "4) npm run test:$SCENARIO_ID"
    ;;
  *)
    echo "4) npm test"
    ;;
esac
