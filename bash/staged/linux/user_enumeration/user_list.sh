#!/bin/bash
# user_list.sh - List all user accounts from /etc/passwd.
echo "=== User Accounts ==="
cut -d: -f1 /etc/passwd
echo "====================="
