#!/bin/bash
# Ensures /etc/zshenv exports ZDOTDIR so user zsh config lives in ~/.config/zsh.
# Required because on macOS /etc/zshenv is read before ~/.zshenv, and the
# ~/.zshenv path is only consulted when ZDOTDIR is unset — so the ZDOTDIR
# export must live at the system level for it to take effect.
# Idempotent: re-running is a no-op if the line is already present.

set -euo pipefail

sudo -v

TARGET="/etc/zshenv"
LINE='export ZDOTDIR="$HOME/.config/zsh"'

if [[ -f "$TARGET" ]] && grep -Fxq "$LINE" "$TARGET"; then
  exit 0
fi

TMP="$(mktemp)"
if [[ -f "$TARGET" ]]; then
  # Preserve any other lines we don't manage.
  grep -v -F 'export ZDOTDIR=' "$TARGET" > "$TMP" || true
else
  : > "$TMP"
fi
printf '%s\n' "$LINE" >> "$TMP"

sudo install -m 644 "$TMP" "$TARGET"
rm -f "$TMP"
