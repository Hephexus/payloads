#!/bin/bash
# protocol_scan.sh - Scan for running services and protocols on a target host.
if [ -z "$1" ]; then
    echo "Usage: $0 <target_host>"
    exit 1
fi
echo "Scanning for supported services and protocols on $1..."
nmap -sV "$1"
