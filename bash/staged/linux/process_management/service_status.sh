#!/bin/bash
# service_status.sh - Display the status of a specified service.
if [ -z "$1" ]; then
  echo "Usage: $0 <service_name>"
  exit 1
fi
echo "=== Status for Service: $1 ==="
if command -v systemctl >/dev/null 2>&1; then
  sudo systemctl status "$1"
else
  sudo service "$1" status
fi
