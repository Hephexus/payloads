#!/bin/bash
# copy_sensitive.sh - Copy sensitive configuration files to a temporary folder.
DEST="/tmp/sensitive_configs_$(date +'%Y%m%d')"
echo "Copying sensitive files (/etc/passwd, /etc/shadow) into $DEST..."
mkdir -p "$DEST"
cp /etc/passwd "$DEST" 2>/dev/null
sudo cp /etc/shadow "$DEST" 2>/dev/null
echo "Files copied to $DEST."
