#!/bin/bash
# Install additional CLI tools

install_tools() {
    echo "Installing additional tools..."
    
    # Check if mise is installed
    if ! command -v mise &> /dev/null; then
        echo "Error: mise is not installed. Please run mise.sh first."
        exit 1
    fi
    
    # Ensure mise is in PATH
    export PATH="$HOME/.local/bin:$PATH"
    
    # Install opencode
    if ! command -v opencode &> /dev/null; then
        echo "Installing opencode..."
        curl -fsSL https://opencode.ai/install | bash
    else
        echo "opencode already installed"
    fi
    
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
