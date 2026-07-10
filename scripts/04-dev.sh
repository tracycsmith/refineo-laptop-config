#!/bin/zsh
# scripts/04-dev.sh
# @file 04-dev.sh
# @description Dev toolchain: nvm/node versions, npm globals, pm2, VS Code extensions.
set -euo pipefail

# Explicit PATH — do not rely on inherited environment (fix 2026-07-10)
export PATH="/usr/bin:/bin:/usr/sbin:/sbin:/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"

REPO="$HOME/Development/refineo/code/refineo-laptop-config"
export NVM_DIR="$HOME/.nvm"; mkdir -p "$NVM_DIR"
source "$(brew --prefix nvm)/nvm.sh" --no-use

echo "==> Node via nvm (latest LTS as default; add others as projects demand)"
nvm install --lts
# Concrete version alias — 'lts/*' leaves an unresolvable glob in PATH via .zshenv
nvm alias default "$(nvm version)"

echo "==> npm globals"
npm install -g fast-cli pm2
# corepack ships with node; mint was old-machine only — reinstall if needed: npm i -g mint

echo "==> VS Code extensions ($(wc -l < "$REPO/vscode-extensions.txt" | tr -d ' ') of them)"
command -v code >/dev/null || echo "Launch VS Code once: Cmd+Shift+P > 'Install code command'"
xargs -n1 code --install-extension < "$REPO/vscode-extensions.txt" || true

echo "==> pm2 ecosystem"
mkdir -p "$HOME/.config/pm2"
cp "$REPO/exports/pm2/ecosystem.config.cjs" "$HOME/.config/pm2/" 2>/dev/null || true
echo "    Start later with: pm2 start ~/.config/pm2/ecosystem.config.cjs && pm2 save"

echo "==> Next: scripts/05-repos.sh"
