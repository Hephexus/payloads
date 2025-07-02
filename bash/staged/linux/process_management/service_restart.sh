#!/bin/bash
# service_restart.sh - Restart a specified service.
if [ -z "$1" ]; then
  echo "Usage: $0 <service_name>"
  exit 1
fi
echo "Restarting service: $1"
if command -v systemctl >/dev/null 2>&1; then
  sudo systemctl restart "$1"
else
  sudo service "$1" restart
fi
