#!/bin/bash
# find_executables.sh - Find executable files in a specified directory.
DIR=${1:-/}
echo "=== Executable Files in $DIR ==="
find "$DIR" -type f -executable 2>/dev/null
echo "================================"
