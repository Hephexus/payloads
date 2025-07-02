#!/bin/bash
# suid_files.sh - List all SUID files that could be exploited.
echo "=== SUID Files ==="
find / -type f -perm /4000 2>/dev/null
echo "=================="
