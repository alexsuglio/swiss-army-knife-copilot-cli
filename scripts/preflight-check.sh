#!/usr/bin/env bash
# Purpose: Verify the demo sandbox is ready before you present or practice.
# Usage: bash scripts/preflight-check.sh
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
APP_DIR="$ROOT_DIR/sample-app"
SCENARIOS_FILE="$ROOT_DIR/scenarios/scenarios.json"

failures=0
warnings=0

pass() { echo "[PASS] $1"; }
warn() { echo "[WARN] $1"; warnings=$((warnings + 1)); }
fail() { echo "[FAIL] $1"; failures=$((failures + 1)); }

echo "Copilot CLI Demo Sandbox Preflight"
echo "Root: $ROOT_DIR"

if command -v copilot >/dev/null 2>&1; then
  pass "copilot CLI found"
else
  fail "copilot CLI not found"
fi

if command -v gh >/dev/null 2>&1; then
  if gh auth status >/dev/null 2>&1; then
    pass "GitHub auth is active"
  else
    warn "GitHub auth is not active. Run: gh auth login"
  fi
else
  warn "gh CLI not found (recommended for auth checks)"
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

if [ -f "$SCENARIOS_FILE" ]; then
  pass "Scenario registry found"
else
  fail "Scenario registry missing"
fi

if [ -d "$APP_DIR" ]; then
  pass "Sample app directory found"
else
  fail "Sample app directory missing"
fi

if [ -d "$ROOT_DIR/.git" ]; then
  pass "Git repository initialized"
else
  warn "Git repository not initialized yet"
fi

if [ -f "$APP_DIR/package.json" ]; then
  pass "package.json found"
else
  fail "package.json missing"
fi

echo
if [ "$failures" -gt 0 ]; then
  echo "Preflight failed with $failures failure(s) and $warnings warning(s)."
  exit 1
fi

echo "Preflight passed with $warnings warning(s)."
