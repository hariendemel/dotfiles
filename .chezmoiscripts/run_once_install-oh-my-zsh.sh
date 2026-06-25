#!/bin/bash

# Install Oh My Zsh core without the official installer, which aborts if
# ~/.oh-my-zsh already exists (chezmoi creates it for the custom/ alias files).
if [[ ! -f "$HOME/.oh-my-zsh/oh-my-zsh.sh" ]]; then
  git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh.git /tmp/ohmyzsh-install
  rsync -a --exclude=custom/ /tmp/ohmyzsh-install/ "$HOME/.oh-my-zsh/"
  rm -rf /tmp/ohmyzsh-install
fi

# Install custom plugins and theme (skip if already cloned)
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

_clone_if_missing() {
  [[ -d "$2/.git" ]] || git clone --depth=1 "$1" "$2"
}

_clone_if_missing https://github.com/zsh-users/zsh-autosuggestions     "${ZSH_CUSTOM}/plugins/zsh-autosuggestions"
_clone_if_missing https://github.com/zsh-users/zsh-syntax-highlighting "${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting"
_clone_if_missing https://github.com/luismayta/zsh-trash               "${ZSH_CUSTOM}/plugins/zsh-trash"
_clone_if_missing https://github.com/romkatv/powerlevel10k             "${ZSH_CUSTOM}/themes/powerlevel10k"
