#!/bin/bash
# port_forwarding.sh - Set up port forwarding using socat.
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <local_port> <remote_host> <remote_port>"
    exit 1
fi
echo "Setting up port forwarding: localhost:$1 -> $2:$3..."
socat TCP-LISTEN:$1,fork TCP:$2:$3
