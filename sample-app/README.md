# Sample App

This app is intentionally simple and scenario-oriented.

## Run tests

1. cd sample-app
2. npm run test:1
3. npm run test:2
4. npm run test:3
5. npm run test:4
6. npm run test:all

## Files used in demos

- src/scenario_1_calculator.js: refactor target
- src/scenario_2_discount.js: bug-fix target with intentional baseline failure
- src/scenario_3_validator.js: feature-add target
- src/scenario_4_csvLegacyParser.js: advanced multi-step target

## Scenario notes

- Scenario 1 starts passing and is meant for a behavior-preserving refactor.
- Scenario 2 starts failing on purpose so the bug is visible before the fix.
- Scenario 3 starts with working validation behavior and broader tests.
- Scenario 4 starts with safer parsing and expanded malformed-row coverage.
