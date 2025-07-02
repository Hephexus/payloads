#!/bin/bash
# wget_transfer.sh - Download a file from a remote HTTP server using wget.
if [ -z "$1" ]; then
  echo "Usage: $0 <url>"
  exit 1
fi
URL="$1"
echo "Downloading file from $URL using wget..."
wget "$URL"
echo "Download complete."
