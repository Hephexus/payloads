#!/bin/bash
# nc_listen.sh - Start a netcat listener to accept reverse shell connections.
if [ -z "$1" ]; then
  echo "Usage: $0 <port>"
  exit 1
fi
echo "Starting netcat listener on port $1..."
nc -lvnp "$1"
