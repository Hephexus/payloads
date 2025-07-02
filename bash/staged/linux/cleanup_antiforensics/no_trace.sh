#!/bin/bash
# no_trace.sh - Remove common traces from shell history and logs.
echo "Removing traces..."
rm -f ~/.bash_history
sudo truncate -s 0 /var/log/auth.log
echo "Traces removed."
