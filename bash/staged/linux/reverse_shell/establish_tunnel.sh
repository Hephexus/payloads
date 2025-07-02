#!/bin/bash
# establish_tunnel.sh - Establish an SSH tunnel for forwarding a port.
if [ -z "$1" ] || [ -z "$2" ]; then
  echo "Usage: $0 <remote_host> <remote_port>"
  exit 1
fi
echo "Establishing SSH reverse tunnel: remote $1 port $2 to local port 4444..."
ssh -f -N -R $2:localhost:4444 $1
