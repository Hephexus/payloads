#!/bin/bash
# process_trace.sh - Trace system calls of a process using strace.
if [ -z "$1" ]; then
  echo "Usage: $0 <PID>"
  exit 1
fi
echo "Tracing system calls for PID $1..."
sudo strace -p "$1"
