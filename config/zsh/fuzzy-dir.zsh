# Fuzzy directory finder - cd into selected directory (top-level ~/dev folders only)
f() {
    local dir
    dir=$(find "$HOME/dev" -mindepth 1 -maxdepth 1 -type d -printf '%f\n' 2>/dev/null | \
    fzf --preview "eza --tree --level=1 --color=always $HOME/dev/{}" \
        --bind 'ctrl-d:preview-half-page-down,ctrl-u:preview-half-page-up')
    if [ -n "$dir" ]; then
        cd "$HOME/dev/$dir"
    fi
}

# Fuzzy directory finder (deep) - cd into selected directory (including subfolders)
fd() {
    local dir
    dir=$(find "$HOME/dev" -type d \( \
        -path "*/node_modules" -o \
        -path "*/.git" -o \
        -path "*/.cache" -o \
        -path "*/.vscode" -o \
        -path "*/.npm" -o \
        -path "*/dist" -o \
        -path "*/.next" -o \
        -path "*/.expo" -o \
        -path "*/build" \
    \) -prune -o -type d -print 2>/dev/null | \
    awk -F'/' '{if(NF>=2) print "../"$(NF-1)"/"$NF"\t"$0; else print $0"\t"$0}' | \
    fzf --delimiter='\t' --with-nth=1 \
        --preview 'eza --tree --level=1 --color=always {2}' \
        --bind 'ctrl-d:preview-half-page-down,ctrl-u:preview-half-page-up' | \
    cut -f2)
    if [ -n "$dir" ]; then
        cd "$dir"
    fi
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
