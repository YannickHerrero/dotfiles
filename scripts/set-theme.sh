#!/bin/bash
# Theme Switcher - Updates theme across all applications
# Usage: set-theme <theme-id>
#   e.g. set-theme mocha
#        set-theme latte

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$(dirname "$SCRIPT_DIR")"
THEME_ID="${1:-mocha}"
THEME_DIR="$DOTFILES_DIR/themes/palettes"
SCRIPTS_DIR="$DOTFILES_DIR/themes/scripts"

# Source helper scripts
source "$SCRIPTS_DIR/common.sh"
source "$SCRIPTS_DIR/neovim.sh"
source "$SCRIPTS_DIR/ohmyposh.sh"
source "$SCRIPTS_DIR/tmux.sh"

# Find theme file by ID
find_theme_file() {
    local id="$1"
    for f in "$THEME_DIR"/*.toml; do
        if [[ -f "$f" ]]; then
            local file_id
            file_id=$(read_toml "$f" "meta" "id" 2>/dev/null) || continue
            if [[ "$file_id" == "$id" ]]; then
                echo "$f"
                return 0
            fi
        fi
    done
    return 1
}

# List available themes
list_themes() {
    echo "Available themes:"
    for f in "$THEME_DIR"/*.toml; do
        if [[ -f "$f" ]]; then
            local id name
            id=$(read_toml "$f" "meta" "id" 2>/dev/null) || continue
            name=$(read_toml "$f" "meta" "name" 2>/dev/null) || continue
            echo "  $id - $name"
        fi
    done
}

# Main execution
main() {
    # Show help
    if [[ "$THEME_ID" == "-h" || "$THEME_ID" == "--help" ]]; then
        echo "Usage: set-theme <theme-id>"
        echo ""
        list_themes
        exit 0
    fi

    # List themes
    if [[ "$THEME_ID" == "-l" || "$THEME_ID" == "--list" ]]; then
        list_themes
        exit 0
    fi

    # Find the theme file
    THEME_FILE=$(find_theme_file "$THEME_ID")
    if [[ -z "$THEME_FILE" ]]; then
        echo "Error: Theme '$THEME_ID' not found in $THEME_DIR"
        echo ""
        list_themes
        exit 1
    fi

    echo "Applying theme: $(read_toml "$THEME_FILE" "meta" "name")"

    # Generate Neovim base16 colors
    local nvim_colors="$HOME/.config/nvim/lua/theme-colors.lua"
    generate_neovim_colors "$THEME_FILE" "$nvim_colors"
    echo "  - Neovim colors"

    # Update Oh My Posh palette
    local ohmyposh_config="$HOME/.config/ohmyposh/zen.toml"
    if [[ -f "$ohmyposh_config" ]]; then
        update_ohmyposh_palette "$THEME_FILE" "$ohmyposh_config"
        echo "  - Oh My Posh palette"
    fi

    # Generate tmux theme
    local tmux_theme="$HOME/.config/tmux/theme.conf"
    generate_tmux_theme "$THEME_FILE" "$tmux_theme"
    echo "  - Tmux theme"

    echo ""
    echo "Theme applied! Some apps may need restart:"
    echo "  - Neovim: Restart or run :lua require('base16-colorscheme').setup(require('theme-colors').base16)"
    echo "  - Tmux: Will reload automatically if running"
}

main
