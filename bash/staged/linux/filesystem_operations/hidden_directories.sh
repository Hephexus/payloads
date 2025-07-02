#!/bin/bash
# hidden_directories.sh - List hidden directories (those starting with a dot) in a given path.
DIR=${1:-/}
echo "=== Hidden Directories in $DIR ==="
find "$DIR" -type d -name ".*" 2>/dev/null
echo "=================================="
