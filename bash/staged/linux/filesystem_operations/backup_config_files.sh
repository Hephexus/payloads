#!/bin/bash
# backup_config_files.sh - Backup configuration files from /etc to a specified destination.
DEST=${1:-/tmp/etc_backup}
echo "=== Backing up /etc to $DEST ==="
mkdir -p "$DEST"
cp -r /etc "$DEST" 2>/dev/null
echo "Backup complete."
