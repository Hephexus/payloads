#!/bin/bash
# file_timestamps.sh - Display the timestamps for a specified file.
if [ -z "$1" ]; then
  echo "Usage: $0 <filename>"
  exit 1
fi
echo "=== Timestamps for $1 ==="
stat "$1"
echo "=========================="
