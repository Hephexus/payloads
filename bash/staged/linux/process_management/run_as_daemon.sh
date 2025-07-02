#!/bin/bash
# run_as_daemon.sh - Run a given command as a daemon using nohup.
if [ -z "$1" ]; then
  echo "Usage: $0 <command_to_run>"
  exit 1
fi
COMMAND="$*"
echo "Running command as daemon: $COMMAND"
nohup bash -c "$COMMAND" > /dev/null 2>&1 &
echo "Daemon process started."
