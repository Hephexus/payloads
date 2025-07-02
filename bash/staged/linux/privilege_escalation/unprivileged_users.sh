#!/bin/bash
# unprivileged_users.sh - List users with UID greater than or equal to 1000.
echo "=== Unprivileged Users ==="
awk -F: '$3 >= 1000 {print $1}' /etc/passwd
echo "=========================="
