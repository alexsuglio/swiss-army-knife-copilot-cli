#!/usr/bin/env bash
# setup.sh — One-time setup for the Swiss Army Knife GitHub Copilot demo sandbox.
# Usage: bash setup.sh
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

pass() { echo "[PASS] $1"; }
warn() { echo "[WARN] $1"; }
fail() { echo "[FAIL] $1"; FAILURES=$((FAILURES + 1)); }
FAILURES=0

echo "Swiss Army Knife — Demo Setup"
echo "Root: $ROOT_DIR"
echo

# ── Preflight checks ──────────────────────────────────────────────────────────
echo "==> Preflight"

if command -v git >/dev/null 2>&1 && [ -d "$ROOT_DIR/.git" ]; then
  pass "Git repository found"
else
  fail "Git repository not found. Clone the repo first."
fi

if command -v node >/dev/null 2>&1; then
  node_major="$(node -v | sed 's/^v//' | cut -d. -f1)"
  if [ "$node_major" -ge 20 ]; then
    pass "Node.js $(node -v)"
  else
    fail "Node.js >= 20 required (found $(node -v))"
  fi
else
  fail "Node.js not found"
fi

command -v npm >/dev/null 2>&1 && pass "npm found" || fail "npm not found"
command -v gh  >/dev/null 2>&1 && pass "GitHub CLI found" || warn "GitHub CLI not found (recommended)"

if command -v gh >/dev/null 2>&1; then
  gh auth status >/dev/null 2>&1 && pass "GitHub CLI authenticated" || warn "GitHub CLI not authenticated — run: gh auth login"
fi

command -v copilot >/dev/null 2>&1 && pass "Copilot CLI found" || warn "Copilot CLI not found — install before running CLI track"

if command -v code >/dev/null 2>&1; then
  pass "VS Code CLI found"
  exts="$(code --list-extensions 2>/dev/null || true)"
  printf '%s\n' "$exts" | grep -qi '^GitHub\.copilot$'      && pass "Copilot extension found"      || warn "Copilot extension not detected"
  printf '%s\n' "$exts" | grep -qi '^GitHub\.copilot-chat$' && pass "Copilot Chat extension found" || warn "Copilot Chat extension not detected"
else
  warn "VS Code CLI not found — add 'code' to PATH for IDE Chat track"
fi

if [ "$FAILURES" -gt 0 ]; then
  echo
  echo "Setup aborted: $FAILURES preflight failure(s). Fix the above and re-run."
  exit 1
fi

echo

# ── Install dependencies ──────────────────────────────────────────────────────
echo "==> Installing CLI blade dependencies (cli/)"
(cd "$ROOT_DIR/cli" && npm install)

echo
echo "==> Installing IDE Chat blade dependencies (ide-chat/)"
(cd "$ROOT_DIR/ide-chat" && npm install)

echo

# ── Commit safeguard ──────────────────────────────────────────────────────────
echo "==> Installing commit safeguard"
git -C "$ROOT_DIR" config core.hooksPath .githooks
echo "Commits are blocked by default. To allow one: ALLOW_DEMO_COMMIT=1 git commit"

echo
echo "Demo sandbox is ready."
echo
echo "  CLI track:      open cli/instructions.md"
echo "  IDE Chat track: open ide-chat/instructions.md"
echo
echo "When done: bash cleanup.sh"
