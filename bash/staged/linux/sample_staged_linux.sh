#!/bin/bash
# Sample staged payload for Linux.
# This script decodes a base64‐encoded command passed as the first argument,
# and executes it in the background using nohup.

if [ -z "$1" ]; then
  echo "Usage: $0 <base64_encoded_command>"
  exit 1
fi

PAYLOAD="$1"
COMMAND=$(echo "$PAYLOAD" | base64 --decode)
echo "[*] Executing command in background: $COMMAND"
nohup bash -c "$COMMAND" > /dev/null 2>&1 &