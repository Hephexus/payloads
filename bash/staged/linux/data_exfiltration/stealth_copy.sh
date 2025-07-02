#!/bin/bash
# stealth_copy.sh - Stealthily copy a file using dd.
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <source_file> <destination>"
  exit 1
fi
SOURCE="$1"
DESTINATION="$2"
echo "Stealthily copying $SOURCE to $DESTINATION using dd..."
dd if="$SOURCE" of="$DESTINATION" bs=4096 status=none
echo "Copy complete."
