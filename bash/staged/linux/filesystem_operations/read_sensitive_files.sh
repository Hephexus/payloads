#!/bin/bash
# read_sensitive_files.sh - Display key sensitive system files.
echo "=== /etc/passwd ==="
cat /etc/passwd
echo ""
echo "=== /etc/hosts ==="
cat /etc/hosts
echo ""
echo "=== /etc/shadow (if accessible) ==="
sudo cat /etc/shadow 2>/dev/null
echo "====================================="
