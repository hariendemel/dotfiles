#!/bin/bash

# Enable auto-hide
defaults write com.apple.dock autohide -bool true

# Remove all default apps, keep only Mail, Reminders, Notes, Calendar
dockutil --remove all --no-restart
dockutil --add /System/Applications/Mail.app       --no-restart
dockutil --add /System/Applications/Reminders.app --no-restart
dockutil --add /System/Applications/Notes.app      --no-restart
dockutil --add /System/Applications/Calendar.app   --no-restart

killall Dock
