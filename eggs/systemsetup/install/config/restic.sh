#!/usr/bin/env bash
echo "Setting up Restic..."
restic_env="$HOME/.config/restic/.env"

if [[ ! -f "$restic_env" ]]; then
    printf "Restic .env file not found in in config location: [%s]" "$restic_env"
fi

systemctl --user enable --now restic-backup.timer
