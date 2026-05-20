# Alex Demo Cheatsheet

This is the quick personal version to keep beside you during the demo. It is written for one presenter moving scenario by scenario without needing to translate the full docs in real time.

## Before You Start

Do this in the repo root:

1. `bash scripts/preflight-check.sh`
2. `bash scripts/init-snapshots.sh`
3. `bash scripts/demo-mode.sh reset`
4. `bash scripts/demo-reset.sh 0`

Then open a terminal in `sample-app` and make sure dependencies are ready:

1. `cd sample-app`
2. `npm install`

What to notice:

- Preflight should complete cleanly.
- Reset mode should be on.
- You should be able to bounce between scenarios and always get back to a known state.

## Overall Rhythm

Use the same rhythm every time:

1. Reset to the scenario.
2. Say what the goal is.
3. Run the prompt.
4. Review what changed.
5. Run the scenario test.
6. Call out what the result proves.

Good transition lines:

- "I am resetting to a clean starting point."
- "I am giving Copilot a focused task."
- "I am reviewing the change before trusting it."
- "I am verifying with tests, not vibes."

## Scenario 0: Warmup Explain

### Goal

Start with a safe, read-only example.

### Before

From repo root:

1. `bash scripts/demo-reset.sh 0`

From `sample-app`:

1. Start Copilot in your terminal flow.
2. Use this prompt:

```text
Explain this command and what each part does: find . -type f -name '*.js' | xargs grep -n 'TODO'
```

### Where

- Terminal Copilot session only.
- No source files should change.

### What to notice

- This is explanation only.
- Copilot should break down the pipeline clearly.
- This is a calm opener before file edits.

### During

- "I am starting with a no-risk prompt so we can see command understanding first."
- "Nothing in the codebase should change here."

### After

From repo root:

1. `git status`

You want a clean working tree.

### Fallback

```text
Explain ls -la
```

## Scenario 1: Refactor

### Goal

Show a readability improvement without changing behavior.

### Before

From repo root:

1. `bash scripts/demo-reset.sh 1`

From `sample-app`:

1. Start Copilot.
2. Use this prompt:

```text
Refactor totalPrice in src/scenario_1_calculator.js to use reduce, keep behavior unchanged, and keep code easy to read.
```

### Where

- Main file: `sample-app/src/scenario_1_calculator.js`
- Test file: `sample-app/tests/scenario_1_calculator.test.js`

### What to notice

- The change should stay narrow.
- The code should read cleaner.
- Tests should stay green.

### During

- "This is a focused refactor, not a rewrite."
- "I want the code simpler, but I do not want behavior drift."
- "I am reviewing the patch before I trust it."

### After

From `sample-app`:

1. `npm run test:1`

What to say:

- "This proves the refactor changed the shape of the code, not the outcome."

### Fallback

```text
Show me the patch first and keep the change minimal.
```

## Scenario 2: Bug Fix

### Goal

Show root-cause debugging from failing tests.

### Before

From repo root:

1. `bash scripts/demo-reset.sh 2`

From `sample-app`:

1. Start Copilot.
2. Use this prompt:

```text
Several tests in tests/scenario_2_discount.test.js are failing. Find the bug in src/scenario_2_discount.js and fix only the root cause.
```

### Where

- Main file: `sample-app/src/scenario_2_discount.js`
- Test file: `sample-app/tests/scenario_2_discount.test.js`

### What to notice

- The ideal fix is small.
- The fix should tie directly to the failing tests.
- This is about restraint.

### During

- "I am using the tests as the signal for where to look."
- "The goal is the smallest fix that solves the real issue."
- "This is where Copilot is most helpful when the prompt stays precise."

### After

From `sample-app`:

1. `npm run test:2`

What to say:

- "The value here is not just that it fixed the bug, but that it stayed close to the root cause."

### Fallback

```text
Here is the failing test output. Give me a minimal patch that fixes only this issue.
```

## Scenario 3: Feature Add

### Goal

Show natural language turning into implementation plus tests.

### Before

From repo root:

1. `bash scripts/demo-reset.sh 3`

From `sample-app`:

1. Start Copilot.
2. Use this prompt:

```text
Add validateUserProfile to src/scenario_3_validator.js. Required fields: id, name, email. Return { ok, errors }. Add tests for valid input, missing fields, invalid email, and whitespace-only values.
```

### Where

- Main file: `sample-app/src/scenario_3_validator.js`
- Test file: `sample-app/tests/scenario_3_validator.test.js`

### What to notice

- The requirement is short but contains several behaviors.
- Good output includes both implementation and tests.
- The `{ ok, errors }` contract is worth pointing out.

### During

- "I am giving a small product requirement in plain language."
- "I want both behavior and proof, so tests matter as much as the implementation."
- "I am watching whether the result handles edge cases like empty strings and bad email formats."

### After

From `sample-app`:

1. `npm run test:3`

What to say:

- "This is a nice example of turning a short spec into working code plus coverage."

### Fallback

```text
Generate the tests first for this requirement. After that, implement the code to satisfy them.
```

## Scenario 4: Advanced Multi-Step

### Goal

Show a longer chain: improve tests, harden implementation, then document behavior.

### Before

From repo root:

1. `bash scripts/demo-reset.sh 4`

From `sample-app`:

1. Start Copilot.
2. Use this prompt:

```text
Create or expand tests for src/scenario_4_csvLegacyParser.js, refactor parsing to be safer for malformed rows, and add a short README section describing behavior changes.
```

### Where

- Main file: `sample-app/src/scenario_4_csvLegacyParser.js`
- Test file: `sample-app/tests/scenario_4_csvLegacyParser.test.js`
- Possible doc update: `README.md`

### What to notice

- This is the most end-to-end scenario.
- It mixes test design, implementation work, and a tiny docs pass.
- It is a good closer if time allows.

### During

- "This prompt bundles a few steps together, so I expect a more end-to-end workflow."
- "I still verify the same way: inspect, test, then summarize what changed."
- "I am looking for safer behavior around malformed CSV rows, not just prettier code."

### After

From `sample-app`:

1. `npm run test:4`

What to say:

- "This shows Copilot helping across the whole loop: tests, code changes, and a small docs update."

### Fallback

```text
Focus only on expanding the tests for malformed rows first.
```

## Between Scenarios

Your reset line is always:

```bash
bash scripts/demo-reset.sh <scenario-id>
```

Examples:

- `bash scripts/demo-reset.sh 1`
- `bash scripts/demo-reset.sh 2`
- `bash scripts/demo-reset.sh 3`
- `bash scripts/demo-reset.sh 4`

If reset is not behaving as expected:

1. `bash scripts/demo-mode.sh reset`
2. Re-run the scenario reset command.

## Core Message

Keep coming back to these:

- Clear prompt.
- Focused change.
- Human review.
- Test verification.
- Easy reset.

## Closing Line

"The pattern is simple: give a clear prompt, review the change, verify with tests, and reset whenever you want a clean start."
