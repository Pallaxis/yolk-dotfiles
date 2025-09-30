#!/usr/bin/env bash
# Work in progress script to sync important parts of my arch machines

sync_packages() {
    # Takes hostname's packages and installs along with a list of base packages
    # TODO: Really messy with newline seperated/space space seperated arrays.
    # change to just convert one way when I need to, probably just before using it in yay
    # as that would make all other operations easier
    local hostname
    hostname=$(hostnamectl hostname)
    local packages_dir=$HOME/.config/yolk/eggs/extras/packages
    local hostname_packages_file="$packages_dir/$hostname-packages.txt"
    local base_packages_file="$packages_dir/base-packages.txt"

    # Reads in as space seperated values
    if [[ -f "$hostname_packages_file" && -f "$base_packages_file" ]]; then
        mapfile -t spaces_hostname_packages < "$hostname_packages_file"
        mapfile -t spaces_base_packages < "$base_packages_file"
        mapfile -t spaces_installed_packages < <(pacman -Qeq)
    else
        echo "Missing 1 or more packages.txt file!"
        exit
    fi
    # Convert to newline seperated values
    newline_base_packages=$(echo "${spaces_base_packages[@]}" | tr ' ' '\n')
    newline_hostname_packages=$(echo "${spaces_hostname_packages[@]}" | tr ' ' '\n')
    newline_installed_packages=$(echo "${spaces_installed_packages[@]}" | tr ' ' '\n')
    # Combine and sort the final list
    newline_combined_packages=$(printf "%s\n" "${newline_base_packages[@]}" "${newline_hostname_packages[@]}" | sort)
    spaces_combined_packages+=("${spaces_hostname_packages[@]}" "${spaces_base_packages[@]}")

    echo "Starting by updating system..."
    yay -Syu --answerdiff All

    echo "Ensuring $hostname's packages & base packages are installed..."
    yay -S --needed "${spaces_combined_packages[@]}"

    printf "\nExplicitly installed packages not in either list:\n"
    comm -23 <(printf "%s\n" "${newline_installed_packages[@]}" | sort) <(printf "%s\n" "${newline_combined_packages[@]}" | sort)
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

    # Keyd, fix to recognise the virtual keyboard as a real keyboard
    # this fixes the auto touchpad disable
    cat << EOF | sudo tee /etc/libinput/local-overrides.quirks
[Serial Keyboards]
MatchUdevType=keyboard
MatchName=keyd virtual keyboard
AttrKeyboardIntegration=internal
EOF
    # Keyd config
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

# Reflector conf
sudo sed -i \
    -e '/^--country/c\
--country New\\ Zealand,Australia,Singapore,Japan' \
    -e '/^--sort/c\
--sort rate' /etc/xdg/reflector/reflector.conf

# SSHD config hardening
    cat << EOF | sudo tee /etc/ssh/sshd_config.d/20-force_public_key_auth.conf
PasswordAuthentication no
AuthenticationMethods publickey
EOF
    cat << EOF | sudo tee /etc/ssh/sshd_config.d/20-disallow_root_login.conf
PermitRootLogin no
EOF

sudo systemctl try-restart sshd.service

# UFW
echo "Run this command to setup simple firewall rules:"
echo "sudo ufw limit ssh && sudo ufw enable"
}

sync_services(){
    # Ensures all services are enabled and running
    # TODO: setup a root services file too, this is just user units
    user_service_list=$HOME/.config/yolk/eggs/extras/systemd-services
    root_service_list=$HOME/.config/yolk/eggs/extras/systemd-root-services
    if [[ ! -f "$user_service_list" || ! -s "$user_service_list" ]]; then
        echo "User service list file does not exist or is empty."
        exit 1
    fi
    if [[ ! -f "$root_service_list" || ! -s "$root_service_list" ]]; then
        echo "Root service list file does not exist or is empty."
        exit 1
    fi

    # Check each user service individually
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
    done < "$user_service_list"

    # Check each root service individually
    while IFS= read -r service; do
        local enabled=true
        local active=true
        if [[ -n "$service" ]]; then
            # Enable if not already enabled
            if ! systemctl is-enabled "$service" | grep -qx 'enabled'; then
                enabled=false
                echo -e "\033[33mEnabling service: $service\033[0m"
                sudo systemctl --user enable "$service"
            fi
            # Start if not already running
            if ! systemctl is-active "$service" | grep -qx 'active'; then
                active=false
                echo -e "\033[33mStarting service: $service\033[0m"
                sudo systemctl start "$service"
            fi
            if $enabled && $active; then
                echo "$service is already enabled & running"
            fi
        fi
    done < "$root_service_list"
}

hostname=$(hostnamectl hostname)

# sync_packages
sync_configs
sync_services
