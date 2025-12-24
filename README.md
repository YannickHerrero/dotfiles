# Dotfiles

Personal dotfiles for Ubuntu servers.

## Quick Start

```bash
git clone https://github.com/YannickHerrero/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh all
```

## Modular Installation

Install specific components:

```bash
./install.sh apt        # System dependencies (build-essential, curl, etc.)
./install.sh zsh        # Zsh + oh-my-posh
./install.sh tmux       # Tmux
./install.sh nvim       # Neovim (latest)
./install.sh mise       # mise runtime manager
./install.sh node       # Node.js LTS + bun + pnpm + npm packages
./install.sh tools      # zoxide, delta, lazygit
./install.sh git        # Git configuration
./install.sh dotfiles   # Copy all config files
```

Or combine:

```bash
./install.sh apt zsh nvim
```

## Theme Switching

Switch between Catppuccin themes:

```bash
set-theme mocha   # Dark theme (default)
set-theme latte   # Light theme
```

Themes update:
- Neovim (base16 colors)
- Oh My Posh (prompt colors)
- Tmux (status bar colors)

## What's Included

### Tools Installed

#### Shell & Terminal

| Tool | Installation | Description |
|------|--------------|-------------|
| zsh | apt | Shell with zinit plugin manager |
| oh-my-posh | curl | Prompt theming |
| tmux | apt | Terminal multiplexer with TPM |

#### Editor

| Tool | Installation | Description |
|------|--------------|-------------|
| neovim | PPA | Text editor (unstable/latest) |

#### Runtime Manager

| Tool | Installation | Description |
|------|--------------|-------------|
| mise | curl | Polyglot runtime manager |

#### JavaScript

| Tool | Installation | Description |
|------|--------------|-------------|
| Node.js LTS | mise | JavaScript runtime |
| bun | mise | JavaScript runtime/bundler |
| pnpm | mise | Fast package manager |
| eas-cli | npm | Expo Application Services |
| opencode | curl | AI coding assistant |

#### CLI Tools

| Tool | Installation | Description |
|------|--------------|-------------|
| zoxide | mise | Smart cd |
| delta | mise | Git diff viewer |
| lazygit | mise | Git TUI |
| fzf | apt | Fuzzy finder |
| eza | apt | Modern ls |
| bat | apt | Cat with syntax highlighting |
| ripgrep | apt | Fast grep |
| fd | apt | Fast find |

### Neovim Plugins
- LSP support (lua, typescript, tailwindcss)
- Telescope (fuzzy finder)
- Neo-tree (file explorer)
- Treesitter (syntax highlighting)
- Gitsigns + Fugitive (git integration)
- Supermaven (AI completion)
- Which-key (keybinding hints)
- And more...

### Key Bindings

#### Tmux (prefix: Ctrl+A)
| Key | Action |
|-----|--------|
| `prefix + \|` | Split vertical |
| `prefix + -` | Split horizontal |
| `prefix + r` | Reload config |
| `Ctrl + h/j/k/l` | Navigate panes |
| `Alt + 1-5` | Switch windows |

#### Neovim (leader: Space)
| Key | Action |
|-----|--------|
| `Space + Space` | Find files |
| `Space + sg` | Live grep |
| `Space + e` | Toggle file tree |
| `Space + bd` | Close buffer |
| `Shift + h/l` | Previous/next buffer |
| `gd` | Go to definition |
| `K` | Hover documentation |

#### Zsh
| Key | Action |
|-----|--------|
| `f` | Tmux sessionizer (select project, create/attach session) |
| `ff` | Fuzzy find files, open in nvim |
| `z <dir>` | Smart cd with zoxide |

## Directory Structure

```
dotfiles/
├── install.sh              # Main install script
├── config/
│   ├── git/.gitconfig
│   ├── nvim/               # Neovim config
│   ├── ohmyposh/zen.toml   # Prompt theme
│   ├── tmux/tmux.conf
│   └── zsh/                # Zsh configs
├── scripts/
│   ├── modules/            # Install modules
│   └── set-theme.sh        # Theme switcher
└── themes/
    ├── palettes/           # Theme definitions
    └── scripts/            # Theme generators
```

## Requirements

- Ubuntu 22.04 or 24.04
- sudo access
- Internet connection

## License

MIT
