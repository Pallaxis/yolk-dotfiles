#!/usr/bin/env bash

echo "Backing up Home dir"
restic backup --exclude-file ~/.config/restic/ignore ~/

echo "Pruning repository to keep last 10 snapshots..."
restic forget --keep-last 10
