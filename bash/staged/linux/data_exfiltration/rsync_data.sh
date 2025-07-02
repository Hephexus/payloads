#!/bin/bash
# rsync_data.sh - Perform an rsync backup of a specified directory.
if [ -z "$1" ]; then
  echo "Usage: $0 <directory>"
  exit 1
fi
SRC="$1"
BACKUP="/tmp/rsync_backup_$(basename "$SRC")_$(date +'%Y%m%d').tar.gz"
echo "Creating backup archive of $SRC..."
tar -czf "$BACKUP" "$SRC"
echo "Backup created at $BACKUP"
