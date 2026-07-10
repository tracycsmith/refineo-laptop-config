# AGENT.md — refineo-laptop-config

Purpose: reproducible laptop setup + self-documenting machine state for Tracy Smith.
If a session dies, this file is the re-entry point.

## HANDOFF (2026-07-10 evening) — next session runs on the NEW MacBook

Migration is functionally complete. New machine is on the dock and is the daily driver.
Old Mac (Refineo) stays powered on the network as safety net until week-1 shakedown passes.

Open items (see TODO.md for full list):
1. WIP commit-or-discard pass across 17 repos (each carries old uncommitted changes)
2. Re-run scripts/09-benchmark.sh + 10-benchmark-chrome.sh after Spotlight settles (small-file test)
3. Claude setup on new Mac per docs/claude-setup.md (3 MCP re-adds, 7 desktop extensions)
4. CopyClip vs Raycast clipboard history trial during shakedown week
5. Week-1 shakedown, then wipe & sell old Mac per docs/02-post-plan.md
6. File 2025 state taxes -> then delete TurboTax (only Rosetta dependent)

Prereq for the new-Mac session to control that machine: install Desktop Commander
extension there first (docs/claude-setup.md).

## State (2026-07-10) — NEW LAPTOP BUILT

- Scripts 01-07 all executed successfully on new MacBook (user: tracycsmith)
- Development WIP, .envs, .aws, .claude transferred via AirDrop bundle + script 07
- iCloud Desktop & Documents: fresh-synced from old Mac after bucket archive (see docs/data-transfer.md)
- Remaining: smoke test, Raycast/iTerm2 imports, week-1 shakedown, then wipe old laptop

## Previous state (2026-07-06)

- Full audit of old laptop complete → docs/audit-2026-07-06.md
- Plan docs written: docs/00-pre-plan.md → 01-the-plan.md → 02-post-plan.md
- Scripts 00–06 written (preflight → bootstrap → apps → shell → dev → repos → services)
- Brewfile generated (leaves + casks + formerly hand-installed apps + mas)
- Dotfiles + launch agent + apple-card-filer script vendored into repo
- Docs mirrored to Obsidian: ~/Documents/Obsidian/Personal/40 Refineo Studios/Laptop Migration 2026/
- Reworked into a step-by-step guide: CSV lists → bullets; added docs/software-inventory.md
  (Keep/Drop/Decide), docs/macos-settings.md + scripts/00b (read-only prefs capture),
  docs/data-transfer.md (external-drive/network — NOT Migration Assistant)
- Fixed repo-slug typo reefineo→refineo in scripts 01 + 05

## Conventions

- Brewfile is the single source of truth for installed software
- Nothing sensitive in this repo — secrets are inventoried by LOCATION only, values in 1Password
- Every service must have an entry in docs/services-and-ports.md
- exports/ holds machine-generated state (brew dump, pg dump, pm2) — regenerate via scripts/00
- Scripts are idempotent zsh, numbered in run order

## Open decisions

- Transfer method: external drive / network via rsync — NOT Migration Assistant (docs/data-transfer.md)
- Keyboard Maestro: PENDING macro review — mainly a screensnap shortcut; old Stream Deck
  macros likely dead (Stream Deck not connected). Decide Keep/Drop after reviewing macros;
  if dropped, rebind screensnap in Raycast or Shortcuts.app. Tracked in software-inventory.md
- Docker: RESOLVED — OrbStack only. Both `brew "docker"` and `cask "docker-desktop"`
  dropped from Brewfile (OrbStack ships the docker CLI + engine)
- Node: plan installs latest LTS only (old machine had 5 versions)
- Cask names to verify: cleanmymac, commander-one, plottr
- Prune candidates from inventory review: docker-desktop (Drop), copyclip/corepack/mint,
  Elgato trio (streaming), GarageBand/iMovie (size)
