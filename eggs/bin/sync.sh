#!/usr/bin/env bash
# Work in progress script to sync important parts of my arch machines

sync_packages() {
    # Takes the hostname as an argument then ensures all the needed
    # packages are installed.
    local packages_dir=$HOME/.config/yolk/eggs/extras/packages
    local argument=$1
    local path_to_packages="$packages_dir/$argument-packages.txt"

    echo "Starting by updating system..."
    yay -Syu

    if [[ -f $path_to_packages ]]; then
        echo "Ensuring $argument packages are installed..."
        xargs -a "$path_to_packages" yay -S --needed
    else
        echo "No package file found for: $argument"
    fi
}

sync_configs() {
    # Writes my config files as sudo to /etc/ dirs
    if [[ -n $SUDO_USER ]]; then
        echo "Don't run script as root"
    else
        username=$USER
    fi

    echo "$username ALL=(ALL) NOPASSWD: /usr/bin/pacman -Syu --noconfirm" | sudo tee /etc/sudoers.d/01_"$username"
    echo "$username ALL=(ALL) NOPASSWD: /usr/bin/checkupdates -d" | sudo tee /etc/sudoers.d/01_checkupdates

    cat << EOF | sudo tee /etc/libinput/local-overrides.quirks
[Serial Keyboards]
MatchUdevType=keyboard
MatchName=keyd virtual keyboard
AttrKeyboardIntegration=internal
EOF

    cat << EOF | sudo tee /etc/keyd/default.conf
[ids]
* = *

[main]
# Swaps caps and escape keys around
capslock = esc
esc = capslock

# PrtSc on thinkpad mapped to meta
sysrq = layer(meta)
EOF
}

sync_services(){
    # Ensures all services are enabled and running
    service_list=$HOME/.config/yolk/eggs/extras/systemd-services
    if [[ ! -f "$service_list" || ! -s "$service_list" ]]; then
        echo "Service list file does not exist or is empty."
        return 1
    fi

    # Check each service individually
    while IFS= read -r service; do
        local enabled=true
        local active=true
        if [[ -n "$service" ]]; then
            # Enable if not already enabled
            if ! systemctl --user is-enabled "$service" | grep -qx 'enabled'; then
                enabled=false
                echo -e "\033[33mEnabling service: $service\033[0m"
                systemctl --user enable "$service"
            fi

            # Start if not already running
            if ! systemctl --user is-active "$service" | grep -qx 'active'; then
                active=false
                echo -e "\033[33mStarting service: $service\033[0m"
                systemctl --user start "$service"
            fi

            if $enabled && $active; then
                echo "$service is already enabled & running"
            fi
        fi
    done < "$service_list"
}

hostname=$(hostnamectl hostname)

sync_packages base
sync_packages $hostname
# sync_configs
#sync_services
