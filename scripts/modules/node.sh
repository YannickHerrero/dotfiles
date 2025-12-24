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
    
    # Install global packages
    echo "Installing global npm packages..."
    mise exec -- npm install -g eas-cli
    
    # Install opencode
    echo "Installing opencode..."
    curl -fsSL https://opencode.ai/install | bash
    
    echo "Node.js and packages installed!"
}

install_node
