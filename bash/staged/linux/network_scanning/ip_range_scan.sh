#!/bin/bash
# ip_range_scan.sh - Scan a range of IP addresses for active hosts.
if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: $0 <start_ip> <end_ip>"
    exit 1
fi
echo "Scanning IP range from $1 to $2..."
nmap -sn "$1-$2"
