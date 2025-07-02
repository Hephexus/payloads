#!/bin/bash
# service_log.sh - Tail the log file of a specified service.
if [ -z "$1" ]; then
  echo "Usage: $0 <service_log_file>"
  exit 1
fi
echo "Tailing the service log at $1..."
tail -f "$1"
