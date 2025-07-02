#!/bin/bash
# daemon_start.sh - Start a daemon/service.
if [ -z "$1" ]; then
  echo "Usage: $0 <service_name>"
  exit 1
fi
echo "Starting daemon/service: $1"
if command -v systemctl >/dev/null 2>&1; then
  sudo systemctl start "$1"
else
  sudo service "$1" start
fi
