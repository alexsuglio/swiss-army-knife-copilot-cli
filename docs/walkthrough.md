# Master Walkthrough (30 Minutes)

Audience: mixed new and experienced engineers.

## Demo timeline

- 0:00-3:00 Intro and environment framing
- 3:00-6:00 Scenario 0 warmup
- 6:00-12:00 Scenario 1 refactor
- 12:00-18:00 Scenario 2 bug fix
- 18:00-25:00 Scenario 3 feature add
- 25:00-30:00 Scenario 4 advanced or Q and A buffer

## Before audience joins

1. bash scripts/preflight-check.sh
2. bash scripts/init-snapshots.sh
3. bash scripts/demo-mode.sh reset
4. bash scripts/demo-reset.sh 0

## Scenario format

Use this pattern every time:

- Context: what problem you are solving
- Action: exact prompt or command
- Where: terminal, file changes, and branch state
- Verify: observable proof
- Recover: what to do if output is unexpected

## Scenario 0 Warmup Explain

Context:
- Goal is to show read-only command understanding.

Action:
- Start copilot in sample-app.
- Use prompt from scenarios/scenarios.json with id 0.

Where:
- Input is in terminal REPL.
- No source files should be modified.

Verify:
- Run git status in repo root; should be clean.

Recover:
- If response is slow, switch to a simpler explain request.

## Scenario 1 Refactor

Context:
- Improve readability without changing behavior.

Action:
- Reset: bash scripts/demo-reset.sh 1
- Prompt scenario 1 text.

Where:
- Primary file is sample-app/src/calculator.js.

Verify:
- cd sample-app
- npm test

Recover:
- Ask Copilot to provide diff first, then apply after review.

## Scenario 2 Bug Fix

Context:
- Show root-cause fix from test signal.

Action:
- Reset: bash scripts/demo-reset.sh 2
- Prompt scenario 2 text.

Where:
- Primary file is sample-app/src/discount.js.

Verify:
- npm test

Recover:
- Paste failing test message and ask for minimal patch only.

## Scenario 3 Feature Add

Context:
- Turn natural language requirement into tested code.

Action:
- Reset: bash scripts/demo-reset.sh 3
- Prompt scenario 3 text.

Where:
- Primary file is sample-app/src/validator.js.
- New or updated tests in sample-app/tests/validator.test.js.

Verify:
- npm test

Recover:
- Ask Copilot to generate tests first, implementation second.

## Scenario 4 Advanced Multi-step

Context:
- Demonstrate multi-step reasoning with validation.

Action:
- Reset: bash scripts/demo-reset.sh 4
- Prompt scenario 4 text.

Where:
- Primary file is sample-app/src/csvLegacyParser.js.
- Optional docs update in README.

Verify:
- npm test

Recover:
- Time-box to test expansion only if latency is high.

## End-of-demo close

- Recap: request clarity + verification + controlled approval
- Show reset: bash scripts/demo-reset.sh 1
- Mention reuse: same sandbox can run unlimited times with reset mode
