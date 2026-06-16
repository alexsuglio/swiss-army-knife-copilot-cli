# CLI Demo — Instructions

Run `bash setup.sh` from the repo root before your first demo.

---

## Running a scenario

```bash
cd cli
```

Pick a scenario and run the matching test after Copilot makes changes:

| # | Name | Prompt (copy into `copilot`) | Verify |
|---|------|------------------------------|--------|
| 0 | Warmup Explain | `Explain this command and what each part does: find . -type f -name '*.js' \| xargs grep -n 'TODO'` | `git status` stays clean |
| 1 | Refactor | `Refactor totalPrice in src/scenario_1_cli_calculator.js to use reduce, keep behavior unchanged, and keep code easy to read.` | `npm run test:1` |
| 2 | Bug Fix | `Several tests in tests/scenario_2_discount.test.js are failing. Find the bug in src/scenario_2_cli_discount.js and fix only the root cause.` | `npm run test:2` |
| 3 | Feature Add | `Add validateUserProfile to src/scenario_3_cli_validator.js. Required fields: id, name, email. Return { ok, errors }. Add tests for valid input, missing fields, invalid email, and whitespace-only values.` | `npm run test:3` |
| 4 | Advanced Multi-step | `Create or expand tests for src/scenario_4_cli_csvLegacyParser.js, refactor parsing to be safer for malformed rows, and add a short inline comment describing the behavior changes.` | `npm run test:4` |

All prompts and fallbacks are also in `cli/scenarios.json`.

---

## Test commands

```bash
cd cli
npm run test:1      # calculator
npm run test:2      # discount (intentionally failing at baseline)
npm run test:3      # validator
npm run test:4      # CSV parser
npm test            # all
npm run test:baseline  # all except scenario 2
```

---

## Reset between demos

```bash
bash cleanup.sh
```

Or restore a single file with `git checkout HEAD -- cli/src/<file>.js`.

---

## Commit guard

Commits are blocked by default to protect the demo baseline.
To allow a commit intentionally:

```bash
ALLOW_DEMO_COMMIT=1 git commit -m "..."
```
