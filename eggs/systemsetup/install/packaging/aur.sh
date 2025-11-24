#!/usr/bin/env bash
# Install all AUR packages
echo -e "\e[32m\nInstalling AUR packages...\e[0m"
mapfile -t packages < <(grep -v '^#' "$setup_install/01-aur-packages.txt" | grep -v '^$')
yay -S --needed "${packages[@]}"
