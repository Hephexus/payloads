#!/bin/bash
# admin_check.sh - Check for users with UID 0 (root) in /etc/passwd.
echo "=== Admin (UID 0) Users ==="
awk -F: '$3 == 0 {print $1}' /etc/passwd
echo "==========================="
