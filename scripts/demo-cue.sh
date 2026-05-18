#!/usr/bin/env bash
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
    echo "Prompt: Refactor totalPrice in src/calculator.js to use reduce, keep behavior unchanged, and keep code easy to read."
    echo "Verify: npm test"
    ;;
  2)
    echo "Scenario 2: Bug Fix"
    echo "Say: I will give a failure-oriented prompt and request a minimal root-cause patch."
    echo "Prompt: One test in tests/discount.test.js is failing. Find the bug in src/discount.js and fix only the root cause."
    echo "Verify: npm test"
    ;;
  3)
    echo "Scenario 3: Feature Add"
    echo "Say: I will convert a product requirement into implementation plus tests."
    echo "Prompt: Add validateUserProfile to src/validator.js. Required fields: id, name, email. Return { ok, errors }. Add tests for valid input, missing fields, and invalid email."
    echo "Verify: npm test"
    ;;
  4)
    echo "Scenario 4: Advanced Multi-step"
    echo "Say: I will demonstrate a multi-step flow: tests, safer parser behavior, and short docs update."
    echo "Prompt: Create/expand tests for src/csvLegacyParser.js, refactor parsing to be safer for malformed rows, and add a short README section describing behavior changes."
    echo "Verify: npm test"
    ;;
  *)
    echo "Unknown scenario id: $SCENARIO_ID"
    echo "Allowed ids: 0, 1, 2, 3, 4"
    exit 1
    ;;
esac