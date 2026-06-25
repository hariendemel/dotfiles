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
- Install all Homebrew packages from `Brewfile`
- Apply macOS system settings (keyboard, trackpad, autocorrect)
- Configure iTerm2 to load preferences from `~/.config/iterm/`

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

