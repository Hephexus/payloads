#!/bin/bash
# log_files_search.sh - Search for log files in a given directory and display their last few lines.
LOG_DIR=${1:-/var/log}
echo "=== Last 5 Lines of Log Files in $LOG_DIR ==="
for file in $(find "$LOG_DIR" -type f 2>/dev/null); do
  echo "----- $file -----"
  tail -n 5 "$file" 2>/dev/null
done
echo "============================================"
