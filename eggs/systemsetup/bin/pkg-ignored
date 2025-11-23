#!/usr/bin/env bash
setup_path="$HOME/.local/share/system-setup"
setup_install="$setup_path/install"
ignored_packages_file="$setup_install/packages.ignored"

if [[ -f $ignored_packages_file ]]; then
  tr '\r\n' ',' <"$ignored_packages_file" | sed 's/,$//'
fi
