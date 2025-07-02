#!/bin/bash
# file_owner.sh - Display the owner of a specified file.
if [ -z "$1" ]; then
  echo "Usage: $0 <filename>"
  exit 1
fi
echo "=== Owner of $1 ==="
ls -l "$1" | awk '{print $3}'
echo "==================="
