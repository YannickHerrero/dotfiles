#!/bin/bash
# Install fnm (Fast Node Manager), Node.js LTS, and global npm packages

install_node() {
    echo "Installing fnm and Node.js..."
    
    # Install fnm if not present
    if ! command -v fnm &> /dev/null; then
        echo "Installing fnm..."
        curl -fsSL https://fnm.vercel.app/install | bash -s -- --skip-shell
    else
        echo "fnm already installed"
    fi
    
    # Load fnm for this session
    export PATH="$HOME/.local/share/fnm:$PATH"
    eval "$(fnm env)"
    
    # Install latest LTS
    echo "Installing Node.js LTS..."
    fnm install --lts
    fnm default lts-latest
    fnm use lts-latest
    
    # Install global packages
    echo "Installing global npm packages..."
    npm install -g eas-cli
    
    # Install opencode
    echo "Installing opencode..."
    curl -fsSL https://opencode.ai/install | bash
    
    echo "Node.js and packages installed!"
}

install_node
