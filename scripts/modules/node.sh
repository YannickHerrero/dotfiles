#!/bin/bash
# Install nvm, Node.js LTS, and global npm packages

install_node() {
    echo "Installing nvm and Node.js..."
    
    export NVM_DIR="$HOME/.nvm"
    
    # Install nvm if not present
    if [[ ! -d "$NVM_DIR" ]]; then
        echo "Installing nvm..."
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
    else
        echo "nvm already installed"
    fi
    
    # Load nvm
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    
    # Install latest LTS
    echo "Installing Node.js LTS..."
    nvm install --lts
    nvm use --lts
    nvm alias default 'lts/*'
    
    # Install global packages
    echo "Installing global npm packages..."
    npm install -g eas-cli
    
    # Install opencode
    echo "Installing opencode..."
    curl -fsSL https://opencode.ai/install | bash
    
    echo "Node.js and packages installed!"
}

install_node
