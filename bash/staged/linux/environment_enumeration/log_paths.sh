#!/bin/bash
# log_paths.sh - List common log file locations.
echo "=== Common Log Files ==="
find /var/log -type f 2>/dev/null
echo "========================"
