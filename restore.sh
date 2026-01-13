#!/bin/bash
# Restore dotfiles by creating symlinks

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Restoring dotfiles from $DOTFILES_DIR..."
echo ""

# List of files to symlink
DOTFILES=(
    ".zshrc"
    ".zsh_venv_auto_activate"
    ".config/ghostty"
    ".config/nvim"
    ".config/tmux"
    ".tmux.conf"
    ".config/niri"
    ".gitconfig"
)

# Function to create symlink
link_file() {
    local source="$1"
    local target="$2"

    # Create parent directory if needed
    mkdir -p "$(dirname "$target")"

    # If target exists and is not a symlink to our dotfiles
    if [[ -e "$target" ]] && [[ "$(readlink -f "$target")" != "$source" ]]; then
        # Backup existing file
        local backup="${target}.backup-$(date +%Y%m%d-%H%M%S)"
        echo "  Backing up existing: $target -> $backup"
        mv "$target" "$backup"
    fi

    # Remove existing symlink if it points to wrong location
    if [[ -L "$target" ]] && [[ "$(readlink -f "$target")" != "$source" ]]; then
        rm "$target"
    fi

    # Create symlink if it doesn't exist or points to wrong location
    if [[ ! -e "$target" ]]; then
        ln -sf "$source" "$target"
        echo "✓ Linked: $target -> $source"
    else
        echo "✓ Already linked: $target"
    fi
}

# Symlink all dotfiles
for file in "${DOTFILES[@]}"; do
    source_path="$DOTFILES_DIR/$file"
    target_path="$HOME/$file"

    if [[ -e "$source_path" ]]; then
        link_file "$source_path" "$target_path"
    else
        echo "⊘ Not found in dotfiles: $file"
    fi
done

# Change default shell to zsh if not already
echo ""
if [[ "$SHELL" != *"zsh"* ]]; then
    echo "Changing default shell to zsh..."

    # Ensure zsh is installed
    if ! command -v zsh &>/dev/null; then
        echo "ERROR: zsh is not installed. Please run the base.sh setup script first."
        exit 1
    fi

    # Get zsh path
    ZSH_PATH=$(which zsh)

    # Check if zsh is in /etc/shells
    if ! grep -q "^$ZSH_PATH$" /etc/shells 2>/dev/null; then
        echo "Adding zsh to /etc/shells..."
        echo "$ZSH_PATH" | sudo tee -a /etc/shells
    fi

    # Change shell
    chsh -s "$ZSH_PATH"
    echo "✓ Default shell changed to zsh"
    echo ""
    echo "NOTE: You need to log out and log back in for the shell change to take effect."
else
    echo "✓ Default shell is already zsh"
fi

echo ""
echo "========================================"
echo "Dotfiles restored successfully!"
echo "========================================"
echo ""
echo "Note: Files are symlinked, so changes in $HOME will reflect in the dotfiles repo."
echo "Remember to commit and push your changes to keep them backed up."
echo ""
echo "Run 'source ~/.zshrc' to reload shell configuration."
