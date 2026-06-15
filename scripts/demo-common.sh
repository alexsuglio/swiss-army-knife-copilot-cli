#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
APP_DIR="$ROOT_DIR/sample-app"
MODE_FILE="$ROOT_DIR/.demo-mode"
BASELINE_FILE="$ROOT_DIR/.demo-baseline-branch"
COMMIT_OVERRIDE_FILE="$ROOT_DIR/.demo-allow-commits"
CLI_SCENARIOS_FILE="$ROOT_DIR/scenarios/scenarios.json"
IDE_SCENARIOS_FILE="$ROOT_DIR/scenarios/ide-chat-scenarios.json"

ensure_git_repo() {
  if [ ! -d "$ROOT_DIR/.git" ]; then
    echo "Git repository not initialized."
    exit 1
  fi
}

resolve_baseline_branch() {
  if [ -f "$BASELINE_FILE" ]; then
    local saved_branch
    saved_branch="$(tr -d '[:space:]' < "$BASELINE_FILE")"
    if [ -n "$saved_branch" ]; then
      echo "$saved_branch"
      return 0
    fi
  fi

  if git show-ref --verify --quiet refs/heads/main; then
    echo "main"
    return 0
  fi

  local remote_head=""
  remote_head="$(git symbolic-ref --quiet --short refs/remotes/origin/HEAD 2>/dev/null || true)"
  if [ -n "$remote_head" ]; then
    echo "${remote_head#origin/}"
    return 0
  fi

  git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "main"
}

write_baseline_branch() {
  printf '%s\n' "$1" > "$BASELINE_FILE"
}

current_demo_mode() {
  if [ -f "$MODE_FILE" ]; then
    cat "$MODE_FILE"
  else
    echo "reset"
  fi
}
