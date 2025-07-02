#!/bin/bash
# network_map.sh - Create a simple network map using nmap, optionally launching zenmap.
if [ -z "$1" ]; then
    echo "Usage: $0 <target_subnet>"
    exit 1
fi
echo "Mapping network on subnet $1..."
nmap -sn "$1"
if command -v zenmap >/dev/null 2>&1; then
    echo "Launching Zenmap for visualization..."
    zenmap "$1"
fi
