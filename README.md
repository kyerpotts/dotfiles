# My Dotfiles

Personal configuration files for my CachyOS + Niri + Noctalia setup.

## Installation

1. Clone this repository (using SSH):
   ```bash
   git clone git@github.com:yourusername/dotfiles.git ~/.dotfiles
   cd ~/.dotfiles
   ```

2. Run the restore script:
   ```bash
   ./restore.sh
   ```

3. Log out and log back in for shell changes to take effect.

## What's Included

- `.zshrc` - Zsh configuration with auto-venv, zoxide, yazi
- `.config/ghostty/` - Ghostty terminal configuration
- `.config/nvim/` - Neovim configuration (omarchynvim)
- `.config/tmux/` - Tmux configuration
- `.config/niri/` - Niri window manager configuration
- `.gitconfig` - Git configuration

## Updating Dotfiles

Since files are symlinked, any changes you make to your config files are automatically reflected in this repository. Just commit and push:

```bash
cd ~/.dotfiles
git add .
git commit -m "Update configurations"
git push
```

## Full System Setup

See the `setup/` directory in the main repository for automated system setup scripts.

## Notes

- Files are symlinked from `~/.dotfiles` to your home directory
- Existing files are backed up before being replaced
- The restore script handles shell switching to zsh automatically
