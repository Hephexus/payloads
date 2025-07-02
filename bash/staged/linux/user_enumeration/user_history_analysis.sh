#!/bin/bash
# user_history_analysis.sh - Analyze bash history files for sensitive commands.
echo "=== Analyzing Bash History Files in /home ==="
grep -Ri 'sudo' /home/*/.bash_history 2>/dev/null
echo "============================================="
