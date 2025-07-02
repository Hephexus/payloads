#!/bin/bash
# cpu_affinity.sh - Set CPU affinity for a process using taskset.
if [ -z "$1" ] || [ -z "$2" ]; then
  echo "Usage: $0 <PID> <mask (hex)>"
  exit 1
fi
echo "Setting CPU affinity for PID $1 with mask $2..."
sudo taskset -pc "$2" "$1"
