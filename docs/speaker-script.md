# Speaker Script (Read-Aloud Bullets)

## Opening (about 60 seconds)

- Today I will show a reusable Copilot CLI sandbox that I can run repeatedly.
- I will run four core scenarios and one optional advanced scenario.
- I will keep control at every step by verifying edits with tests.

## Setup narration

- I am running preflight so we confirm tools, auth, and runtime are ready.
- I am setting mode to reset so every scenario starts from a known clean state.
- This makes the demo repeatable and safe across many sessions.

## Scenario 0 warmup lines

- First, I am showing read-only usage.
- I ask Copilot to explain a shell pipeline.
- Notice this is terminal-only and no files should change.
- I confirm with git status.

## Scenario 1 refactor lines

- Next I reset to scenario 1 baseline.
- I ask for a focused refactor in calculator logic.
- I review the proposed changes before acceptance.
- I run tests to prove behavior is preserved.

## Scenario 2 bug-fix lines

- Now I reset to scenario 2 baseline.
- I give Copilot a failure-oriented prompt.
- The goal is minimal root-cause change, not broad rewrites.
- I validate by rerunning tests.

## Scenario 3 feature-add lines

- I reset to scenario 3 baseline.
- I provide a requirement in plain language.
- Copilot translates requirements into implementation plus tests.
- I run tests and quickly review the error messages output contract.

## Scenario 4 advanced lines (optional)

- If timing allows, I show a multi-step parser improvement.
- I ask for tests, safer parsing behavior, and a short documentation update.
- This demonstrates end-to-end workflow under one request.

## Fallback lines

- If latency is high, I time-box and switch to a smaller prompt.
- If output is unexpected, I decline, clarify constraints, and rerun.
- If anything drifts, I reset and continue from a clean baseline.

## Closing lines

- The key pattern is prompt, review, verify, then proceed.
- The sandbox is reusable because reset is automated.
- This same structure scales from beginner demos to advanced workflows.
