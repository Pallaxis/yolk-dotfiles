#!/usr/bin/env bash
# Must not be running as root
if [ "$EUID" -eq 0 ]; then
  abort "Running as root (not user)"
fi
