# Copilot IDE Chat Demo — Instructions

Run `bash setup.sh` from the repo root before your first demo.  
Open this repo in VS Code, then open Copilot Chat (`Ctrl+Alt+I` / `Cmd+Shift+I`).

---

## Scenarios

### chat-1 · Explain unfamiliar parser
**File:** `ide-chat/src/scenario_4_csvLegacyParser.js`

```
/explain #file:ide-chat/src/scenario_4_csvLegacyParser.js
```
or
```
Explain how this parser treats malformed rows and what tradeoffs it makes.
```
**Verify:** No files changed. Response mentions blank lines, trimming, and malformed-row handling.  
**Fallback:** Highlight the `reduce` block → `/explain #selection`

---

### chat-2 · Fix a targeted bug
**File:** `ide-chat/src/scenario_2_discount.js`

```
/fix The discount helper is adding the wrong amount after rounding. Make the smallest change that makes the tests pass.
```
or
```
Read src/scenario_2_discount.js, find the root cause of the rounding bug, and suggest the smallest safe patch.
```
**Verify:** `node --test ide-chat/tests/scenario_2_discount.test.js` (copy test from cli/tests/ if needed)  
**Fallback:** Show the `applyDiscount` function and ask Chat to find the off-by-one.

---

### chat-3 · Generate tests for an untested utility
**File:** `ide-chat/src/ide_chat_releaseNotes.js`

```
/tests #file:ide-chat/src/ide_chat_releaseNotes.js
```
or
```
Generate node:test coverage for empty input, trimming, optional highlights, and skipped invalid entries in ide_chat_releaseNotes.js.
```
**Verify:** Save the new test file to `ide-chat/tests/` → `node --test ide-chat/tests/<new-file>.test.js`  
**Fallback:** Ask Copilot to list test cases first, then ask it to write `node:test` code.

---

### chat-4 · Multi-file reasoning with @workspace
```
@workspace Where do setup, cleanup, and test verification commands live in this repo?
```
or
```
@workspace If I want to explain how pricing, validation, and parser behavior are covered here, which files should I show and why?
```
**Verify:** Response cites files in both `cli/` and `ide-chat/`.  
**Fallback:** Use `#file` references for `cli/scenarios.json`, `cli/src/scenario_2_discount.js`, and `ide-chat/src/ide_chat_releaseNotes.js`.

---

### chat-5 · Repository instructions walkthrough
**File:** `.github/copilot-instructions.md`

```
What repo-level Copilot instructions are active here, and how should they affect your edits?
```
or
```
Using the repository instructions, propose a safe plan for fixing the bug in ide-chat/src/scenario_2_discount.js without broad refactors.
```
**Verify:** Response mentions minimal edits, testing after changes, and avoiding unrelated churn.  
**Fallback:** Open `.github/copilot-instructions.md` → ask Chat to summarize the top three rules.

---

## Reset between demos

```bash
bash cleanup.sh
```

All scenario data is also in `ide-chat/scenarios.json`.
