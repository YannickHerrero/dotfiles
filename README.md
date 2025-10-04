# Dotfiles

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Structure

Each subdirectory represents a package that can be installed independently using Stow. The directory structure mirrors the target location in your home directory.

## Installation

### Prerequisites

Install GNU Stow:

```bash
sudo pacman -S stow
```

### Usage

From the dotfiles directory, use `stow` to symlink packages to your home directory:

```bash
# Install a single package
stow nvim

# Install multiple packages
stow package1 package2

# Install all packages
stow */

# Remove a package
stow -D nvim
```

### Example

```bash
cd ~/dotfiles
stow nvim  # Creates symlinks for nvim config files
```

This will create symlinks in `~/.config/nvim` pointing to files in `~/dotfiles/nvim/.config/nvim`.

## Managing Dotfiles

To add new dotfiles:

1. Create a new package directory
2. Replicate the path structure from your home directory
3. Move your dotfiles into the package directory
4. Use `stow <package>` to create symlinks

## Notes

- Files are symlinked, so editing them in either location will modify the same file
- Use `stow -v` for verbose output to see what Stow is doing
