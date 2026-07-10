# Keyboard Maestro — retired 2026-07-10

Decision: NOT installed on new Mac. Full macro audit of old Mac showed only
two custom macros; both replaced natively.

## What KM actually did

| Macro | Hotkey | What it did | Replacement |
|---|---|---|---|
| cb-screenshot-to-mhc | Cmd-/ (Chrome-scoped) | Ran Apple Shortcut "cb-cam4-post" | Shortcuts.app > cb-cam4-post > Details > Add Keyboard Shortcut. Use Ctrl-Opt-Cmd-/ NOT Cmd-/ — native Shortcuts hotkeys are GLOBAL and Cmd-/ collides with VS Code toggle-comment |
| Obsidian Markdown | Cmd-Shift-L | Inserted "- [ ] " | Obsidian native checkbox toggle; or Raycast snippet + hotkey for system-wide |

WHY KM EXISTED AT ALL: the "CB" macro group was app-scoped to Google Chrome only,
so Cmd-/ fired the snapshot in Chrome but stayed untouched in every other app.
Native Shortcuts hotkeys cannot scope per-app — hence the unique global combo.

Everything else in the KM library = factory defaults (clipboard filters,
app/clipboard switchers). Nothing custom, nothing migrated.

Related Shortcuts that must exist on the new Mac (iCloud-synced):
- cb-cam4-post  (the Cmd-/ target)
- Grab CB Poster Screenshot

If Shortcuts didn't sync: export from old Mac via Shortcuts > right-click > share/export before wipe.

License: KM license key can stay archived in 1Password in case of future need.
