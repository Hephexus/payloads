#!/bin/bash
# find_flags.sh - Search for files with 'flag' in their name.
echo "=== Searching for Flag Files ==="
find / -type f -iname "*flag*" 2>/dev/null
echo "================================"
