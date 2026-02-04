#!/usr/bin/env bash
#
# Dotfiles install script
# Usage: ./install.sh
#
# This script creates symlinks from the dotfiles repo to your home directory.
# Run this on a new machine to quickly set up your environment.

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

backup_and_link() {
    local src="$1"
    local dest="$2"

    # If destination exists and is not a symlink, back it up
    if [[ -e "$dest" && ! -L "$dest" ]]; then
        mkdir -p "$BACKUP_DIR"
        warn "Backing up existing $dest to $BACKUP_DIR/"
        mv "$dest" "$BACKUP_DIR/"
    fi

    # Remove existing symlink if present
    if [[ -L "$dest" ]]; then
        rm "$dest"
    fi

    # Create the symlink
    ln -sf "$src" "$dest"
    info "Linked $dest -> $src"
}

main() {
    echo ""
    echo "================================"
    echo "  Dotfiles Installation Script  "
    echo "================================"
    echo ""

    # tmux
    if [[ -f "$DOTFILES_DIR/tmux/.tmux.conf" ]]; then
        info "Setting up tmux..."
        backup_and_link "$DOTFILES_DIR/tmux/.tmux.conf" "$HOME/.tmux.conf"
    fi

    # Add more configs here as you expand your dotfiles:
    #
    # nvim
    # if [[ -d "$DOTFILES_DIR/nvim" ]]; then
    #     info "Setting up nvim..."
    #     mkdir -p "$HOME/.config"
    #     backup_and_link "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"
    # fi
    #
    # zsh
    # if [[ -f "$DOTFILES_DIR/zsh/.zshrc" ]]; then
    #     info "Setting up zsh..."
    #     backup_and_link "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"
    # fi
    #
    # git
    # if [[ -f "$DOTFILES_DIR/git/.gitconfig" ]]; then
    #     info "Setting up git..."
    #     backup_and_link "$DOTFILES_DIR/git/.gitconfig" "$HOME/.gitconfig"
    # fi

    echo ""
    info "Installation complete!"
    
    if [[ -d "$BACKUP_DIR" ]]; then
        warn "Backups saved to: $BACKUP_DIR"
    fi

    echo ""
    echo "To apply tmux config now, run:"
    echo "  tmux source-file ~/.tmux.conf"
    echo ""
}

main "$@"
