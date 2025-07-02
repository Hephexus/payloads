#!/bin/bash
# network_transfer.sh - Transfer a file to a remote host over netcat.
if [ "$#" -ne 3 ]; then
  echo "Usage: $0 <file> <remote_host> <remote_port>"
  exit 1
fi
FILE="$1"
REMOTE_HOST="$2"
REMOTE_PORT="$3"
echo "Sending $FILE to $REMOTE_HOST:$REMOTE_PORT via netcat..."
nc "$REMOTE_HOST" "$REMOTE_PORT" < "$FILE"
echo "Transfer complete."
