# Copilot CLI Walkthrough

Audience: mixed new and experienced engineers.

This file is the **CLI track walkthrough**. For the VS Code Chat track, use `docs/vscode-copilot-chat.md`.

## Before audience joins
1. `bash scripts/demo-setup.sh`
2. Confirm you land on `scenario-0-init`
3. Open `scenarios/scenarios.json`

## Scenario format
Use this pattern every time:
- Context: what problem you are solving
- Action: exact prompt or command
- Where: terminal, file changes, and branch state
- Verify: observable proof
- Recover: what to do if output is unexpected

## Branch guide
For each CLI scenario, you should be on that scenario's matching snapshot branch:
- Scenario 0 -> `scenario-0-init`
- Scenario 1 -> `scenario-1-init`
- Scenario 2 -> `scenario-2-init`
- Scenario 3 -> `scenario-3-init`
- Scenario 4 -> `scenario-4-init`

You normally do not need to check these out manually. Running `bash scripts/demo-reset.sh <scenario-id>` will reset the repo and move you onto the correct branch when reset mode is enabled.

## Typical CLI run
1. `bash scripts/demo-reset.sh 1`
2. `cd sample-app`
3. `copilot`
4. Use the prompt from `scenarios/scenarios.json`
5. Run the scenario-specific test command

## Scenarios
### Scenario 0 — Warmup Explain
- Goal: show read-only command understanding
- Verify: `git status` remains clean

### Scenario 1 — Refactor
- File: `sample-app/src/scenario_1_calculator.js`
- Verify: `cd sample-app && npm run test:1`

### Scenario 2 — Bug Fix
- File: `sample-app/src/scenario_2_discount.js`
- Verify: `cd sample-app && npm run test:2`

### Scenario 3 — Feature Add
- File: `sample-app/src/scenario_3_validator.js`
- Verify: `cd sample-app && npm run test:3`

### Scenario 4 — Advanced Multi-step
- File: `sample-app/src/scenario_4_csvLegacyParser.js`
- Verify: `cd sample-app && npm run test:4`

## End-of-demo close
- Recap: prompt, review, verify, then proceed
- Show `bash scripts/demo-clean-slate.sh`
- Mention that the same sandbox also supports a VS Code Chat track
