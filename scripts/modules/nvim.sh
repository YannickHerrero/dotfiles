#!/bin/bash
set -euo pipefail
# Install Neovim (latest stable) from GitHub releases

install_nvim() {
    echo "Installing Neovim from GitHub releases..."

    # Remove apt-installed neovim to avoid PATH conflicts
    if dpkg -l neovim &>/dev/null; then
        echo "Removing apt-installed neovim..."
        sudo apt remove -y neovim
    fi

    # Remove previous GitHub release install
    if [[ -d /opt/nvim-linux-x86_64 ]]; then
        echo "Removing previous install from /opt/nvim-linux-x86_64..."
        sudo rm -rf /opt/nvim-linux-x86_64
    fi

    local tarball="nvim-linux-x86_64.tar.gz"
    local url="https://github.com/neovim/neovim/releases/latest/download/$tarball"
    local tmp
    tmp="$(mktemp -d)"

    echo "Downloading $url ..."
    curl -fsSL -o "$tmp/$tarball" "$url"

    echo "Extracting to /opt/nvim-linux-x86_64 ..."
    sudo tar -xzf "$tmp/$tarball" -C /opt
    rm -rf "$tmp"

    # Symlink into PATH
    sudo ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim

    echo "Neovim $(nvim --version | head -1) installed!"
}

install_nvim
