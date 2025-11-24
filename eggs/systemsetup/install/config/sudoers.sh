#!/usr/bin/env bash
echo "Creating drop-in sudoers user rules..."
# Allows certain commands to run without sudo for my user
echo "$USER ALL=(ALL) NOPASSWD: /usr/bin/pacman -Syu --noconfirm" | sudo tee /etc/sudoers.d/01_"$USER" > /dev/null
echo "$USER ALL=(ALL) NOPASSWD: /usr/bin/checkupdates -d" | sudo tee /etc/sudoers.d/01_checkupdates > /dev/null
