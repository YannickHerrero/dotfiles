# All the default Omarchy aliases and functions
# (don't mess with these directly, just overwrite them here!)
source ~/.local/share/omarchy/default/bash/rc

# Add your own exports, aliases, and functions here.
#
# Make an alias for invoking commands you use constantly
# alias p='python'
alias v='nvim'

# Function to fuzzy find and cd into dev directories
fdev() {
    local selected=$(find ~/dev -mindepth 1 -maxdepth 1 -type d | fzf --prompt="Select dev folder: ")
    if [ -n "$selected" ]; then
        cd "$selected"
    fi
}
alias f='fdev'

# ================================================================
# Bash Enhancements - Syntax Highlighting, Autosuggestions, FZF
# ================================================================

# Initialize ble.sh EARLY (before other settings)
[[ $- == *i* ]] && source ~/.local/share/blesh/ble.sh --noattach

# History Configuration
HISTSIZE=5000
HISTFILE=~/.bash_history
SAVEHIST=$HISTSIZE
HISTCONTROL=ignorespace:ignoredups:erasedups
shopt -s histappend

# Advanced history options
shopt -s cmdhist    # Save multi-line commands as one
shopt -s histreedit # Re-edit failed history substitution
shopt -s histverify # Verify history expansion

# FZF Configuration
if command -v fzf &>/dev/null; then
  # Source fzf keybindings and completion
  source /usr/share/fzf/key-bindings.bash
  source /usr/share/fzf/completion.bash

  # FZF options - with preview windows
  export FZF_DEFAULT_OPTS='
        --height 40%
        --layout=reverse
        --border
        --preview-window=right:50%:wrap
    '

  # FZF for directory preview (similar to fzf-tab in zsh)
  export FZF_ALT_C_OPTS="--preview 'ls --color=always {}'"

  # FZF for file preview
  export FZF_CTRL_T_OPTS="
        --preview '([[ -f {} ]] && (bat --style=numbers --color=always {} || cat {})) || ([[ -d {} ]] && (ls --color=always {} )) 2> /dev/null | head -200'
    "

  # Use fd if available for better performance
  if command -v fd &>/dev/null; then
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
  fi
fi

# Bash Completion
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    source /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    source /etc/bash_completion
  fi
fi

# Completion styling
bind 'set completion-ignore-case on'       # Case-insensitive completion
bind 'set show-all-if-ambiguous on'        # Show completions immediately
bind 'set colored-stats on'                # Color completion by file type
bind 'set visible-stats on'                # Show file type indicators
bind 'set mark-symlinked-directories on'   # Mark symlinked directories
bind 'set colored-completion-prefix on'    # Color the prefix
bind 'set menu-complete-display-prefix on' # Show prefix before cycling

# Attach ble.sh at the end
[[ ${BLE_VERSION-} ]] && ble-attach
