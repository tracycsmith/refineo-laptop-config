#!/bin/zsh
# scripts/07-place-transfer.sh
# @file 07-place-transfer.sh
# @description Places the AirDropped ~/laptop-transfer bundle: overlays Development
#              working files (uncommitted changes, .env files, non-git projects,
#              brand docs/assets) onto the fresh clones, restores ~/.aws and ~/.claude.
#              RUN AFTER scripts/05-repos.sh. Never deletes anything (no --delete).
set -euo pipefail
T="$HOME/laptop-transfer"
[ -d "$T" ] || { echo "ERROR: $T not found — AirDrop the laptop-transfer folder to home first"; exit 1; }

echo "==> Overlaying Development working files onto cloned repos"
rsync -a "$T/Development/" "$HOME/Development/"

echo "==> ~/.aws (credentials)"
mkdir -p "$HOME/.aws" && rsync -a "$T/dot-aws/" "$HOME/.aws/" && chmod 600 "$HOME/.aws/credentials" 2>/dev/null || true

echo "==> ~/.claude (CLAUDE.md, settings, skills, commands)"
mkdir -p "$HOME/.claude" && rsync -a "$T/dot-claude/" "$HOME/.claude/"

echo "==> Verifying the 5 .env files landed:"
for f in refineo/code/personal-dam/.env phase2/code/pims-ops-portal/.env.local \
         shared/code/media-vault-ops/.env mhc/code/mhc-control-panel-legacy/.env \
         mhc/code/mhc-cp/.env; do
  [ -f "$HOME/Development/$f" ] && echo "  OK  $f" || echo "  MISSING  $f"
done

echo "==> Repos will show uncommitted changes — that's your old WIP, review with git status"
echo "==> When satisfied: rm -rf ~/laptop-transfer"
