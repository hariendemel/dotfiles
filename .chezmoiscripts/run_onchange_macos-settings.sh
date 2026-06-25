#!/bin/bash
# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Disable automatic capitalization as it's annoying when typing code
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# Disable smart dashes as they're annoying when typing code
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Disable automatic period substitution as it's annoying when typing code
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

# Disable smart quotes as they're annoying when typing code
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Trackpad: enable tap to click (built-in and Bluetooth)
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Set a blazingly fast keyboard repeat rate
# NOTE: requires logout/login to take effect
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 10

# Flush preferences cache so settings apply without a full restart where possible
killall cfprefsd 2>/dev/null || true

# Dock: enable auto-hide
defaults write com.apple.dock autohide -bool true

# Dock: remove all default apps, keep only Mail, Reminders, Notes, Calendar
dockutil --remove all --no-restart
dockutil --add /System/Applications/Mail.app        --no-restart
dockutil --add /System/Applications/Reminders.app  --no-restart
dockutil --add /System/Applications/Notes.app       --no-restart
dockutil --add /System/Applications/Calendar.app    --no-restart

killall Dock
