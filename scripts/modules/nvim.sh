#!/bin/bash
set -euo pipefail
# Install neovim from Debian repositories

install_nvim() {
    echo "Installing neovim..."

    sudo apt install -y neovim

    echo "Neovim $(nvim --version | head -1) installed!"
}

install_nvim
