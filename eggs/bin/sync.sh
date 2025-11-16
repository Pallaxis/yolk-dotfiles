#!/usr/bin/env bash
# Work in progress script to sync important parts of my arch machines

sync_packages() {
    # Takes hostname's packages and installs along with a list of base packages
    local hostname
    hostname=$(hostnamectl hostname)
    local packages_dir=$HOME/.config/yolk/eggs/extras/packages
    local base_packages_file="$packages_dir/base-packages.txt"
    local hostname_packages_file="$packages_dir/$hostname-packages.txt"

    # Reads in as space seperated values
    if [[ -f "$hostname_packages_file" && -f "$base_packages_file" ]]; then
        mapfile -t hostname_packages < "$hostname_packages_file"
        mapfile -t base_packages < "$base_packages_file"
        # mapfile -t installed_packages < <(pacman -Qeq)
    else
        echo "Missing 1 or more packages.txt file!"
        exit
    fi
    combined_packages+=("${hostname_packages[@]}" "${base_packages[@]}")

    echo "Starting by updating system..."
    yay -Syu --answerdiff All

    echo "Ensuring $hostname's packages & base packages are installed..."
    yay -S --needed "${combined_packages[@]}"

    # Unneeded as I have a function for diffing now
    # printf "\nExplicitly installed packages not in either list:\n"
    # comm -23 <(printf "%s\n" "${installed_packages[@]}" | sort) <(printf "%s\n" "${combined_packages[@]}" | sort)
}

sync_configs() {
    # Writes my config files as sudo to /etc/ dirs
    if [[ -n $SUDO_USER ]]; then
        echo "Don't run script as root"
        exit
    fi

    # GTK3/4
    gsettings set org.gnome.desktop.interface gtk-theme "Catppuccin-Blue-Dark"
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

    echo "$USER ALL=(ALL) NOPASSWD: /usr/bin/pacman -Syu --noconfirm" | sudo tee /etc/sudoers.d/01_"$USER" > /dev/null
    echo "$USER ALL=(ALL) NOPASSWD: /usr/bin/checkupdates -d" | sudo tee /etc/sudoers.d/01_checkupdates > /dev/null

    # Keyd, fix to recognise the virtual keyboard as a real keyboard
    # this fixes the auto touchpad disable
    sudo tee /etc/libinput/local-overrides.quirks > /dev/null <<EOF
[Serial Keyboards]
MatchUdevType=keyboard
MatchName=keyd virtual keyboard
AttrKeyboardIntegration=internal
EOF
    # Keyd config
    sudo tee /etc/keyd/default.conf > /dev/null <<EOF
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
    sudo tee /etc/ssh/sshd_config.d/20-force_public_key_auth.conf > /dev/null <<EOF
PasswordAuthentication no
AuthenticationMethods publickey
EOF
    sudo tee /etc/ssh/sshd_config.d/20-disallow_root_login.conf > /dev/null <<EOF
PermitRootLogin no
EOF

# SSH Agent setting
    sudo tee /etc/ssh/ssh_config.d/50-ssh-agent-add-keys.conf > /dev/null <<EOF
AddKeysToAgent yes
EOF

sudo systemctl try-restart sshd.service

# setting up hosts as described in the arch wiki for avahi
sudo tee /etc/nsswitch.conf > /dev/null <<EOF
# Name Service Switch configuration file.
# See nsswitch.conf(5) for details.

passwd: files systemd
group: files [SUCCESS=merge] systemd
shadow: files systemd
gshadow: files systemd

publickey: files

hosts: mymachines mdns_minimal [NOTFOUND=return] resolve [!UNAVAIL=return] files myhostname dns
networks: files

protocols: files
services: files
ethers: files
rpc: files

netgroup: files
EOF

# UFW
cat <<EOF
My current UFW setup 13/11/25
 sudo ufw status verbose
Status: active
Logging: off
Default: deny (incoming), allow (outgoing), disabled (routed)
New profiles: skip

To                         Action      From
--                         ------      ----
6881/tcp (qBittorrent)     ALLOW IN    Anywhere
5353/udp (Bonjour)         ALLOW IN    Anywhere
5298 (Bonjour)             ALLOW IN    Anywhere
22                         LIMIT IN    Anywhere
22000 (syncthing)          ALLOW IN    Anywhere
21027/udp (syncthing)      ALLOW IN    Anywhere
6881/tcp (qBittorrent (v6)) ALLOW IN    Anywhere (v6)
5353/udp (Bonjour (v6))    ALLOW IN    Anywhere (v6)
5298 (Bonjour (v6))        ALLOW IN    Anywhere (v6)
22 (v6)                    LIMIT IN    Anywhere (v6)
22000 (syncthing (v6))     ALLOW IN    Anywhere (v6)
21027/udp (syncthing (v6)) ALLOW IN    Anywhere (v6)
EOF
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

diff_packages() {
    # Pulls all explicitly installed packages and checks if they're in our packages.txt list
    echo "Running diff on package list..."
    local hostname
    hostname=$(hostnamectl hostname)
    local packages_dir=$HOME/.config/yolk/eggs/extras/packages
    local base_packages_file="$packages_dir/base-packages.txt"
    local hostname_packages_file="$packages_dir/$hostname-packages.txt"

    tmp_package_list=$(mktemp)
    pacman -Qeq > "$tmp_package_list"
    declare -a in_hostname
    declare -a in_base
    declare -a in_neither

    declare -a packages
    while IFS= read -r package; do
        packages+=("$package")
    done < "$tmp_package_list"

    # sort by overlapping packages based on our package files
    for package in "${packages[@]}"; do
        if grep -qxF "$package" "$hostname_packages_file"; then
            # echo "$package in host file"
            in_hostname+=("$package")
        elif grep -qxF "$package" "$base_packages_file"; then
            # echo "$package in base file"
            in_base+=("$package")
        else
            # echo "$package missing"
            in_neither+=("$package")
        fi
    done

    # echo "Installed packages in $hostname-packages.txt file:"
    # echo "${in_hostname[@]}"
    # echo
    #
    # echo "Installed packages in host-packages.txt file:"
    # echo "${in_base[@]}"
    # echo


    printf "\nInstalled not in either:\n%s\n\n" "$(printf "%s " "${in_neither[@]}")"
    # echo
    # echo "Installed packages not in either packages.txt file:"
    # echo "${in_neither[@]}"
    # echo

    echo "Check if you want to add any of these packages to a packages.txt file in $packages_dir"
}
