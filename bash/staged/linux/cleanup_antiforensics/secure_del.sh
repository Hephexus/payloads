#!/bin/bash
# secure_del.sh - Securely delete a specified file using shred.
if [ -z "$1" ]; then
  echo "Usage: $0 <file>"
  exit 1
fi
echo "Securely deleting $1..."
sudo shred -u "$1"
echo "File securely deleted."
