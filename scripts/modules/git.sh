#!/bin/bash
# Setup git configuration

_MODULE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$(dirname "$(dirname "$_MODULE_DIR")")"

setup_git() {
    echo "Setting up git configuration..."
    
    # Copy gitconfig
    cp "$DOTFILES_DIR/config/git/.gitconfig" "$HOME/.gitconfig"
    
    # Create global gitignore if it doesn't exist
    if [[ ! -f "$HOME/.gitignore" ]]; then
        cat > "$HOME/.gitignore" << 'EOF'
# OS files
.DS_Store
Thumbs.db

# Editor files
*.swp
*.swo
*~
.idea/
.vscode/
*.sublime-*

# Environment files
.env.local
.env.*.local
EOF
    fi
    
    echo "Git configuration complete!"
    echo "  Name:  $(git config --global user.name)"
    echo "  Email: $(git config --global user.email)"
}

setup_git
