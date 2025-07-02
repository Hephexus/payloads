#!/bin/bash
# backup_configs.sh - Backup configuration files (from /etc) to /tmp.
OUTPUT="/tmp/config_backup_$(date +'%Y%m%d').tar.gz"
echo "Backing up /etc/ configuration files into $OUTPUT..."
tar -czf "$OUTPUT" /etc 2>/dev/null
echo "Backup complete."
