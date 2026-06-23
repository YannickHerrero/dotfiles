#!/usr/bin/env bash
# Tmux sessionizer - select a project under ~/dev (or ~/dev/peren) and
# attach/create its session. Usable both as a standalone command (zsh `f`)
# and from a tmux popup (prefix + j); when run inside tmux it switches the
# client, otherwise it attaches.
set -euo pipefail

# Map each project session to when it was last attached so projects with an
# open (or most recently focused) session float to the top; everything else
# keeps its filesystem order below them. The session we're currently in (if
# any) is pushed to the very bottom -- we're already there.
sessions=$(tmux list-sessions -F '#{session_name} #{session_last_attached}' 2>/dev/null || true)
current=""
[ -n "${TMUX:-}" ] && current=$(tmux display-message -p '#{session_name}' 2>/dev/null || true)

dir=$(find "$HOME/dev" "$HOME/dev/peren" -mindepth 1 -maxdepth 1 -type d -printf '%p\n' 2>/dev/null | \
    sed "s|^$HOME/dev/||" | \
    awk -v sess="$sessions" -v cur="$current" '
        BEGIN {
            n = split(sess, lines, "\n")
            for (i = 1; i <= n; i++) {
                split(lines[i], a, " ")
                if (a[1] != "") ts[a[1]] = a[2]
            }
        }
        {
            name = $0; sub(/.*\//, "", name)   # session name = basename
            if (name == cur) key = -1          # current session -> bottom
            else key = (name in ts) ? ts[name] : 0
            print key "\t" $0
        }' | \
    sort -s -k1,1nr | cut -f2- | \
    fzf --preview "eza --tree --level=1 --color=always $HOME/dev/{}" \
        --bind 'ctrl-d:preview-half-page-down,ctrl-u:preview-half-page-up')

[ -z "$dir" ] && exit 0

# Session name is the project's basename (so ~/dev/peren/foo -> "foo").
session_name="${dir##*/}"
project_path="$HOME/dev/$dir"

if ! tmux has-session -t "$session_name" 2>/dev/null; then
    # Create new session with 4 windows
    tmux new-session -d -s "$session_name" -c "$project_path" -n "Claude"
    tmux new-window -t "$session_name" -c "$project_path" -n "nvim"
    tmux new-window -t "$session_name" -c "$project_path" -n "run"
    tmux new-window -t "$session_name" -c "$project_path" -n "zsh"

    # Split the 'run' window into 2 side-by-side panes
    tmux split-window -h -t "$session_name:run"

    # Select the first window
    tmux select-window -t "$session_name:Claude"
fi

if [ -n "${TMUX:-}" ]; then
    tmux switch-client -t "$session_name"
else
    tmux attach-session -t "$session_name"
fi
