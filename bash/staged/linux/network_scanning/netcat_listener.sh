#!/bin/bash
# netcat_listener.sh - Start a netcat listener on a specified port.
if [ -z "$1" ]; then
    echo "Usage: $0 <port>"
    exit 1
fi
echo "Starting netcat listener on port $1..."
nc -lvnp "$1"
