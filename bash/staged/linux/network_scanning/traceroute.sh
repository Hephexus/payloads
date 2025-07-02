#!/bin/bash
# traceroute.sh - Perform a traceroute to a specified target.
if [ -z "$1" ]; then
    echo "Usage: $0 <target_host>"
    exit 1
fi
echo "Performing traceroute to $1..."
traceroute "$1"
