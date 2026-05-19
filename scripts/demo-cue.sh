#!/usr/bin/env bash
# Purpose: Print a short cue card with what to say, prompt, and verify step for a scenario.
# Usage: bash scripts/demo-cue.sh <scenario-id>
set -euo pipefail

SCENARIO_ID="${1:-}"

if [ -z "$SCENARIO_ID" ]; then
  echo "Usage: bash scripts/demo-cue.sh <scenario-id>"
  exit 1
fi

case "$SCENARIO_ID" in
  0)
    echo "Scenario 0: Warmup Explain"
    echo "Say: I am starting with a read-only command explanation so we can see Copilot CLI behavior without file edits."
    echo "Prompt: Explain this command and what each part does: find . -type f -name '*.js' | xargs grep -n 'TODO'"
    echo "Verify: git status remains clean."
    ;;
  1)
    echo "Scenario 1: Refactor"
    echo "Say: I will ask for a focused refactor and then verify behavior with tests."
    echo "Prompt: Refactor totalPrice in src/scenario_1_calculator.js to use reduce, keep behavior unchanged, and keep code easy to read."
    echo "Verify: npm run test:1"
    ;;
  2)
    echo "Scenario 2: Bug Fix"
    echo "Say: I will give a failure-oriented prompt and request a minimal root-cause patch."
    echo "Prompt: Several tests in tests/scenario_2_discount.test.js are failing. Find the bug in src/scenario_2_discount.js and fix only the root cause."
    echo "Verify: npm run test:2"
    ;;
  3)
    echo "Scenario 3: Feature Add"
    echo "Say: I will convert a product requirement into implementation plus tests."
    echo "Prompt: Add validateUserProfile to src/scenario_3_validator.js. Required fields: id, name, email. Return { ok, errors }. Add tests for valid input, missing fields, invalid email, and whitespace-only values."
    echo "Verify: npm run test:3"
    ;;
  4)
    echo "Scenario 4: Advanced Multi-step"
    echo "Say: I will demonstrate a multi-step flow: tests, safer parser behavior, and short docs update."
    echo "Prompt: Create or expand tests for src/scenario_4_csvLegacyParser.js, refactor parsing to be safer for malformed rows, and add a short README section describing behavior changes."
    echo "Verify: npm run test:4"
    ;;
  *)
    echo "Unknown scenario id: $SCENARIO_ID"
    echo "Allowed ids: 0, 1, 2, 3, 4"
    exit 1
    ;;
esac