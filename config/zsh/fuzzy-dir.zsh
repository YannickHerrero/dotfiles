# Tmux sessionizer - select a project and attach/create tmux session.
# Shares its logic with the `prefix + j` tmux keybind via sessionizer.sh.
f() {
    "$HOME/.config/tmux/sessionizer.sh"
}

# Fuzzy file finder - open selected file in nvim
ff() {
    local file
    file=$(find "$HOME/dev" "$HOME/.config" -type d \( \
        -path "*/node_modules" -o \
        -path "*/.git" -o \
        -path "*/.cache" -o \
        -path "*/.vscode" -o \
        -path "*/.npm" -o \
        -path "*/dist" -o \
        -path "*/.next" -o \
        -path "*/.expo" -o \
        -path "*/db" -o \
        -path "*/build" -o \
        -path "*/__pycache__" -o \
        -path "*/.idea" -o \
        -path "*/.env" -o \
        -path "*/.vs" -o \
        -path "*/vendor" -o \
        -path "*/coverage" -o \
        -path "*/.terraform" -o \
        -path "*/.bundle" -o \
        -path "*/tmp" -o \
        -path "*/logs" -o \
        -path "*/.sass-cache" \
    \) -prune -o -type f -print 2>/dev/null | \
    fzf --preview 'batcat --color=always --style=numbers --line-range=:500 {}' \
        --bind 'ctrl-d:preview-half-page-down,ctrl-u:preview-half-page-up')
    if [ -n "$file" ]; then
        nvim "$file"
    fi
}
