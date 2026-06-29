#!/usr/bin/env bash
# Herdr space sessionizer - select a project under ~/dev and focus/create a
# matching Herdr workspace (space). Intended for the zsh `f` shortcut.
set -euo pipefail

PROJECT_ROOTS=("$HOME/dev")

existing_roots=()
for root in "${PROJECT_ROOTS[@]}"; do
    [ -d "$root" ] && existing_roots+=("$root")
done

[ "${#existing_roots[@]}" -eq 0 ] && exit 0

project_path=$(find "${existing_roots[@]}" -mindepth 1 -maxdepth 1 -type d -printf '%p\n' 2>/dev/null | \
    sort -u | \
    fzf --preview 'eza --tree --level=1 --color=always {}' \
        --bind 'ctrl-d:preview-half-page-down,ctrl-u:preview-half-page-up')

[ -z "$project_path" ] && exit 0

space_label="${project_path##*/}"

ensure_herdr_server() {
    if herdr status server >/dev/null 2>&1; then
        return
    fi

    nohup herdr server >/tmp/herdr-sessionizer.log 2>&1 &

    for _ in {1..50}; do
        herdr status server >/dev/null 2>&1 && return
        sleep 0.1
    done

    echo "Herdr server did not start. See /tmp/herdr-sessionizer.log" >&2
    exit 1
}

find_space_id() {
    herdr workspace list 2>/dev/null | python3 -c '
import json
import sys

label = sys.argv[1]
try:
    data = json.load(sys.stdin)
except Exception:
    sys.exit(0)

for workspace in data.get("result", {}).get("workspaces", []):
    if workspace.get("label") == label:
        print(workspace.get("workspace_id", ""))
        break
' "$space_label"
}

ensure_herdr_server

space_id=$(find_space_id)
if [ -n "$space_id" ]; then
    herdr workspace focus "$space_id" >/dev/null
else
    herdr workspace create --cwd "$project_path" --label "$space_label" --focus >/dev/null
fi

if [ -z "${HERDR_ENV:-}" ]; then
    exec herdr
fi
