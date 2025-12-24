#!/bin/bash
# Install tmux

install_tmux() {
    echo "Installing tmux..."
    
    if ! command -v tmux &> /dev/null; then
        sudo apt install -y tmux
    else
        echo "tmux already installed"
    fi
    
    echo "Tmux installed!"
}

install_tmux
