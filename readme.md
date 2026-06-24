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
brew install <package>
chezmoi edit ~/Brewfile   # add the line
chezmoi apply             # script re-runs automatically due to Brewfile hash change
```

## Repo structure

```
Brewfile                          # Homebrew packages (deployed to ~/Brewfile)
dot_gitconfig                     # Global git config
dot_zshrc                         # Zsh config (oh-my-zsh, pyenv, nvm)
dot_oh-my-zsh/custom/             # Shell aliases (general, Forsyth Barr, Terraform)
dot_config/
  git/config-fb                   # Work git config (email override for ~/src/fb/)
  iterm/                          # iTerm2 preferences plist
  zed/                            # Zed editor settings and keymap
  gh/                             # GitHub CLI config
private_Library/                  # ~/Library files (JetBrains keymaps)
.chezmoiscripts/                  # Auto-run scripts on chezmoi apply
```

Files prefixed with `dot_` are installed with a leading `.` (e.g. `dot_zshrc` → `~/.zshrc`). Files prefixed with `private_` are installed with restricted permissions (chmod 600).
