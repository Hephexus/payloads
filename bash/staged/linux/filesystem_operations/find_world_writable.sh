#!/bin/bash
# find_world_writable.sh - Find files and directories that are world-writable.
DIR=${1:-/}
echo "=== World-Writable Files in $DIR ==="
find "$DIR" -type f -perm -o+w 2>/dev/null
echo "=== World-Writable Directories in $DIR ==="
find "$DIR" -type d -perm -o+w 2>/dev/null
echo "==========================================="
