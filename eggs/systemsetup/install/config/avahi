#!/usr/bin/env bash

if [[ ! -d /etc/systemd/system/avahi-daemon.service.d ]]; then
    mkdir /etc/systemd/system/avahi-daemon.service.d
fi

sudo tee > /dev/null /etc/systemd/system/avahi-daemon.service.d/override.conf <<EOF
[Install]
WantedBy=nss-lookup.target
EOF
