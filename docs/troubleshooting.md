# Troubleshooting

## Preflight fails: copilot not found

- Install Copilot CLI and reopen terminal.
- Re-run: bash scripts/preflight-check.sh

## Auth issues

- Run gh auth login
- Verify with gh auth status
- Re-run preflight

## Snapshot branch missing

- Run: bash scripts/init-snapshots.sh
- Retry reset: bash scripts/demo-reset.sh <id>

## Test failures after edits

- Ask Copilot for minimal fix tied to failing test output
- Re-run npm test
- If needed, reset scenario and retry

## Slow model responses

- Use scenario 0 or 1 fallback prompts
- Time-box waiting to 60-90 seconds
- Move to next scenario if needed

## Need iterative practice instead of reset

- Set append mode: bash scripts/demo-mode.sh append
- Return to deterministic mode later: bash scripts/demo-mode.sh reset
