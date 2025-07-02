#!/bin/bash
# socket_test.sh - Test connectivity to a specific port on a target host using netcat.
if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: $0 <target_host> <port>"
    exit 1
fi
echo "Testing connectivity to $1 on port $2..."
nc -zv "$1" "$2"
