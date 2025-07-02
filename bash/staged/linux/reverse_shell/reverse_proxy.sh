#!/bin/bash
# reverse_proxy.sh - Establish a reverse SSH tunnel acting as a proxy.
if [ -z "$1" ] || [ -z "$2" ]; then
  echo "Usage: $0 <remote_host> <remote_port>"
  exit 1
fi
echo "Establishing reverse SSH tunnel: remote host $1, remote port $2..."
ssh -f -N -R $2:localhost:22 $1
