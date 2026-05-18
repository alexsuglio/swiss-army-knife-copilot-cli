# Copilot CLI Demo Sandbox

A reusable, local-first playground for demonstrating Copilot CLI to new and experienced engineers.

## What this gives you

- A 30-minute demo path with clear scenarios
- Hard reset by default so every run starts clean
- Optional append mode for practice runs
- One master walkthrough and one read-aloud speaker script

## Project layout

- scripts/: automation for preflight, reset, mode, and snapshots
- scenarios/: canonical prompts and expected outcomes
- sample-app/: Node.js app used for all live edits
- docs/: walkthrough, speaker script, and troubleshooting

## Quick start

1. cd /Users/alexsuglio/copilot-cli-demo-sandbox
2. bash scripts/preflight-check.sh
3. bash scripts/init-snapshots.sh
4. bash scripts/demo-reset.sh 0
5. Open a terminal in sample-app and run npm install
6. Start the walkthrough in docs/walkthrough.md

## Demo modes

- reset (default): always restore exact baseline state before a scenario
- append: keep current changes and continue iteratively

Switch modes:

- bash scripts/demo-mode.sh reset
- bash scripts/demo-mode.sh append

## Typical live run

1. bash scripts/demo-reset.sh 1
2. cd sample-app
3. copilot
4. Use prompt text from scenarios/scenarios.json
5. Verify with npm test

## Notes

- The scripts are designed for macOS and bash/zsh terminals.
- If you are presenting, follow docs/speaker-script.md line by line.
