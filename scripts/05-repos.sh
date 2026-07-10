#!/bin/zsh
# scripts/05-repos.sh
# @file 05-repos.sh
# @description Clones every repo into the ~/Development/<brand>/code structure.
#              Idempotent — skips repos that already exist.
set -euo pipefail

# Explicit PATH — do not rely on inherited environment (fix 2026-07-10)
export PATH="/usr/bin:/bin:/usr/sbin:/sbin:/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"

DEV="$HOME/Development"

# "local/path|github-slug" — generated from audit 2026-07-06
REPOS=(
  "cb/code/cb-affiliate-api-script|TinyCB/Chaturbate-affiliate-api-script"
  "cb/code/cb-broadcaster-field-notes|Ryder-Industries-LLC/cb-broadcaster-field-notes"
  "mhc/code/hudson-cage|Ryder-Industries-LLC/hudson-cage"
  "mhc/code/joycaption|fpgaminer/joycaption"
  "mhc/code/mhc-control-panel-legacy|Refineo-Studios-LLC/mhc-control-panel-legacy"
  "mhc/code/mhc-cp|Refineo-Studios-LLC/mhc-cp"
  "personal/code/advanced-ops|tracycsmith/advanced-ops"
  "personal/code/finance-operations|tracycsmith/finance-operations"
  "personal/code/ynab-reporter|tracycsmith/ynab-reporter"
  "phase2/code/pims-ops-portal-legacy|Refineo-Studios-LLC/pims-ops-portal-legacy"
  "phase2/code/pims-ops-portal|phase2/pims-ops-portal"
  "refineo/code/personal-dam|Refineo-Studios-LLC/personal-dam"
  "refineo/code/refineo-laptop-config|tracycsmith/refineo-laptop-config"
  "refineo/code/refineo-studios-site|Refineo-Studios-LLC/refineo-studios-site"
  "shared/code/claude-baseline|Refineo-Studios-LLC/claude-baseline"
  "shared/code/media-vault-ops|Ryder-Industries-LLC/media-vault-ops"
  "shared/code/mintlifly-docs|refineo-studios-llc/docs"
  "shared/code/sanity|tracycsmith/sanity"
  "shared/code/snippets|tracycsmith/snippets"
)

for entry in "${REPOS[@]}"; do
  repo_dir="${entry%%|*}"; slug="${entry##*|}"
  if [ -d "$DEV/$path/.git" ]; then
    echo "  skip  $path (exists)"
  else
    echo "  clone $slug -> $path"
    mkdir -p "$DEV/$(dirname "$repo_dir")"
    gh repo clone "$slug" "$DEV/$path" || echo "  FAILED: $slug (check access)"
  fi
done

echo "==> Remember: .env files are NOT in git. See docs/audit + 1Password to restore:"
grep -h "" /dev/null <<'ENVS'
  refineo/code/personal-dam/.env
  phase2/code/pims-ops-portal/.env.local
  shared/code/media-vault-ops/.env
  mhc/code/mhc-control-panel-legacy/.env  (+ .envrc for direnv)
  mhc/code/mhc-cp/.env
ENVS
echo "==> Next: scripts/06-services.sh"
