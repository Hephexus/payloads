#!/bin/bash
# service_disable.sh - Disable a service from starting at boot.
if [ -z "$1" ]; then
  echo "Usage: $0 <service_name>"
  exit 1
fi
echo "Disabling service $1..."
if command -v systemctl >/dev/null 2>&1; then
  sudo systemctl disable "$1"
else
  echo "systemctl not available; please disable the service manually."
fi
