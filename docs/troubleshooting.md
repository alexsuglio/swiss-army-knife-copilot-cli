# Troubleshooting

## Setup warnings for Copilot CLI, VS Code, or extensions
- Run `bash scripts/preflight-check.sh` to see the exact warning again.
- Install the missing tool locally, then re-run `bash scripts/demo-setup.sh`.
- Core setup only hard-fails on missing Git, Node.js, or npm.

## GitHub auth issues
- Run `gh auth login`
- Verify with `gh auth status`
- Re-run the preflight

## Commit is blocked on purpose
- The repository installs `.githooks/pre-commit` during setup.
- To intentionally commit, run `bash scripts/allow-commits.sh`
- When finished, run `bash scripts/block-commits.sh`
- For a one-off terminal commit, use `ALLOW_DEMO_COMMIT=1 git commit ...`

## Snapshot branch missing
- Run: `bash scripts/init-snapshots.sh`
- Retry reset: `bash scripts/demo-reset.sh <id>`

## Need a full presenter reset
- Run: `bash scripts/demo-clean-slate.sh`
- Use `--refresh` only after intentional baseline updates

## Scenario test failures after edits
- Ask Copilot for a minimal fix tied to the failing test output
- Re-run the scenario-specific test command, such as `npm run test:2`
- If needed, reset the scenario and retry

## Need iterative practice instead of reset
- Set append mode: `bash scripts/demo-mode.sh append`
- Return to deterministic mode later: `bash scripts/demo-mode.sh reset`
