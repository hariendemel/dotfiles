#!/bin/bash
if [[ -f "$HOME/.oh-my-zsh/oh-my-zsh.sh" ]]; then
  exit 0
fi
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
