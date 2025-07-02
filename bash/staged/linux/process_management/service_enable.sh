#!/bin/bash
# service_enable.sh - Enable a service to start at boot.
if [ -z "$1" ]; then
  echo "Usage: $0 <service_name>"
  exit 1
fi
echo "Enabling service $1..."
if command -v systemctl >/dev/null 2>&1; then
  sudo systemctl enable "$1"
else
  echo "systemctl not available; please enable the service manually."
fi
