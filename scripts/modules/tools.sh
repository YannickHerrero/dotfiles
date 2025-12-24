#!/bin/bash
# Install additional tools via mise: zoxide, delta, lazygit

install_tools() {
    echo "Installing additional tools..."
    
    # Check if mise is installed
    if ! command -v mise &> /dev/null; then
        echo "Error: mise is not installed. Please run node.sh first."
        exit 1
    fi
    
    # Ensure mise is in PATH
    export PATH="$HOME/.local/bin:$PATH"
    
    # Install zoxide
    echo "Installing zoxide..."
    mise use --global zoxide@latest
    
    # Install delta (git diff tool)
    echo "Installing delta..."
    mise use --global delta@latest
    
    # Install lazygit
    echo "Installing lazygit..."
    mise use --global lazygit@latest
    
    echo "Additional tools installed!"
}

install_tools
