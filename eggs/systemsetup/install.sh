#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status
set -eEo pipefail

# Exports
export setup_path="$HOME/.local/share/system-setup"
export setup_install="$setup_path/install"
export PATH="$setup_path/bin:$PATH"

# run it
source "$setup_install/preflight/all.sh"
source "$setup_install/packaging/all.sh"
source "$setup_install/config/all.sh"
