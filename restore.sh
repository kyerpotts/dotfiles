#!/usr/bin/env bash

set -Eeuo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DRY_RUN=false
SKIP_SHELL=false

DOTFILES=(
    ".zshrc"
    ".zsh_venv_auto_activate"
    ".config/ghostty"
    ".config/nvim"
    ".config/tmux"
    ".tmux.conf"
    ".config/niri"
    ".config/herdr/config.toml"
    ".config/obsidian"
    ".gitconfig"
    ".pi/agent/settings.json"
    ".pi/agent/pi-sub-bar-settings.json"
    ".pi/agent/skills"
    ".pi/agent/extensions"
)

usage() {
    cat <<EOF
Usage: ./restore.sh [--dry-run] [--no-shell] [--help]

Deploy this dotfiles repository into \$HOME by creating symlinks.

Options:
  --dry-run   Show actions without changing files or shell settings.
  --no-shell  Skip default shell configuration.
  --help      Show this help message.
EOF
}

for arg in "$@"; do
    case "$arg" in
        --dry-run)
            DRY_RUN=true
            ;;
        --no-shell)
            SKIP_SHELL=true
            ;;
        --help|-h)
            usage
            exit 0
            ;;
        *)
            echo "ERROR: Unknown option: $arg" >&2
            usage >&2
            exit 2
            ;;
    esac
done

run_or_preview() {
    if [[ "$DRY_RUN" == true ]]; then
        return 0
    fi

    "$@"
}

ensure_parent_dir() {
    local target="$1"
    local parent
    parent="$(dirname "$target")"

    if [[ -d "$parent" ]]; then
        return 0
    fi

    if [[ "$DRY_RUN" == true ]]; then
        echo "Would create directory: $parent"
        return 0
    fi

    mkdir -p "$parent"
}

link_file() {
    local source="$1"
    local target="$2"
    local resolved=""

    ensure_parent_dir "$target"

    if [[ -L "$target" ]]; then
        resolved="$(readlink -f "$target" || true)"
        if [[ "$resolved" == "$source" ]]; then
            echo "✓ Already linked: $target"
            return 0
        fi

        if [[ "$DRY_RUN" == true ]]; then
            echo "Would remove existing symlink: $target -> $resolved"
        else
            rm "$target"
        fi
    elif [[ -e "$target" ]]; then
        local backup="${target}.backup-$(date +%Y%m%d-%H%M%S)"
        if [[ "$DRY_RUN" == true ]]; then
            echo "Would back up existing: $target -> $backup"
        else
            echo "  Backing up existing: $target -> $backup"
            mv "$target" "$backup"
        fi
    fi

    if [[ "$DRY_RUN" == true ]]; then
        echo "Would link: $target -> $source"
        return 0
    fi

    ln -s "$source" "$target"
    echo "✓ Linked: $target -> $source"
}

configure_shell() {
    echo ""

    if [[ "$SKIP_SHELL" == true ]]; then
        echo "Skipping shell configuration (--no-shell)."
        return 0
    fi

    if [[ "${SHELL:-}" == *"zsh"* ]]; then
        echo "✓ Default shell is already zsh"
        return 0
    fi

    if ! command -v zsh &>/dev/null; then
        echo "ERROR: zsh is not installed. Install zsh before changing the default shell." >&2
        return 1
    fi

    local zsh_path
    zsh_path="$(command -v zsh)"

    if [[ "$DRY_RUN" == true ]]; then
        if ! grep -q "^$zsh_path$" /etc/shells 2>/dev/null; then
            echo "Would add zsh to /etc/shells: $zsh_path"
        fi
        echo "Would change default shell to zsh: $zsh_path"
        return 0
    fi

    if ! grep -q "^$zsh_path$" /etc/shells 2>/dev/null; then
        echo "Adding zsh to /etc/shells..."
        echo "$zsh_path" | sudo tee -a /etc/shells >/dev/null
    fi

    chsh -s "$zsh_path"
    echo "✓ Default shell changed to zsh"
    echo ""
    echo "NOTE: Log out and log back in for the shell change to take effect."
}

if [[ "$DRY_RUN" == true ]]; then
    echo "DRY RUN: no files or shell settings will be changed."
fi

echo "Restoring dotfiles from $DOTFILES_DIR..."
echo ""

for file in "${DOTFILES[@]}"; do
    source_path="$DOTFILES_DIR/$file"
    target_path="$HOME/$file"

    if [[ -e "$source_path" ]]; then
        link_file "$source_path" "$target_path"
    else
        echo "⊘ Not found in dotfiles: $file"
    fi
done

configure_shell

echo ""
echo "========================================"
if [[ "$DRY_RUN" == true ]]; then
    echo "Dotfiles dry run complete."
else
    echo "Dotfiles restored successfully!"
fi
echo "========================================"
echo ""
echo "Files are symlinked, so changes in \$HOME will reflect in the dotfiles repo."
echo "Run 'source ~/.zshrc' to reload shell configuration."
