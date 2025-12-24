# Tmux sessionizer - select a project and attach/create tmux session
f() {
    local dir
    dir=$(find "$HOME/dev" -mindepth 1 -maxdepth 1 -type d -printf '%f\n' 2>/dev/null | \
    fzf --preview "eza --tree --level=1 --color=always $HOME/dev/{}" \
        --bind 'ctrl-d:preview-half-page-down,ctrl-u:preview-half-page-up')
    
    if [ -z "$dir" ]; then
        return
    fi

    local session_name="$dir"
    local project_path="$HOME/dev/$dir"

    # Check if session already exists
    if tmux has-session -t "$session_name" 2>/dev/null; then
        # Session exists - attach or switch to it
        if [ -n "$TMUX" ]; then
            tmux switch-client -t "$session_name"
        else
            tmux attach-session -t "$session_name"
        fi
    else
        # Create new session with 4 windows
        tmux new-session -d -s "$session_name" -c "$project_path" -n "nvim"
        tmux new-window -t "$session_name" -c "$project_path" -n "opencode"
        tmux new-window -t "$session_name" -c "$project_path" -n "run"
        tmux new-window -t "$session_name" -c "$project_path" -n "zsh"
        
        # Split the 'run' window into 2 side-by-side panes
        tmux split-window -h -t "$session_name:run"
        
        # Select the first window
        tmux select-window -t "$session_name:nvim"
        
        # Attach or switch to the new session
        if [ -n "$TMUX" ]; then
            tmux switch-client -t "$session_name"
        else
            tmux attach-session -t "$session_name"
        fi
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
