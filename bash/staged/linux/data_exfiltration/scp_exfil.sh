#!/bin/bash
# scp_exfil.sh - Securely copy a file to a remote host using SCP.
if [ "$#" -ne 3 ]; then
  echo "Usage: $0 <file> <remote_host> <remote_user>"
  exit 1
fi
FILE="$1"
REMOTE_HOST="$2"
REMOTE_USER="$3"
echo "Uploading $FILE to ${REMOTE_USER}@${REMOTE_HOST}:~/"
scp "$FILE" "${REMOTE_USER}@${REMOTE_HOST}:~/"
echo "SCP transfer complete."
