#!/bin/bash
# port_scan.sh - Perform a full port scan using nmap on a target host.
if [ -z "$1" ]; then
    echo "Usage: $0 <target_host>"
    exit 1
fi
echo "Scanning all ports on $1..."
nmap -p- "$1"
echo "Port scan complete."
