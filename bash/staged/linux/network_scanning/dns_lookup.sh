#!/bin/bash
# dns_lookup.sh - Perform DNS lookup for a given domain.
if [ -z "$1" ]; then
    echo "Usage: $0 <domain>"
    exit 1
fi
echo "Looking up DNS for $1..."
nslookup "$1"
