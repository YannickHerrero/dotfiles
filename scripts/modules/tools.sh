#!/bin/bash
# Install additional tools: zoxide, delta, lazygit

install_tools() {
    echo "Installing additional tools..."
    
    # Install zoxide
    if ! command -v zoxide &> /dev/null; then
        echo "Installing zoxide..."
        curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
    else
        echo "zoxide already installed"
    fi
    
    # Install delta (git diff tool)
    if ! command -v delta &> /dev/null; then
        echo "Installing delta..."
        local delta_version
        delta_version=$(curl -s https://api.github.com/repos/dandavison/delta/releases/latest | grep '"tag_name"' | sed -E 's/.*"([^"]+)".*/\1/')
        
        local tmp_dir=$(mktemp -d)
        cd "$tmp_dir"
        
        curl -LO "https://github.com/dandavison/delta/releases/download/${delta_version}/git-delta_${delta_version#v}_amd64.deb"
        sudo dpkg -i "git-delta_${delta_version#v}_amd64.deb"
        
        cd -
        rm -rf "$tmp_dir"
    else
        echo "delta already installed"
    fi
    
    # Install lazygit
    if ! command -v lazygit &> /dev/null; then
        echo "Installing lazygit..."
        local lazygit_version
        lazygit_version=$(curl -s https://api.github.com/repos/jesseduffield/lazygit/releases/latest | grep '"tag_name"' | sed -E 's/.*"v?([^"]+)".*/\1/')
        
        local tmp_dir=$(mktemp -d)
        cd "$tmp_dir"
        
        curl -LO "https://github.com/jesseduffield/lazygit/releases/download/v${lazygit_version}/lazygit_${lazygit_version}_Linux_x86_64.tar.gz"
        tar xzf "lazygit_${lazygit_version}_Linux_x86_64.tar.gz"
        sudo install lazygit /usr/local/bin
        
        cd -
        rm -rf "$tmp_dir"
    else
        echo "lazygit already installed"
    fi
    
    echo "Additional tools installed!"
}

install_tools
