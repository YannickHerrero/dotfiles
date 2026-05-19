# Dotfiles

Personal dotfiles for a Debian 13 VPS dev environment.

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
./install.sh nvim       # Neovim
./install.sh mise       # mise runtime manager
./install.sh node       # Node.js LTS + bun + pnpm + npm packages
./install.sh tools      # zoxide, delta, lazygit
./install.sh claude     # Claude Code global config + skills
./install.sh ssh        # Optional GitHub SSH key generation
./install.sh git        # Git configuration
./install.sh dotfiles   # Copy all config files
```

Or combine:

```bash
./install.sh apt zsh nvim
```

Tmux and oh-my-posh intentionally inherit colors from the SSH client terminal.

GitHub SSH setup is optional. Public bootstrap downloads use HTTPS by default so a fresh shell works before adding a GitHub SSH key.

The `git` module reuses an existing global Git identity when `user.name` and `user.email` are already set, and asks for confirmation before keeping them.

The `claude` module installs user-scoped Claude Code configuration into `~/.claude/`. The default settings disable Claude attribution in commits and pull requests, allow common Git workflows without prompts, ask for approval on higher-risk commands, and block a few dangerous patterns outright.

## What's Included

### Tools Installed

#### Shell & Terminal

| Tool | Installation | Description |
|------|--------------|-------------|
| zsh | apt | Shell with zinit plugin manager |
| oh-my-posh | curl | Prompt that inherits terminal colors |
| tmux | apt | Terminal multiplexer with TPM |

#### Editor

| Tool | Installation | Description |
|------|--------------|-------------|
| neovim | GitHub release | Text editor (0.11+) |

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
| tree-sitter-cli | npm | Parser builder for nvim-treesitter v1 |

#### CLI Tools

| Tool | Installation | Description |
|------|--------------|-------------|
| claude code | curl | AI coding assistant |
| opencode | curl | AI coding assistant |
| zoxide | mise | Smart cd |
| delta | mise | Git diff viewer |
| lazygit | mise | Git TUI |
| gh | mise | GitHub CLI |
| gh-notify | gh ext | GitHub notifications inbox (used by snacks dashboard) |
| colorscript | git/make | shell-color-scripts; decorative blocks in snacks dashboard |
| fzf | apt | Fuzzy finder |
| eza | apt | Modern ls |
| bat | apt | Cat with syntax highlighting |
| ripgrep | apt | Fast grep |
| fd | apt | Fast find |

### Neovim Plugins

| Plugin | Role |
|--------|------|
| lazy.nvim | Plugin manager |
| blink.cmp | Completion (Rust-backed) |
| snacks.nvim | picker, explorer, dashboard, bigfile, quickfile |
| mini.nvim | pairs, surround, statusline, tabline, icons |
| nvim-treesitter (v1 main) | Syntax highlighting + indent |
| nvim-lspconfig + mason + mason-lspconfig | LSP wiring |
| mason-tool-installer | Auto-installs stylua / prettier / shfmt |
| conform.nvim | Format-on-save |
| which-key.nvim | Keybinding hints |
| nvim-tmux-navigation | C-h/j/k/l between nvim and tmux panes |

**LSP servers** (auto-installed via mason): `ts_ls`, `rust_analyzer`, `lua_ls`, `bashls`.
**Formatters** (auto-installed via mason-tool-installer): `stylua`, `prettier`, `shfmt`. `rustfmt` comes from the Rust toolchain.

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
| `Space + Space` | Find files (snacks.picker) |
| `Space + sg` | Live grep (snacks.picker) |
| `Space + e` | Toggle file explorer (snacks.explorer, right-side) |
| `Space + bd` | Close buffer |
| `Space + o` | Toggle statusline visibility |
| `Shift + h/l` | Previous/next buffer (also switches tab in mini.tabline) |
| `gd` | Go to definition (LSP) |
| `gr` | Find references (LSP) |
| `K` | Hover docs (LSP) |
| `Space + ca` | Code action (LSP) |
| `Space + rn` | Rename symbol (LSP) |

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
│   ├── claude/             # Claude Code global config and skills
│   ├── nvim/               # Neovim config
│   ├── ohmyposh/zen.toml   # Prompt theme
│   ├── tmux/tmux.conf
│   └── zsh/                # Zsh configs
├── scripts/
│   └── modules/            # Install modules
```

## Requirements

- Debian 13
- sudo access
- Internet connection

## License

MIT
