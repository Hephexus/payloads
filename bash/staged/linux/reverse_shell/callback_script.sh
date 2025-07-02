#!/bin/bash
# callback_script.sh - Send a callback to a C2 server via HTTP.
if [ -z "$1" ]; then
  echo "Usage: $0 <C2_server_URL>"
  exit 1
fi
echo "Sending callback to $1..."
curl -s "$1" > /dev/null
echo "Callback sent."
