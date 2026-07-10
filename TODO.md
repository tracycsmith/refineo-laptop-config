# TODO — refineo-laptop-config

## DONE — migration executed 2026-07-10

- [x] All scripts 01-08 run; repos grafted; node/pm2/finance-ops verified

## Now (before Friday)

- [ ] Tracy: review `docs/software-inventory.md` — mark Keep/Drop/Decide per app, then edit Brewfile for Drops
- [ ] Tracy: mark remaining decisions (Docker engine, node versions)
- [ ] Keyboard Maestro macro review — what's still used? capture the screensnap trigger (see 00-pre-plan)
- [ ] Run scripts/00-preflight-old-laptop.sh on old machine
- [ ] Run scripts/00b-capture-settings.sh on old machine (macOS prefs → exports/macos-settings/)
- [ ] Manual exports (KM, OBS, Stream Deck, Raycast, iTerm2, TablePlus)
- [ ] Stage user data to external drive / network (see docs/data-transfer.md)
- [ ] Move .env files + AWS creds + license keys into 1Password
- [ ] Verify brew cask names: cleanmymac, commander-one, plottr

## Friday (new machine)

- [ ] Phases 1–8 in docs/01-the-plan.md

## After

- [ ] Week-1 shakedown checklist (docs/02-post-plan.md)
- [ ] Wipe + sell old laptop
- [ ] Schedule quarterly export refresh

## Post-migration cleanup (added 2026-07-09)

- [ ] iCloud Documents cleanup — old-Mac folders ("Desktop - <machine>" etc.) surfaced when new MacBook enabled Desktop & Documents sync. CAUTION: two-way sync, deletions propagate to all machines. Do AFTER week-1 shakedown, not during migration.

## Remaining (post-build, 2026-07-10)

- [ ] Verify 06: `brew services list | grep postgres` + `ls ~/Library/LaunchAgents` on new Mac
- [ ] iTerm2 prefs: copy exports/iterm2 plist BEFORE first iTerm2 launch config matters
- [ ] Raycast: Import Settings & Data from exports/raycast
- [ ] OrbStack first launch + Start at Login; docker compose up + re-seed project DBs
- [ ] Obsidian vault open + Keep Downloaded
- [ ] TurboTax: installer + license PDF in vault at 30 Finance/Records/Taxes/2025/TurboTax (iCloud-synced)
- [ ] Under My Roof: verify actually used before installing
- [ ] Plottr: trial only, never purchased - buy or drop (decision pending)
- [ ] Bind Cmd-/ to cb-cam4-post in Shortcuts.app on new Mac (see docs/keyboard-maestro-retirement.md)
- [x] Keyboard Maestro: audited + retired, not installing
- [ ] Commit-or-discard pass on WIP across repos (17 repos carry old uncommitted changes)
- [ ] Week-1 shakedown per docs/02-post-plan.md, then wipe & sell old laptop
