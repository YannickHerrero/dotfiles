#!/bin/bash
set -euo pipefail
# Copy all dotfiles to their appropriate locations

_MODULE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$(dirname "$(dirname "$_MODULE_DIR")")"

copy_dotfiles() {
    echo "Copying dotfiles..."
    
    # Create necessary directories
    mkdir -p "$HOME/.config/nvim/lua/plugins"
    mkdir -p "$HOME/.config/ohmyposh"
    mkdir -p "$HOME/.config/tmux"
    mkdir -p "$HOME/.config/zsh"
    mkdir -p "$HOME/dev"
    
    # Copy nvim config
    echo "  - Neovim config"
    cp "$DOTFILES_DIR/config/nvim/init.lua" "$HOME/.config/nvim/"
    cp "$DOTFILES_DIR/config/nvim/stylua.toml" "$HOME/.config/nvim/"
    cp "$DOTFILES_DIR/config/nvim/lua/"*.lua "$HOME/.config/nvim/lua/"
    # Mirror the repo's plugin directory: drop stale specs that were removed
    # upstream before copying so lazy.nvim doesn't keep loading them.
    rm -f "$HOME/.config/nvim/lua/plugins/"*.lua
    cp "$DOTFILES_DIR/config/nvim/lua/plugins/"*.lua "$HOME/.config/nvim/lua/plugins/"
    rm -f "$HOME/.config/nvim/lua/plugins.lua"
    
    # Copy zsh config under XDG_CONFIG_HOME/zsh; ~/.zshenv points zsh there.
    echo "  - Zsh config"
    cp "$DOTFILES_DIR/config/zsh/.zshenv" "$HOME/.zshenv"
    cp "$DOTFILES_DIR/config/zsh/.zshrc" "$HOME/.config/zsh/.zshrc"
    cp "$DOTFILES_DIR/config/zsh/"*.zsh "$HOME/.config/zsh/"
    # Clean up any leftovers from the pre-XDG layout.
    rm -f "$HOME/.zshrc"
    rm -rf "$HOME/.zsh"
    
    # Copy tmux config
    echo "  - Tmux config"
    cp "$DOTFILES_DIR/config/tmux/tmux.conf" "$HOME/.config/tmux/tmux.conf"
    
    # Copy oh-my-posh config
    echo "  - Oh My Posh config"
    cp "$DOTFILES_DIR/config/ohmyposh/zen.toml" "$HOME/.config/ohmyposh/"

    # On WSL, sync the Tridactyl config to the Windows user profile so Firefox
    # (running on Windows) picks up the nvim editor integration. Skipped on a
    # native Linux box where there's no Windows side.
    if grep -qiE '(microsoft|wsl)' /proc/version 2>/dev/null; then
        echo "  - Tridactyl config (Windows side, via WSL)"
        win_home="$(wslpath "$(cmd.exe /c 'echo %USERPROFILE%' 2>/dev/null | tr -d '\r')" 2>/dev/null || true)"
        if [[ -n "$win_home" && -d "$win_home" ]]; then
            mkdir -p "$win_home/.config/tridactyl"
            cp "$DOTFILES_DIR/config/tridactyl/tridactylrc" "$win_home/.config/tridactyl/"
            cp "$DOTFILES_DIR/config/tridactyl/wsl-integration.js" "$win_home/.config/tridactyl/"
        else
            echo "    (could not resolve Windows home; skipped)"
        fi
        # edit.sh runs on the Linux side (launched inside the WezTerm window),
        # so it lives in the WSL home, not the Windows profile.
        mkdir -p "$HOME/.config/tridactyl"
        cp "$DOTFILES_DIR/config/tridactyl/edit.sh" "$HOME/.config/tridactyl/edit.sh"
        chmod +x "$HOME/.config/tridactyl/edit.sh"
    fi

    echo "Dotfiles copied!"
}

copy_dotfiles
