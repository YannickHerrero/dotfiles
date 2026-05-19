# Text Editors & Files
alias v="nvim"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias oc="opencode"
alias ls='ls --color'
alias bat='batcat'
mkcd() { mkdir -p -- "$1" && cd -- "$1"; }
alias vswap="rm -rf ~/.local/state/nvim/swap/"
