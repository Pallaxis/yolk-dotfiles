#!/usr/bin/env bash
echo "Setting up & restarting SSH"
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

# services
sudo systemctl try-restart sshd.service
systemctl --user enable --now ssh-agent.service 
