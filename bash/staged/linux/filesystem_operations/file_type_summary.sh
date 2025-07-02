#!/bin/bash
# file_type_summary.sh - Provide a summary of file types in a directory.
DIR=${1:-/}
echo "=== File Type Summary in $DIR ==="
find "$DIR" -type f 2>/dev/null | xargs file | cut -d: -f2 | sort | uniq -c | sort -nr
echo "==================================="
