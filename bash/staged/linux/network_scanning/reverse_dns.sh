#!/bin/bash
# reverse_dns.sh - Perform a reverse DNS lookup on an IP address.
if [ -z "$1" ]; then
    echo "Usage: $0 <IP address>"
    exit 1
fi
echo "Performing reverse DNS lookup on $1..."
dig -x "$1" +short
