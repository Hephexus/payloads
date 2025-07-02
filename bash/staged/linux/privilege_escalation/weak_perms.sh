#!/bin/bash
# weak_perms.sh - Find files and directories with weak (world-writable) permissions.
echo "=== Searching for Weak Permissions ==="
find / -type f -perm -o+w 2>/dev/null
echo "======================================"
