# Demo Overview

This repository is a reusable sandbox for two GitHub Copilot demo tracks built around one shared codebase.

## Track summary
| Track | Best for | Primary assets |
| --- | --- | --- |
| Copilot CLI | Terminal-first demos, prompt refinement, scenario resets | `scenarios/scenarios.json`, `docs/walkthrough.md`, `scripts/run-scenario.sh` |
| VS Code Copilot Chat | Slash commands, `@workspace`, guided code exploration, Chat-first workflows | `scenarios/ide-chat-scenarios.json`, `docs/vscode-copilot-chat.md`, `.github/copilot-instructions.md` |

## Presenter-friendly defaults
- `reset` mode is the default so every CLI scenario can start clean.
- The commit guard is installed by setup and blocks accidental commits until intentionally overridden.
- `sample-app/` is the only codebase you need during live demos.
- `scripts/demo-clean-slate.sh` restores the repo to a known presenter baseline.

## Recommended presenter flow
1. Run `bash scripts/demo-setup.sh`
2. Pick either the CLI or IDE Chat track
3. Keep verification visible by running tests after edits
4. End with `bash scripts/demo-clean-slate.sh`

## Files worth showing on screen
- `README.md` for the big picture
- `scenarios/scenarios.json` for CLI prompts
- `scenarios/ide-chat-scenarios.json` for VS Code Chat prompts
- `sample-app/` for all code edits
- `scripts/demo-clean-slate.sh` and `.githooks/pre-commit` for safety/reset storytelling
