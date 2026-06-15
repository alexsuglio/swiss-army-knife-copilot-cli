# Speaker Script (Read-Aloud Bullets)

## Opening (about 60 seconds)
- Today I will show one reusable sandbox for both Copilot CLI and Copilot Chat in VS Code.
- I will keep control at every step by verifying edits with tests and using scripted resets.
- The repo blocks accidental commits by default so live demo edits stay safe.

## Setup narration
- I am running one setup command so the whole environment is checked and prepared.
- The repo records a baseline branch, enables reset mode, and installs a commit guard.
- This makes the demo repeatable across CLI and IDE workflows.

## CLI track lines
- First I can use the CLI track for a fast terminal-only workflow.
- Each scenario has a known reset branch and a matching verification command.
- I prompt, review, and verify before moving on.

## IDE Chat track lines
- In VS Code, I can use slash commands like `/explain`, `/fix`, and `/tests`.
- I can also use `@workspace` to reason across scripts, source files, tests, and docs.
- The same sample app supports both tracks, so the story stays cohesive.

## Safety lines
- If anything drifts, I can run one clean-slate reset command.
- If I really want to commit, I have to opt in intentionally.
- Those defaults make the repository reusable for the next session instead of disposable.

## Closing lines
- The key pattern is prompt, review, verify, then reset when needed.
- This same sandbox supports beginner demos, advanced workflows, and repeated practice runs.
