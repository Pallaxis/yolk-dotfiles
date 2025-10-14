#!/usr/bin/env bash
# Simple script to update Arch/AUR packages, asks for flatpak updates at the end
source "$HOME/.local/bin/sync.sh"

main() {
	fastfetch
	sync_packages
	diff_packages
	# yay --answerdiff=All --answerclean=None --noconfirm
	# echo
	# read -p "Update Flatpak packages? [Y/n]"$'\n> ' yn
	# case $yn in
	# 	[yY] )
	# 		printf "\nUpdating Flatpaks...\n\n"
	# 		flatpak update -y;;
	# 	[nN] )
	# 		printf "\nSkipping Flatpaks.\n\n"
	# 		read -p "Press enter to exit" 
	# 		exit;;
	# 	* ) 
	# 		printf "\nUpdating Flatpaks...\n\n"
	# 		flatpak update -y;;
	# esac
	# echo
	read -p "Press enter to exit" 
	exit
}

main
