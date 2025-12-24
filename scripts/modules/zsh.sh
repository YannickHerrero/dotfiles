#!/bin/bash
# Install zsh and oh-my-posh

install_zsh() {
    echo "Installing zsh..."
    
    # Install zsh if not present
    if ! command -v zsh &> /dev/null; then
        sudo apt install -y zsh
    else
        echo "zsh already installed"
    fi
    
    # Set zsh as default shell
    if [[ "$SHELL" != *"zsh"* ]]; then
        echo "Setting zsh as default shell..."
        chsh -s $(which zsh)
    else
        echo "zsh is already the default shell"
    fi
    
    echo "Installing oh-my-posh..."
    
    # Install oh-my-posh
    if ! command -v oh-my-posh &> /dev/null; then
        curl -s https://ohmyposh.dev/install.sh | bash -s
    else
        echo "oh-my-posh already installed"
    fi
    
    echo "Zsh and oh-my-posh installed!"
}

install_zsh
