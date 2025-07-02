#!/bin/bash
# nopasswd_sudo.sh - Check for passwordless sudo entries.
echo "=== NOPASSWD Sudo Entries ==="
sudo grep -i nopasswd /etc/sudoers /etc/sudoers.d/* 2>/dev/null
echo "================================"
