#!/bin/bash
# Install mise, Node.js LTS, and global npm packages

install_node() {
    echo "Installing mise and Node.js..."
    
    # Install mise if not present
    if ! command -v mise &> /dev/null; then
        echo "Installing mise..."
        curl https://mise.run | sh
    else
        echo "mise already installed"
    fi
    
    # Add mise to PATH for this session
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
    
    echo "Node.js and packages installed!"
}

install_node
