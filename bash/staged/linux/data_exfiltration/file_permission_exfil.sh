#!/bin/bash
# file_permission_exfil.sh - Find files with insecure permissions and list them.
echo "=== Files with World-Writable Permissions ==="
find / -type f -perm -o+w 2>/dev/null
