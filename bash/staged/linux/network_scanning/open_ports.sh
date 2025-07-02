#!/bin/bash
# open_ports.sh - Scan for open ports on a target host using nmap.
if [ -z "$1" ]; then
    echo "Usage: $0 <target_host>"
    exit 1
fi
echo "Scanning for open ports on $1 (ports 1-1024)..."
nmap -p 1-1024 "$1"
