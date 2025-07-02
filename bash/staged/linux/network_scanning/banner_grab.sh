#!/bin/bash
# banner_grab.sh - Grab the banner of a service on a given port using netcat.
if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: $0 <target_host> <port>"
    exit 1
fi
echo "Grabbing banner from $1 on port $2..."
nc -nv "$1" "$2" < /dev/null
