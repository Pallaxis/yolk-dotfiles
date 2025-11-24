#!/usr/bin/env bash

export setup_path="$HOME/.local/share/system-setup"
export setup_install="$setup_path/install"

set -e

gum style --border normal --border-foreground 6 --padding "1 2" \
  "Sync packages with upstream?" \

if ! gum confirm "Continue with sync?"; then
  echo "Sync cancelled"
  exit
fi

source "$setup_install/packaging/all.sh"
