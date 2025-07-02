#!/bin/bash
# process_monitor.sh - Monitor processes continuously.
# Usage: process_monitor.sh <interval_seconds>
INTERVAL=${1:-5}
echo "Monitoring running processes every $INTERVAL seconds (press Ctrl+C to exit)..."
while true; do
  clear
  ps aux --sort=-%cpu | head -n 20
  sleep $INTERVAL
done
