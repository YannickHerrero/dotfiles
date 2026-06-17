#!/usr/bin/env bash
# Tridactyl external-editor helper (WSL side).
#
# Launched inside a fresh WezTerm window by Tridactyl's editorcmd (see
# wsl-integration.js). Firefox runs on Windows and hands us the temp file as a
# Windows path (C:\Users\...\tmp); nvim opens it and the Tridactyl() function in
# ~/.config/nvim/lua/tridactyl.lua rewrites it to /mnt/c/... and restores the
# cursor. Keeping this in a script means editorcmd needs almost no nested shell
# quoting, which is what tends to break across the cmd -> wezterm -> wsl chain.
set -uo pipefail

log="$HOME/.cache/tridactyl-edit.log"
mkdir -p "$(dirname "$log")"
printf '%s | argc=%s | args=[%s]\n' "$(date -Is 2>/dev/null || true)" "$#" "$*" >>"$log"

winpath="${1:-}"
line="${2:-1}"
col="${3:-1}"

nvim "$winpath" -c "call Tridactyl(${line}, ${col}, 1)"
rc=$?

# If nvim bailed (bad path, etc.), keep the window open so the error is visible
# instead of vanishing instantly.
if [[ "$rc" -ne 0 ]]; then
	printf 'nvim exited with status %s\n' "$rc" >>"$log"
	read -r -p "nvim exited with status ${rc}. Press Enter to close..."
fi
