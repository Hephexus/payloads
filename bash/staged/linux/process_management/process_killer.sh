#!/bin/bash
# process_killer.sh - Kill a process by name (requires process name as argument).
if [ -z "$1" ]; then
  echo "Usage: $0 <process_name>"
  exit 1
fi
echo "Searching for processes matching '$1'..."
PIDS=$(pgrep -f "$1")
if [ -z "$PIDS" ]; then
  echo "No processes found for $1."
else
  echo "Killing processes: $PIDS"
  kill $PIDS
fi
