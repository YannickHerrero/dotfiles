#!/bin/bash
# Install latest neovim from GitHub releases

install_nvim() {
    echo "Installing neovim..."
    
    # Get latest version
    local latest_version
    latest_version=$(curl -s https://api.github.com/repos/neovim/neovim/releases/latest | grep '"tag_name"' | sed -E 's/.*"([^"]+)".*/\1/')
    
    # Check if already installed with same version
    if command -v nvim &> /dev/null; then
        local current_version
        current_version=$(nvim --version | head -1 | grep -oP 'v\d+\.\d+\.\d+')
        if [[ "$current_version" == "$latest_version" ]]; then
            echo "Neovim $latest_version already installed"
            return 0
        fi
    fi
    
    echo "Installing Neovim $latest_version..."
    
    # Download and extract
    local tmp_dir=$(mktemp -d)
    cd "$tmp_dir"
    
    curl -LO "https://github.com/neovim/neovim/releases/download/${latest_version}/nvim-linux64.tar.gz"
    tar xzf nvim-linux64.tar.gz
    
    # Install to /usr/local
    sudo rm -rf /usr/local/nvim
    sudo mv nvim-linux64 /usr/local/nvim
    
    # Create symlink
    sudo ln -sf /usr/local/nvim/bin/nvim /usr/local/bin/nvim
    
    # Cleanup
    cd -
    rm -rf "$tmp_dir"
    
    echo "Neovim $latest_version installed!"
}

install_nvim
