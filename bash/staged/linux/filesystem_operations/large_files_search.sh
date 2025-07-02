#!/bin/bash
# large_files_search.sh - Find files larger than a specified size.
SIZE=${1:-100M}  # Default threshold: 100MB
echo "=== Searching for Files Larger Than $SIZE ==="
find / -type f -size +$SIZE 2>/dev/null
echo "==============================================="
