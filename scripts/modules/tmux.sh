#!/bin/bash
# Install tmux and TPM (Tmux Plugin Manager)

install_tmux() {
    echo "Installing tmux..."
    
    if ! command -v tmux &> /dev/null; then
        sudo apt install -y tmux
    else
        echo "tmux already installed"
    fi
    
    # Install TPM (Tmux Plugin Manager)
    if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
        echo "Installing TPM (Tmux Plugin Manager)..."
        git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
    else
        echo "TPM already installed"
    fi
    
    echo "Tmux and TPM installed!"
    echo "Note: After starting tmux, press 'prefix + I' to install plugins"
}

install_tmux
