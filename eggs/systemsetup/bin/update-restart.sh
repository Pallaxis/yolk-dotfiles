#!/usr/bin/env bash

if [ "$(uname -r | sed 's/-arch/\.arch/')" != "$(pacman -Q linux | awk '{print $2}')" ]; then
  gum confirm "Linux kernel has been updated. Reboot?" && sudo reboot now
  echo
fi
