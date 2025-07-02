#!/bin/bash
# sniff_traffic.sh - Capture network traffic using tcpdump on a specified interface.
if [ -z "$1" ]; then
    echo "Usage: $0 <interface>"
    exit 1
fi
echo "Capturing traffic on interface $1 for 30 seconds..."
sudo timeout 30 tcpdump -i "$1" -nn
