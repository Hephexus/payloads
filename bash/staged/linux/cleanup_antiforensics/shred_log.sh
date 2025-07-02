#!/bin/bash
# shred_log.sh - Shred a specified log file.
if [ -z "$1" ]; then
  echo "Usage: $0 <log_file>"
  exit 1
fi
echo "Shredding log file $1..."
sudo shred -uz "$1"
echo "Log file shredded."
