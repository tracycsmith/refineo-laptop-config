#!/bin/zsh
# scripts/08-repair-repos.sh
# @file 08-repair-repos.sh
# @description Repairs repos whose folders exist (from the transfer overlay) but
#              lack .git — clones metadata only (--no-checkout) and grafts the
#              .git dir in place. Working files are untouched and show up as
#              uncommitted changes. Idempotent: skips repos that already have .git.
set -uo pipefail
DEV="$HOME/Development"
TMP=$(mktemp -d)

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
  "refineo/code/refineo-studios-site|Refineo-Studios-LLC/refineo-studios-site"
  "shared/code/claude-baseline|Refineo-Studios-LLC/claude-baseline"
  "shared/code/media-vault-ops|Ryder-Industries-LLC/media-vault-ops"
  "shared/code/mintlifly-docs|refineo-studios-llc/docs"
  "shared/code/sanity|tracycsmith/sanity"
  "shared/code/snippets|tracycsmith/snippets"
)

ok=0; fail=0
for entry in "${REPOS[@]}"; do
  path="${entry%%|*}"; slug="${entry##*|}"
  dir="$DEV/$path"
  if [ -d "$dir/.git" ]; then echo "  skip   $path (has .git)"; continue; fi
  if [ ! -d "$dir" ]; then
    echo "  clone  $slug (folder missing entirely)"
    mkdir -p "$(dirname "$dir")"
    gh repo clone "$slug" "$dir" && ok=$((ok+1)) || fail=$((fail+1))
    continue
  fi
  echo "  graft  $slug -> $path"
  work="$TMP/$(basename "$path")"
  if git clone --no-checkout "https://github.com/$slug.git" "$work" >/dev/null 2>&1; then
    mv "$work/.git" "$dir/.git"
    git -C "$dir" reset >/dev/null 2>&1   # unstage; files become working-tree changes
    ok=$((ok+1))
  else
    echo "  FAILED $slug (check access)"; fail=$((fail+1))
  fi
done
rm -rf "$TMP"
echo "==> grafted/cloned: $ok, failed: $fail"
echo "==> Spot check: cd \$PROJECT_REF && git status   (expect your old WIP as changes)"
