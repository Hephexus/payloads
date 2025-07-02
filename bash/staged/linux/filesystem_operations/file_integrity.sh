#!/bin/bash
# file_integrity.sh - Calculate and display the MD5 hash for a specified file.
if [ -z "$1" ]; then
  echo "Usage: $0 <filename>"
  exit 1
fi
echo "=== MD5 Hash for $1 ==="
md5sum "$1"
echo "========================="
