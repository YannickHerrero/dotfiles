# Enable Oh My Posh hot reload for theme switching
oh-my-posh enable reload 2>/dev/null || true
eval "$(oh-my-posh init zsh --config ~/.config/ohmyposh/zen.toml)"
eval "$(zoxide init --cmd z zsh)"

# Fast Node Manager (fnm) - much faster than nvm
eval "$(fnm env --use-on-cd)"
