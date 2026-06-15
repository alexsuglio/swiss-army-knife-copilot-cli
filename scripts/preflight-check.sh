#!/usr/bin/env bash
# Purpose: Verify the combined Copilot demo sandbox is ready before you present or practice.
# Usage: bash scripts/preflight-check.sh
set -euo pipefail

source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/demo-common.sh"

failures=0
warnings=0

pass() { echo "[PASS] $1"; }
warn() { echo "[WARN] $1"; warnings=$((warnings + 1)); }
fail() { echo "[FAIL] $1"; failures=$((failures + 1)); }

cd "$ROOT_DIR"

echo "Swiss Army Knife GitHub Copilot Preflight"
echo "Root: $ROOT_DIR"

if command -v git >/dev/null 2>&1; then
  pass "Git found"
else
  fail "Git not found"
fi

if [ -d "$ROOT_DIR/.git" ]; then
  pass "Git repository initialized"
else
  fail "Git repository not initialized"
fi

if command -v node >/dev/null 2>&1; then
  node_major="$(node -v | sed 's/^v//' | cut -d. -f1)"
  if [ "$node_major" -ge 20 ]; then
    pass "Node.js version is compatible"
  else
    fail "Node.js >= 20 required"
  fi
else
  fail "Node.js not found"
fi

if command -v npm >/dev/null 2>&1; then
  pass "npm found"
else
  fail "npm not found"
fi

if [ -f "$CLI_SCENARIOS_FILE" ]; then
  pass "CLI scenario registry found"
else
  fail "CLI scenario registry missing"
fi

if [ -f "$IDE_SCENARIOS_FILE" ]; then
  pass "IDE chat scenario registry found"
else
  fail "IDE chat scenario registry missing"
fi

if [ -d "$APP_DIR" ]; then
  pass "Shared sample app directory found"
else
  fail "Shared sample app directory missing"
fi

if [ -f "$APP_DIR/package.json" ]; then
  pass "sample-app/package.json found"
else
  fail "sample-app/package.json missing"
fi

baseline_branch="$(resolve_baseline_branch)"
if git show-ref --verify --quiet "refs/heads/$baseline_branch"; then
  pass "Baseline branch available: $baseline_branch"
else
  warn "Baseline branch '$baseline_branch' is not available locally yet"
fi

if command -v gh >/dev/null 2>&1; then
  pass "GitHub CLI found"
  if gh auth status >/dev/null 2>&1; then
    pass "GitHub CLI auth is active"
  else
    warn "GitHub CLI auth is not active. Run: gh auth login"
  fi
else
  warn "GitHub CLI not found (recommended for auth checks and Copilot CLI installs)"
fi

if command -v copilot >/dev/null 2>&1; then
  pass "Copilot CLI found"
else
  warn "Copilot CLI not found. Install it before running the CLI track."
fi

if command -v code >/dev/null 2>&1; then
  pass "VS Code CLI found"
  extensions="$(code --list-extensions 2>/dev/null || true)"
  if printf '%s\n' "$extensions" | grep -qi '^GitHub\.copilot$'; then
    pass "GitHub Copilot VS Code extension found"
  else
    warn "GitHub Copilot VS Code extension not detected"
  fi

  if printf '%s\n' "$extensions" | grep -qi '^GitHub\.copilot-chat$'; then
    pass "GitHub Copilot Chat VS Code extension found"
  else
    warn "GitHub Copilot Chat VS Code extension not detected"
  fi
else
  warn "VS Code CLI not found. Install VS Code or add 'code' to PATH for the IDE Chat track."
fi

if git config --get core.hooksPath >/dev/null 2>&1; then
  pass "Git hooks path configured: $(git config --get core.hooksPath)"
else
  warn "Git hooks path is not configured yet. Run: bash scripts/install-commit-guard.sh"
fi

echo
if [ "$failures" -gt 0 ]; then
  echo "Preflight failed with $failures failure(s) and $warnings warning(s)."
  exit 1
fi

echo "Preflight passed with $warnings warning(s)."
