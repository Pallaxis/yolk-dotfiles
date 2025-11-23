#!/usr/bin/env bash
# Keyd, fix to recognise the virtual keyboard as a real keyboard
# this fixes the auto touchpad disable
echo "Copying libinput overrides over..."
sudo tee /etc/libinput/local-overrides.quirks > /dev/null <<EOF
[Serial Keyboards]
MatchUdevType=keyboard
MatchName=keyd virtual keyboard
AttrKeyboardIntegration=internal
EOF
