#!/bin/bash
# compress_files.sh - Compress specified files or directories using tar.
if [ -z "$1" ]; then
  echo "Usage: $0 <file_or_directory>"
  exit 1
fi
OUTPUT="/tmp/$(basename "$1")_$(date +'%Y%m%d').tar.gz"
echo "Compressing $1 into $OUTPUT..."
tar -czf "$OUTPUT" "$1"
echo "Compression complete: $OUTPUT"
