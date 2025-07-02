#!/bin/bash
# access_control_check.sh - Check for files with ACLs in a specified directory.
DIR=${1:-/}
echo "=== Checking for ACLs in $DIR ==="
find "$DIR" -type f -exec getfacl {} \; 2>/dev/null | grep -i "user:"
echo "================================="
