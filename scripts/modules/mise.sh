#!/bin/bash
# Install mise - polyglot runtime manager

install_mise() {
    echo "Installing mise..."
    
    if ! command -v mise &> /dev/null; then
        curl https://mise.run | sh
    else
        echo "mise already installed"
    fi
    
    # Add mise to PATH for this session
    export PATH="$HOME/.local/bin:$PATH"
    
    echo "mise installed!"
}

install_mise
