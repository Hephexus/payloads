#!/bin/bash
# file_metadata.sh - Display file metadata using stat.
if [ -z "$1" ]; then
  echo "Usage: $0 <filename>"
  exit 1
fi
echo "Fetching metadata for $1..."
stat "$1"
