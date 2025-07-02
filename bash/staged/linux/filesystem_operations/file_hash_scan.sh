#!/bin/bash
# file_hash_scan.sh - Compute MD5 hashes for all files in a specified directory.
DIR=${1:-/}
echo "=== MD5 Hashes for Files in $DIR ==="
find "$DIR" -type f -exec md5sum {} \; 2>/dev/null
echo "==================================="
