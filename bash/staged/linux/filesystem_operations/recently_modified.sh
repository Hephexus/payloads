#!/bin/bash
# recently_modified.sh - Find files modified in the last 24 hours.
echo "=== Files Modified in the Last 24 Hours ==="
find / -type f -mtime -1 2>/dev/null
echo "==========================================="
