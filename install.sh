#!/bin/bash
# Dotfiles Bootstrap Script
# Usage: ./install.sh [module|all]
#   e.g. ./install.sh all
#        ./install.sh nvim
#        ./install.sh zsh tmux

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MODULES_DIR="$SCRIPT_DIR/scripts/modules"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_header() {
    echo ""
    echo -e "${BLUE}================================${NC}"
    echo -e "${BLUE}  $1${NC}"
    echo -e "${BLUE}================================${NC}"
    echo ""
}

print_success() {
    echo -e "${GREEN}[OK]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Available modules
declare -A MODULES=(
    ["apt"]="System dependencies (build-essential, curl, etc.)"
    ["zsh"]="Zsh shell and oh-my-posh"
    ["tmux"]="Tmux terminal multiplexer"
    ["nvim"]="Neovim (latest from GitHub)"
    ["mise"]="mise runtime manager"
    ["node"]="Node.js LTS, bun, pnpm, npm packages"
    ["tools"]="Additional tools (zoxide, delta, lazygit)"
    ["git"]="Git configuration"
    ["dotfiles"]="Copy all dotfiles to home directory"
)

# Order for full install
INSTALL_ORDER=(apt zsh tmux nvim mise node tools git dotfiles)

show_help() {
    echo "Dotfiles Bootstrap Script"
    echo ""
    echo "Usage: ./install.sh [module...] | all"
    echo ""
    echo "Modules:"
    for module in "${!MODULES[@]}"; do
        printf "  %-12s %s\n" "$module" "${MODULES[$module]}"
    done
    echo ""
    echo "Examples:"
    echo "  ./install.sh all          # Install everything"
    echo "  ./install.sh nvim         # Install only neovim"
    echo "  ./install.sh zsh tmux     # Install zsh and tmux"
    echo ""
    echo "After installation, run 'set-theme mocha' to apply the theme"
}

run_module() {
    local module="$1"
    local script="$MODULES_DIR/$module.sh"
    
    if [[ ! -f "$script" ]]; then
        print_error "Module '$module' not found"
        return 1
    fi
    
    print_header "Installing: ${MODULES[$module]}"
    source "$script"
    print_success "Module '$module' completed"
}

install_all() {
    print_header "Full Installation"
    echo "This will install:"
    for module in "${INSTALL_ORDER[@]}"; do
        echo "  - ${MODULES[$module]}"
    done
    echo ""
    
    read -p "Continue? [y/N] " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Aborted."
        exit 0
    fi
    
    for module in "${INSTALL_ORDER[@]}"; do
        run_module "$module"
    done
    
    # Apply default theme
    print_header "Applying default theme (mocha)"
    "$SCRIPT_DIR/scripts/set-theme.sh" mocha
    
    print_header "Installation Complete!"
    echo ""
    echo "Next steps:"
    echo "  1. Log out and log back in (for shell change)"
    echo "  2. Open a new terminal"
    echo "  3. Run 'nvim' to install plugins"
    echo ""
    echo "Theme commands:"
    echo "  set-theme mocha    # Dark theme"
    echo "  set-theme latte    # Light theme"
    echo ""
}

# Main
main() {
    if [[ $# -eq 0 ]]; then
        show_help
        exit 0
    fi
    
    if [[ "$1" == "-h" || "$1" == "--help" ]]; then
        show_help
        exit 0
    fi
    
    if [[ "$1" == "all" ]]; then
        install_all
        exit 0
    fi
    
    # Install specific modules
    for module in "$@"; do
        if [[ -z "${MODULES[$module]}" ]]; then
            print_error "Unknown module: $module"
            echo "Run './install.sh --help' for available modules"
            exit 1
        fi
        run_module "$module"
    done
    
    print_success "Done!"
}

main "$@"
