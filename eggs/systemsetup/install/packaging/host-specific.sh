#!/usr/bin/env bash
# Install all host specific packages
echo -e "\e[32m\nInstalling host specific packages...\e[0m"

package_path="$setup_install/01-$HOSTNAME-packages.txt"
if [[ ! -f "$package_path" ]]; then
    printf "Host specific package file doesn't exist!\nExpected file to be at:[%s]" "$package_path"
    exit
fi

mapfile -t packages < <(grep -v '^#' "$package_path" | grep -v '^$')
yay -S --needed "${packages[@]}"
