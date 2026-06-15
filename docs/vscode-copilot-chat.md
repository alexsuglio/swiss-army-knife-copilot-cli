# VS Code Copilot Chat Track

Use this track when you want to show GitHub Copilot Chat features inside VS Code against a safe local repository.

## Before you start
1. Run `bash scripts/demo-setup.sh`
2. Open the repository in VS Code
3. Sign in to GitHub Copilot in VS Code if needed
4. Open `scenarios/ide-chat-scenarios.json`

## Suggested flow
### Chat 1 — `/explain`
- File: `sample-app/src/scenario_4_csvLegacyParser.js`
- Goal: show understanding before editing
- Prompt: `/explain #file:sample-app/src/scenario_4_csvLegacyParser.js`
- Verify: the answer should mention trimming, blank-line handling, and skipped malformed rows

### Chat 2 — `/fix`
- Files: `sample-app/src/scenario_2_discount.js`, `sample-app/tests/scenario_2_discount.test.js`
- Goal: show a minimal root-cause fix
- Prompt: `/fix The discount helper is adding the wrong amount after rounding. Make the smallest change that makes the failing tests pass.`
- Verify: `cd sample-app && npm run test:2`

### Chat 3 — `/tests`
- File: `sample-app/src/ide_chat_releaseNotes.js`
- Goal: generate a new test suite for an untested utility
- Prompt: `/tests #file:sample-app/src/ide_chat_releaseNotes.js`
- Verify: run only the newly generated tests with `node --test <new-test-file>`

### Chat 4 — `@workspace`
- Scope: whole repo
- Goal: show multi-file reasoning
- Prompt: `@workspace Where do reset behavior, commit safeguards, and sample-app verification commands live in this repo?`
- Verify: the answer should mention scripts, docs, and `sample-app/package.json`

### Chat 5 — Optional customization
- File: `.github/copilot-instructions.md`
- Goal: show how repo instructions shape behavior
- Prompt: `Using the repository instructions, propose a safe plan for fixing scenario 2 without broad refactors.`
- Verify: the answer should mention minimal edits, testing, and limited scope

## Reset when you are done
Run `bash scripts/demo-clean-slate.sh`
