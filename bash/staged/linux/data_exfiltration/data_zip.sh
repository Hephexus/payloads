#!/bin/bash
# data_zip.sh - Zip a directory or file.
if [ -z "$1" ]; then
  echo "Usage: $0 <file_or_directory>"
  exit 1
fi
zip -r "${1}_$(date +'%Y%m%d').zip" "$1"
echo "ZIP archive created."
