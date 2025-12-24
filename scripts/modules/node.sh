#!/bin/bash
# Install Node.js LTS, bun, pnpm, and global npm packages via mise

install_node() {
    echo "Installing Node.js and package managers..."
    
    # Check if mise is installed
    if ! command -v mise &> /dev/null; then
        echo "Error: mise is not installed. Please run mise.sh first."
        exit 1
    fi
    
    # Ensure mise is in PATH
    export PATH="$HOME/.local/bin:$PATH"
    
    # Install Node.js LTS
    echo "Installing Node.js LTS..."
    mise use --global node@lts
    
    # Install bun
    echo "Installing bun..."
    mise use --global bun@latest
    
    # Install pnpm
    echo "Installing pnpm..."
    mise use --global pnpm@latest
    
    # Install global packages
    if ! command -v eas &> /dev/null; then
        echo "Installing eas-cli..."
        mise exec -- npm install -g eas-cli
    else
        echo "eas-cli already installed"
    fi
    
    # Install opencode
    if ! command -v opencode &> /dev/null; then
        echo "Installing opencode..."
        curl -fsSL https://opencode.ai/install | bash
    else
        echo "opencode already installed"
    fi
    
    echo "Node.js, bun, pnpm, and packages installed!"
}

install_node
