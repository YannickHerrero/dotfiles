#!/bin/bash
# Install neovim via PPA (provides up-to-date versions)

install_nvim() {
    echo "Installing neovim..."
    
    # Add Neovim PPA if not already added
    if ! grep -q "neovim-ppa" /etc/apt/sources.list.d/*.list 2>/dev/null; then
        echo "Adding Neovim PPA..."
        sudo add-apt-repository -y ppa:neovim-ppa/unstable
        sudo apt update
    else
        echo "Neovim PPA already added"
    fi
    
    # Install neovim
    sudo apt install -y neovim
    
    # Show installed version
    echo "Neovim $(nvim --version | head -1) installed!"
}

install_nvim
