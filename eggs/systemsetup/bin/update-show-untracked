#!/usr/bin/env bash
# Pulls all explicitly installed packages and checks if they're in our packages.txt list
echo -e "\e[32mRunning diff on package list...\e[0m"

setup_path="$HOME/.local/share/system-setup"
setup_install="$setup_path/install"
base_packages_file="$setup_install/01-base-packages.txt"
aur_packages_file="$setup_install/01-aur-packages.txt"
hostname_packages_file="$setup_install/01-$HOSTNAME-packages.txt"

# Mapfiles to arrays
mapfile -t base_array < "$base_packages_file"
mapfile -t aur_array < "$aur_packages_file"
mapfile -t hostname_array < "$hostname_packages_file"

combined_array=("${base_array[@]}" "${aur_array[@]}" "${hostname_array[@]}")

# Remove duplicates and sort alphabetically
mapfile -t all_packages_array < <(printf "%s\n" "${combined_array[@]}" | sort -u)
mapfile -t installed_packages_array < <(pacman -Qeq)


# Shows installed packages not in the package lists
for item in "${installed_packages_array[@]}"; do
    if [[ ! " ${all_packages_array[*]} " =~ " ${item} " ]]; then
        not_in_any_list+=("$item")
    fi
done

echo -e "\n\e[32mPackages not in any of the lists:\e[0m"
echo "${not_in_any_list[@]}"
