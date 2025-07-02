#!/bin/bash
# symbolic_links.sh - List all symbolic links in a specified directory.
DIR=${1:-/}
echo "=== Symbolic Links in $DIR ==="
find "$DIR" -type l 2>/dev/null
echo "============================="
