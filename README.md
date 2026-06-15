# Swiss Army Knife GitHub Copilot 🛠️🧰

A reusable, local-first sandbox for **both GitHub Copilot CLI** and **GitHub Copilot Chat in VS Code**.

This repository keeps the original CLI-demo strengths—scenario registry, reset/append modes, resettable snapshot branches, and a shared Node.js sample app—while adding a curated VS Code Chat track, one primary setup flow, one primary clean-slate reset flow, and commit safeguards that block accidental demo commits by default.

## What this gives you
- One repo for **repeatable Copilot CLI demos**
- One repo for **repeatable VS Code Copilot Chat demos**
- One **setup/bootstrap** command for the whole sandbox
- One **full clean-slate reset** command for the next demo
- A **commit safeguard** that blocks accidental commits unless you intentionally override it
- A shared `sample-app/` that works for both tracks

## Recommended commands
| Goal | Command |
| :--- | :--- |
| Bootstrap the whole sandbox | `bash scripts/demo-setup.sh` |
| Run the combined environment preflight only | `bash scripts/preflight-check.sh` |
| Reset to a CLI scenario | `bash scripts/run-scenario.sh <scenario-id>` |
| Restore the repo to the presenter baseline | `bash scripts/demo-clean-slate.sh` |
| Refresh snapshot branches after intentional baseline updates | `bash scripts/demo-clean-slate.sh --refresh` |
| Temporarily allow an intentional commit | `bash scripts/allow-commits.sh` |
| Re-enable commit blocking | `bash scripts/block-commits.sh` |

Legacy wrappers still work:
- `bash scripts/demo-first-run.sh` → setup wrapper
- `bash scripts/demo-flush.sh` → clean-slate wrapper

## Project layout
- `docs/` — presenter guidance, walkthroughs, and troubleshooting
- `scripts/` — setup, preflight, reset, mode switching, commit-guard helpers, and snapshot management
- `scenarios/scenarios.json` — Copilot CLI scenario registry
- `scenarios/ide-chat-scenarios.json` — VS Code Copilot Chat scenario registry
- `sample-app/` — shared Node.js demo app used by both tracks
- `.githooks/` — pre-commit safeguard installed by setup
- `.github/copilot-instructions.md` — optional repo customization for Chat demos

## Quick start
1. Clone the repo.
2. Run `bash scripts/demo-setup.sh`
3. Choose a track:
   - **CLI track:** follow `docs/walkthrough.md` and `scenarios/scenarios.json`
   - **IDE Chat track:** open the repo in VS Code and follow `docs/vscode-copilot-chat.md` and `scenarios/ide-chat-scenarios.json`
4. When the demo is over, run `bash scripts/demo-clean-slate.sh`

## Setup/bootstrap behavior
`bash scripts/demo-setup.sh` is the primary setup command. It is intentionally safe and idempotent.

It will:
- run a combined preflight for Git, Node.js, npm, GitHub CLI, Copilot CLI, and VS Code availability
- install `sample-app` dependencies with `npm install`
- install the pre-commit safeguard via `git config core.hooksPath .githooks`
- set demo mode back to `reset`
- record the local baseline branch in `.demo-baseline-branch`
- ensure the CLI snapshot branches exist
- reset the sandbox to `scenario-0-init`

Notes:
- Missing **Git**, **Node.js**, or **npm** is a hard failure.
- Missing **Copilot CLI**, **VS Code**, or **GitHub auth/extensions** produces clear warnings so you can finish setup manually.
- The setup flow is local-first. It checks and prepares tools; it does not attempt brittle cross-platform package installs for you.

## Full clean-slate reset
`bash scripts/demo-clean-slate.sh` is the primary “reset everything” command.

It will:
- restore demo mode to `reset`
- re-enable the default commit safeguard
- return to the recorded baseline branch
- discard tracked demo edits and remove untracked non-ignored files
- ensure the scenario snapshot branches exist
- reset the repo to `scenario-0-init`

Use `--refresh` only when you intentionally changed the baseline branch and want all `scenario-N-init` branches rebuilt from it.

## Commit safeguard
This repo is designed to block accidental demo commits by default.

### Default behavior
- Setup installs `.githooks/pre-commit`
- The hook blocks commits unless you intentionally opt in

### Intentionally allow a commit
Option 1:
1. `bash scripts/allow-commits.sh`
2. commit normally
3. `bash scripts/block-commits.sh`

Option 2:
1. `ALLOW_DEMO_COMMIT=1 git commit ...`

This makes ad-hoc demo edits much harder to commit accidentally from either the terminal or the IDE.

## Demo tracks
### 1) Copilot CLI track
Keep using the numbered CLI scenarios in `scenarios/scenarios.json`.

Typical flow:
1. `bash scripts/run-scenario.sh 1`
2. `cd sample-app`
3. `copilot`
4. use the scenario prompt from the registry
5. run the scenario-specific verification command, such as `npm run test:1`

### 2) VS Code Copilot Chat track
Open the repository in VS Code and use the curated scenarios in `scenarios/ide-chat-scenarios.json`.

Included Chat demos:
- `/explain` on the CSV parser
- `/fix` on the discount bug
- `/tests` for an untested utility
- `@workspace` for repo-wide reasoning
- optional repo customization with `.github/copilot-instructions.md`

Start here:
- `docs/vscode-copilot-chat.md`
- `scenarios/ide-chat-scenarios.json`

## Shared sample app
`sample-app/` stays as the shared codebase for both tracks.

Scenario files:
- `src/scenario_1_calculator.js`
- `src/scenario_2_discount.js`
- `src/scenario_3_validator.js`
- `src/scenario_4_csvLegacyParser.js`
- `src/ide_chat_releaseNotes.js` (untested utility for `/tests` demos)

Matching tests live in `sample-app/tests/` for the numbered CLI scenarios.

## Test commands
Run from `sample-app/`:
- `npm run test:1`
- `npm run test:2`
- `npm run test:3`
- `npm run test:4`
- `npm run test:baseline`
- `npm run test:all`
- `npm test`

`npm run test:baseline` is the “presenter baseline” suite. Scenario 2 still exists as an intentional fix exercise, so it stays separate.

## Additional docs
- `docs/overview.md`
- `docs/walkthrough.md`
- `docs/vscode-copilot-chat.md`
- `docs/speaker-script.md`
- `docs/troubleshooting.md`

## Notes
- The reset model is local-first and presenter-friendly.
- Snapshot branches now follow a recorded baseline branch instead of assuming `main` always exists locally.
- If you intentionally update the repo baseline, run `bash scripts/demo-clean-slate.sh --refresh` from the baseline branch.
