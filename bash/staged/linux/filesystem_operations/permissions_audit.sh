#!/bin/bash
# permissions_audit.sh - Audit file permissions in a specified directory.
DIR=${1:-/}
echo "=== Auditing File Permissions in $DIR ==="
find $DIR -type f -exec ls -l {} \; 2>/dev/null
echo "=========================================="
