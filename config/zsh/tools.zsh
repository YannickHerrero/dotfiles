# Enable Oh My Posh hot reload for theme switching
oh-my-posh enable reload 2>/dev/null || true
eval "$(oh-my-posh init zsh --config ~/.config/ohmyposh/zen.toml)"
eval "$(zoxide init --cmd z zsh)"

# mise - polyglot runtime manager (Node.js)
eval "$(mise activate zsh)"
