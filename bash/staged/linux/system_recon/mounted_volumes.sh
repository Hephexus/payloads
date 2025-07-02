#!/bin/bash
# mounted_volumes.sh - List all mounted filesystems.
echo "=== Mounted Volumes ==="
mount | column -t
echo "======================="
