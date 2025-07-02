#!/bin/bash
# process_priority.sh - Adjust the priority of a process using renice.
if [ -z "$1" ] || [ -z "$2" ]; then
  echo "Usage: $0 <PID> <nice_value>"
  exit 1
fi
echo "Setting nice value of PID $1 to $2..."
sudo renice -n "$2" -p "$1"
