#!/bin/bash
# process_hijack.sh - Simulate process hijacking by sending a signal.
if [ -z "$1" ]; then
  echo "Usage: $0 <process_name>"
  exit 1
fi
PID=$(pgrep -f "$1" | head -n 1)
if [ -z "$PID" ]; then
  echo "Process not found."
  exit 1
fi
echo "Sending SIGCONT to process $PID (simulated hijack)..."
kill -CONT "$PID"
