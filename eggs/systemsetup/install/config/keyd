#!/usr/bin/env bash
echo "Copying keyd config over..."
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
