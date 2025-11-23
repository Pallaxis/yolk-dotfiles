#!/usr/bin/env bash
# Install all base packages
echo -e "\e[32m\nInstalling base packages...\e[0m"
mapfile -t packages < <(grep -v '^#' "$setup_install/01-base-packages.txt" | grep -v '^$')
sudo pacman -S --noconfirm --needed "${packages[@]}"
