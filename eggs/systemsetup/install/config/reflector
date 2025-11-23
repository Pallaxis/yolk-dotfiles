#!/usr/bin/env bash
echo "Copying reflector config over..."
sudo tee /etc/xdg/reflector/reflector.conf  > /dev/null <<EOF
--save /etc/pacman.d/mirrorlist
--protocol https
--country New\ Zealand,Australia,Singapore,Japan
--latest 5
--sort rate
EOF
