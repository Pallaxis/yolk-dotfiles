#!/usr/bin/env bash
echo "Setting up UFW..."
sudo tee /etc/ufw/applications.d/ufw-localsend > /dev/null <<EOF
[Localsend]
title=Localsend
description=AirDrop-like file sharing
ports=53317/tcp|53317/udp
EOF

sudo ufw default deny > /dev/null
sudo ufw limit ssh > /dev/null
sudo ufw allow qBittorrent > /dev/null
sudo ufw allow bonjour > /dev/null
sudo ufw allow syncthing > /dev/null
sudo ufw allow Localsend

sudo systemctl enable --now ufw.service
