# dotfiles

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io/).

## New machine setup

```bash
# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install chezmoi and apply dotfiles
brew install chezmoi
chezmoi init --apply git@github.com:hariendemel/dotfiles.git
```

`chezmoi apply` will automatically:
- Install all Homebrew packages from `Brewfile` (plus a `personal`/`work` group file based on hostname)
- Run any one-off setup commands listed in `extra-commands.txt` (e.g. installing `gh` CLI extensions)
- Apply macOS system settings (keyboard, trackpad, autocorrect, dark mode)
- Point `ZDOTDIR` at `~/.config/zsh` and configure the Dock

After applying, restart your terminal for all shell changes to take effect.

## Daily workflow

| Task | Command |
|------|---------|
| Edit a dotfile | `chezmoi edit ~/.zshrc` |
| Preview pending changes | `chezmoi diff` |
| Apply source changes to `~` | `chezmoi apply` |
| Pull in changes made directly in `~` | `chezmoi re-add` |
| Add a new file to be tracked | `chezmoi add ~/.config/something` |

> **Never edit files in `~` and the chezmoi source at the same time.** If both diverge, run `chezmoi merge <file>` to resolve the conflict.

## Adding a new Homebrew package

```bash
edit <repo-path>/Brewfile # add the line
chezmoi apply             # runs homebrew with the Brewfile
```

## Adding a one-off setup command

For anything that doesn't fit Homebrew (e.g. `gh` CLI extensions, `npm`/`pipx` global installs):

```bash
edit <repo-path>/extra-commands.txt  # add a line, e.g. `gh extension install dlvhdr/gh-dash`
chezmoi apply                        # runs it once; safe to re-run — failures on already-applied commands are ignored
```

