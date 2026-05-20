# Copilot CLI Demo Swiss Army Knife 🛠️ 🧰

A reusable, local-first playground for demonstrating Copilot CLI to new and experienced engineers.

## What this gives you
- A 30-minute demo path with clear scenarios
- Hard reset by default so every run starts clean
- Optional append mode for practice runs
- One master walkthrough and one read-aloud speaker script
- A universal branch model where every scenario branch mirrors the same repo contents

## Project layout
- scripts/: automation for preflight, reset, mode, and snapshots
- scenarios/: canonical prompts and expected outcomes
- sample-app/: Node.js app used for all live edits
- docs/: walkthrough, speaker script, and troubleshooting

## Scenario file layout
- `sample-app/src/scenario_1_calculator.js`
- `sample-app/src/scenario_2_discount.js`
- `sample-app/src/scenario_3_validator.js`
- `sample-app/src/scenario_4_csvLegacyParser.js`
- Matching tests live in `sample-app/tests/` with the same numbered names.

## Quick start
| Step | Purpose |
| :--- | :--- |
| 1. `cd swiss-army-knife-copilot-cli` | Enters the project root directory |
| 2. `bash scripts/preflight-check.sh` | Verifies required tools and environment |
| 3. `bash scripts/init-snapshots.sh` | Creates scenario snapshot branches if missing |
| 4. `bash scripts/demo-reset.sh 0` | Resets repo to scenario 0 baseline |
| 5. Open a terminal in `sample-app` and run `npm install` | Prepares Node.js app dependencies (none by default) |
| 6. Start the walkthrough in `docs/walkthrough.md` | Begins the guided demo |

## Demo modes
- reset (default): always restore exact baseline state before a scenario
- append: keep current changes and continue iteratively

## Branch model
- `main` is the source of truth for the entire sandbox.
- `scenario-0-init` through `scenario-4-init` are reset branches that mirror `main`.
- Scripts, docs, sample app files, and helper shell files are intended to be the same across all branches.
- Scenario differences come from which prompt you run, not from branch-specific file layouts.
- If you add or change repo files, run `bash scripts/init-snapshots.sh --refresh` (from `main`) to refresh all scenario branches from `main`.

Snapshot safety behavior:

- `bash scripts/init-snapshots.sh` creates missing `scenario-N-init` branches only.
- It does not auto-commit your local changes.
- It does not move existing scenario branches unless you pass `--refresh`.

Switch modes:

- bash scripts/demo-mode.sh reset
- bash scripts/demo-mode.sh append

## Typical live run
1. bash scripts/demo-reset.sh 1
2. cd sample-app
3. copilot
4. Use prompt text from scenarios/scenarios.json
5. Verify with npm run test:1

## When you're done with the demo

If you want the sandbox back in a clean, brand-new state for the next run:

1. git checkout main
2. bash scripts/demo-mode.sh reset
3. bash scripts/init-snapshots.sh
4. bash scripts/demo-reset.sh 0

This puts you back on a clean scenario baseline with reset mode enabled.

If you changed repo files on `main` and want every scenario branch refreshed from that updated baseline:

1. git checkout main
2. Make sure your working tree is clean
3. bash scripts/init-snapshots.sh --refresh
4. bash scripts/demo-reset.sh 0

Use `--refresh` only when you intentionally want to move existing `scenario-N-init` branches to match the current `main` branch.

## If you need to reset a scenario

If a scenario gets messy during a demo or practice run:

1. Return to the repo root
2. Run `bash scripts/demo-reset.sh <scenario-id>`

Examples:

- `bash scripts/demo-reset.sh 1`
- `bash scripts/demo-reset.sh 2`
- `bash scripts/demo-reset.sh 3`
- `bash scripts/demo-reset.sh 4`

This restores that scenario back to its baseline branch so you can retry the prompt from a known clean state.

If reset does not happen, check whether append mode is enabled:

1. Run `bash scripts/demo-mode.sh reset`
2. Re-run `bash scripts/demo-reset.sh <scenario-id>`

## Test commands
- `npm run test:1` runs only scenario 1 tests.
- `npm run test:2` runs only scenario 2 tests.
- `npm run test:3` runs only scenario 3 tests.
- `npm run test:4` runs only scenario 4 tests.
- `npm run test:all` runs the full suite.
- `npm test` also runs the full suite.

## Scenario behavior notes
- Scenario 1 starts green and is meant for a refactor-only demo.
- Scenario 2 starts with an intentional bug so the failure is visible before the fix.
- Scenario 3 includes expanded validation coverage.
- Scenario 4 includes expanded malformed-row parser coverage.

## Notes

- The scripts are designed for macOS and bash/zsh terminals.
- If you are presenting, follow docs/speaker-script.md line by line.
- If you ever notice a helper script missing after a reset, run `bash scripts/init-snapshots.sh` from `main` and reset again.
