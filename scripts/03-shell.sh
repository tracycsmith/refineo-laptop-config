#!/bin/zsh
# scripts/03-shell.sh
# @file 03-shell.sh
# @description Installs oh-my-zsh and copies dotfiles from this repo into $HOME.
#              Existing files are backed up to ~/dotfile-backups-<date>/.
set -euo pipefail
REPO="$HOME/Development/refineo/code/refineo-laptop-config"
BAK="$HOME/dotfile-backups-$(date +%Y%m%d-%H%M)"

echo "==> oh-my-zsh"
[ -d "$HOME/.oh-my-zsh" ] || sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

echo "==> Dotfiles (backing up existing to $BAK)"
mkdir -p "$BAK" "$HOME/.zsh.d" "$HOME/.ssh" "$HOME/.config/git"
for f in .zshrc .zshenv .zprofile .gitconfig; do
  [ -f "$HOME/$f" ] && cp "$HOME/$f" "$BAK/" || true
  cp "$REPO/dotfiles/$f" "$HOME/$f"
done
cp "$REPO/dotfiles/zsh.d/aliases.mine.zsh" "$HOME/.zsh.d/"
cp "$REPO/dotfiles/ssh_config" "$HOME/.ssh/config"
chmod 600 "$HOME/.ssh/config"
cp "$REPO/dotfiles/git_allowed_signers" "$HOME/.config/git/allowed_signers"

echo "==> 1Password SSH agent config (enables Brand: Main / Employee / Private vaults)"
mkdir -p "$HOME/.config/1Password/ssh"
cp "$REPO/dotfiles/config-1password-ssh/agent.toml" "$HOME/.config/1Password/ssh/"

echo "==> NOTE: SSH keys live in 1Password (IdentityAgent). No key files to copy."
echo "==> Next: scripts/04-dev.sh (open a NEW terminal first so dotfiles load)"
