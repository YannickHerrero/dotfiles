#!/bin/bash
# Copy all dotfiles to their appropriate locations

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$(dirname "$(dirname "$SCRIPT_DIR")")"

copy_dotfiles() {
    echo "Copying dotfiles..."
    
    # Create necessary directories
    mkdir -p "$HOME/.config/nvim/lua/plugins"
    mkdir -p "$HOME/.config/ohmyposh"
    mkdir -p "$HOME/.config/tmux"
    mkdir -p "$HOME/.zsh"
    mkdir -p "$HOME/dev"
    
    # Copy nvim config
    echo "  - Neovim config"
    cp "$DOTFILES_DIR/config/nvim/init.lua" "$HOME/.config/nvim/"
    cp "$DOTFILES_DIR/config/nvim/stylua.toml" "$HOME/.config/nvim/"
    cp "$DOTFILES_DIR/config/nvim/lua/vim-options.lua" "$HOME/.config/nvim/lua/"
    cp "$DOTFILES_DIR/config/nvim/lua/plugins.lua" "$HOME/.config/nvim/lua/"
    cp "$DOTFILES_DIR/config/nvim/lua/plugins/"*.lua "$HOME/.config/nvim/lua/plugins/"
    
    # Copy zsh config
    echo "  - Zsh config"
    cp "$DOTFILES_DIR/config/zsh/.zshrc" "$HOME/.zshrc"
    cp "$DOTFILES_DIR/config/zsh/"*.zsh "$HOME/.zsh/"
    
    # Copy tmux config
    echo "  - Tmux config"
    cp "$DOTFILES_DIR/config/tmux/tmux.conf" "$HOME/.config/tmux/tmux.conf"
    
    # Copy oh-my-posh config
    echo "  - Oh My Posh config"
    cp "$DOTFILES_DIR/config/ohmyposh/zen.toml" "$HOME/.config/ohmyposh/"
    
    # Copy git config
    echo "  - Git config"
    cp "$DOTFILES_DIR/config/git/.gitconfig" "$HOME/.gitconfig"
    
    echo "Dotfiles copied!"
}

copy_dotfiles
