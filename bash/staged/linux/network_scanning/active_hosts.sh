#!/bin/bash
# active_hosts.sh - Perform a ping sweep to identify active hosts on a subnet.
if [ -z "$1" ]; then
    echo "Usage: $0 <subnet (e.g., 192.168.1.0/24)>"
    exit 1
fi
echo "Scanning for active hosts in $1..."
nmap -sn "$1"
