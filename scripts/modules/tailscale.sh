#!/bin/bash
# Install Tailscale VPN

install_tailscale() {
    echo "Installing Tailscale..."

    if command -v tailscale &> /dev/null; then
        echo "Tailscale already installed"
    else
        echo "Installing Tailscale via official install script..."
        curl -fsSL https://tailscale.com/install.sh | sh
    fi

    # Enable and start the tailscaled service
    if systemctl is-active --quiet tailscaled; then
        echo "tailscaled service already running"
    else
        echo "Enabling tailscaled service..."
        sudo systemctl enable --now tailscaled
    fi

    echo "Tailscale installed! Run 'sudo tailscale up' to authenticate."
}

install_tailscale
