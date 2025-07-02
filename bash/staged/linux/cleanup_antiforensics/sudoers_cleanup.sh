#!/bin/bash
# sudoers_cleanup.sh - Remove suspicious entries from sudoers files (simulation).
echo "Scanning sudoers files for suspicious entries..."
grep -i "backdoor" /etc/sudoers /etc/sudoers.d/* 2>/dev/null && echo "Suspicious entries found. Please review manually."
echo "Sudoers cleanup simulation complete."
