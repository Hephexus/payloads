#!/bin/bash
# curl_transfer.sh - Download a file from a given URL using curl.
if [ -z "$1" ]; then
  echo "Usage: $0 <url>"
  exit 1
fi
URL="$1"
echo "Downloading file from $URL using curl..."
curl -O "$URL"
echo "Download complete."
