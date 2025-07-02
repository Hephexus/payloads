#!/bin/bash
# timestamp_sync.sh - Display system time and NTP synchronization status.
echo "=== System Time and NTP Status ==="
date
if command -v ntpq >/dev/null 2>&1; then
    ntpq -p
else
    echo "ntpq not installed."
fi
echo "=================================="
