#!/bin/bash
# directory_size.sh - Display the size of a specified directory.
DIR=${1:-/}
echo "=== Size of Directory $DIR ==="
du -sh "$DIR" 2>/dev/null
echo "=============================="
