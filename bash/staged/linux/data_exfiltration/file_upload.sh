#!/bin/bash
# file_upload.sh - Upload a file via HTTP POST using curl.
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <file> <upload_url>"
  exit 1
fi
FILE="$1"
UPLOAD_URL="$2"
echo "Uploading $FILE to $UPLOAD_URL via HTTP POST..."
curl -F "file=@$FILE" "$UPLOAD_URL"
echo "File upload complete."
