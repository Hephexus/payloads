#!/bin/bash
# uid0_check.sh - Check for users with UID 0 in /etc/passwd.
echo "=== Users with UID 0 ==="
awk -F: '$3 == 0 {print $1}' /etc/passwd
echo "========================"
