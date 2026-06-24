# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Repo Is

Personal dotfiles managed by [chezmoi](https://www.chezmoi.io/). Changes here are applied to `~` by running `chezmoi apply`.

## Key Commands

```bash
chezmoi apply          # Apply changes from this repo to the home directory
chezmoi diff           # Preview what chezmoi apply would change
chezmoi add <file>     # Add/update a file from ~ into this repo
chezmoi edit <file>    # Edit a dotfile via chezmoi (uses the source path)
```

## Chezmoi File Naming Conventions

| Prefix | Effect |
|--------|--------|
| `dot_` | Installed with a leading `.` (e.g. `dot_zshrc` → `~/.zshrc`) |
| `private_` | File permissions set to 0600; for sensitive files like `~/Library/` |

This repo does **not** use chezmoi templates (`.tmpl` files).

## Architecture / Structure

**Shell (`dot_zshrc`, `dot_p10k.zsh`)** — Zsh with Oh My Zsh and Powerlevel10k. NVM and pyenv are initialised here.

**Oh My Zsh customisations (`dot_oh-my-zsh/custom/`)** — All alias/function files are sourced automatically by Oh My Zsh:
- `alias.zsh` — General aliases (`colorls`, DNS helpers, git shortcuts)
- `alias-fb.zsh` — Forsyth Barr work aliases (AWS CodeArtifact auth via `py-auth`)
- `alias-tf.zsh` — Terraform shorthand (`t`, `ti`, `tp`, `ta`, `tc`, etc.)

**Git (`dot_gitconfig`, `dot_config/git/config-fb`)** — The global gitconfig conditionally includes `~/.config/git/config-fb` for repos under `~/src/fb/`, overriding the email to the work address. Edit `dot_config/git/config-fb` for work-specific git settings.

**SSH (`dot_ssh/config`)** — SSH host entries; uses macOS Keychain (`UseKeychain yes`).

**iTerm2 (`dot_config/iterm/`)** — Full iTerm2 plist, installed to `~/.config/iterm/`. A run-once chezmoi script (`.chezmoiscripts/run_once_iterm-prefs.sh`) points iTerm2 at that folder automatically on `chezmoi apply`.

**Private files (`private_Library/`)** — Syncs `~/Library/` content (currently JetBrains keymaps). The `private_` prefix sets restrictive permissions but does **not** encrypt on its own — encryption requires a chezmoi age/GPG key to be configured separately.

## Auto Scripts (`.chezmoiscripts/`)

These execute automatically on `chezmoi apply` and re-run whenever their content changes (`run_onchange_`):
- `run_onchange_macos-settings.sh` — macOS system defaults (keyboard repeat, trackpad, autocorrect); requires sudo
- `run_onchange_iterm-prefs.sh` — points iTerm2 at `~/.config/iterm/` for its preferences
