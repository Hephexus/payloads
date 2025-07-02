#!/bin/bash
# daemon_stop.sh - Stop a daemon/service.
if [ -z "$1" ]; then
  echo "Usage: $0 <service_name>"
  exit 1
fi
echo "Stopping daemon/service: $1"
if command -v systemctl >/dev/null 2>&1; then
  sudo systemctl stop "$1"
else
  sudo service "$1" stop
fi
