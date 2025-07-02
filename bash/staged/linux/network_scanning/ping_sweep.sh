#!/bin/bash
# ping_sweep.sh - Perform a ping sweep across a given subnet.
if [ -z "$1" ]; then
    echo "Usage: $0 <subnet (e.g., 192.168.1.0/24)>"
    exit 1
fi
echo "Performing ping sweep on $1..."
fping -a -q -g "$1" 2>/dev/null
