# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Repo Is

Personal dotfiles managed by [chezmoi](https://www.chezmoi.io/). Changes here are applied to `~` by running `chezmoi apply`.

## Key Commands

```bash
chezmoi apply          # Apply changes from this repo to the home directory
chezmoi diff            # Preview what chezmoi apply would change
chezmoi add <file>      # Add/update a file from ~ into this repo
chezmoi edit <file>     # Edit a dotfile via chezmoi (uses the source path)
chezmoi execute-template < file.tmpl   # Render a template to check it parses correctly
```

## Chezmoi File Naming Conventions

| Prefix/Suffix | Effect |
|--------|--------|
| `dot_` | Installed with a leading `.` (e.g. `dot_zshrc` → `~/.zshrc`) |
| `private_` | File permissions set to 0600; for sensitive files like `~/Library/` |
| `.tmpl` | Go template, rendered before being applied |

Templates are used sparingly — only in `.chezmoiscripts/` to embed a SHA256 of a companion data file in a comment, so the script re-runs whenever that file's content changes (e.g. `run_onchange_brew-bundle.sh.tmpl`, `run_onchange_extra-commands.sh.tmpl`). Regular dotfiles are not templated.

`readme.md`, `CLAUDE.md`, and all `Brewfile*` files are listed in `.chezmoiignore` — they're source-only documentation/data, not applied to `~`.

## Architecture / Structure

**Shell (`dot_config/zsh/`)** — Zsh, no framework (no Oh My Zsh/Powerlevel10k). `ZDOTDIR` is set to `~/.config/zsh` by a run-once script since macOS reads `/etc/zshenv` before `~/.zshenv`. Starship provides the prompt (`starship.toml`, sourced via `prompt.zsh`). A minimal custom plugin manager (`plugin.zsh`) shallow-clones `zsh-users` plugins on demand into `zsh/plugin/`. Aliases live under `alias/alias*.zsh` and are auto-sourced by `dot_zshrc`.

**Git (`dot_gitconfig`, `dot_config/git/`)** — Global gitconfig uses `delta` as pager (catppuccin-mocha theme via `config-catppuccin-delta`) and rebase-by-default pulls. Conditionally includes `config-fb` (overrides user email) for repos under `~/src/fb/`.

**Terminal emulators (`dot_config/kitty/`, `dot_config/ghostty/`)** — Catppuccin-mocha themed; kitty has a custom keymap for `herdr` integration.

**Editors (`dot_config/nvim/`, `dot_config/zed/`)** — Neovim uses the native `vim.pack.add` package manager (no plugin-manager plugin), split into `lua/config/` (options/keymaps/autocmds/functions) and `lua/plugin/` (per-plugin setup: LSP, treesitter, git, session, UI). Zed has `private_settings.json` (user-specific, hence `private_`) and `keymap.json`.

**Other tools** — `lazygit` (diff rendering config), `lf` (file manager: colors/icons/lfrc), `herdr` (`config.toml`), `gh` (`private_config.yml` for the `gh` CLI's own config, not extensions — see below).

**SSH (`dot_ssh/config`)** — SSH host entries; uses macOS Keychain (`UseKeychain yes`).

**Private files (`private_Library/`)** — Syncs a subset of `~/Library/` (currently JetBrains PyCharm keymaps). `private_` sets restrictive permissions, not encryption — encryption requires a separately-configured chezmoi age/GPG key.

**Package management (`Brewfile`, `Brewfile.personal`, `Brewfile.work`)** — Declarative Homebrew packages. Applied by `run_onchange_brew-bundle.sh.tmpl`: an always-installed default set, plus a machine-group set (`work`/`personal`) selected by hostname pattern.

**One-off setup commands (`extra-commands`)** — Generic manifest of arbitrary shell commands, one per line (`#`-prefixed and blank lines skipped) — e.g. `gh extension install dlvhdr/gh-dash`. Applied by `run_onchange_extra-commands.sh.tmpl`, which re-runs whenever the manifest changes and tolerates per-line failures (`|| true`), so re-running an already-applied command (e.g. "extension already installed") doesn't break `chezmoi apply`. Use this for anything that doesn't fit Homebrew (gh/npm/pipx installs, etc.); if something needs real per-manager idempotency logic rather than "ignore failure," give it its own `run_once_`/`run_onchange_` script instead.

## Auto Scripts (`.chezmoiscripts/`)

Execute automatically on `chezmoi apply`:
- `run_once_setup-dock.sh` — configures the macOS Dock (autohide, trimmed default apps); once per machine
- `run_once_zsh-zdotdir.sh` — points `ZDOTDIR` at `~/.config/zsh` via `/etc/zshenv`; idempotent, requires sudo, once per machine
- `run_onchange_brew-bundle.sh.tmpl` — installs Homebrew packages from the Brewfiles; re-runs when any Brewfile changes
- `run_onchange_extra-commands.sh.tmpl` — replays one-off shell commands from `extra-commands`; re-runs when that file changes
- `run_onchange_macos-settings.sh` — macOS system defaults (keyboard repeat, trackpad, autocorrect, dark mode); requires sudo
