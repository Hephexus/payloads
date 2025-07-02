#!/bin/bash
# su_cmd_usage.sh - Check for usage of 'su' commands in authentication logs.
echo "=== Looking for 'su' Command Usage in /var/log/auth.log ==="
sudo grep -i 'su ' /var/log/auth.log 2>/dev/null
echo "=========================================================="
