#!/bin/bash
# orphan_files.sh - Find files that have no valid owner.
echo "=== Orphan Files (No Valid Owner) ==="
find / -nouser 2>/dev/null
echo "====================================="
