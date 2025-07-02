#!/bin/bash
# escalation_audit.sh - Audit the system for potential privilege escalation vectors.
echo "=== Privilege Escalation Audit ==="
echo "Scanning for files with SUID/SGID bits set..."
find / -type f -perm /6000 2>/dev/null
echo "=================================="
