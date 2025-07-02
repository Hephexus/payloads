#!/bin/bash
# file_wiper.sh - Permanently wipe a specified file.
if [ -z "$1" ]; then
  echo "Usage: $0 <file>"
  exit 1
fi
echo "Wiping $1..."
sudo shred -n 3 -z -u "$1"
echo "File wiped."
