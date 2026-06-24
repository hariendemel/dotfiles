#!/bin/bash
# Tell iTerm2 to load preferences from the chezmoi-managed folder
defaults write com.googlecode.iterm2 PrefsCustomFolder -string "${HOME}/.config/iterm"
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true
