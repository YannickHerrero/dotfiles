#!/bin/bash
# Install system dependencies via apt

install_apt() {
    echo "Installing system dependencies..."
    
    sudo apt update
    
    sudo apt install -y \
        build-essential \
        curl \
        wget \
        unzip \
        git \
        mosh \
        ripgrep \
        fd-find \
        fzf \
        bat \
        eza \
        python3 \
        python3-pip \
        software-properties-common
    
    echo "System dependencies installed!"
}

install_apt
