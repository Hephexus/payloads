#!/bin/bash
# system_messages.sh - Display recent system messages from syslog.
echo "=== Recent System Messages ==="
if [ -f /var/log/syslog ]; then
    tail -n 50 /var/log/syslog
elif [ -f /var/log/messages ]; then
    tail -n 50 /var/log/messages
else
    echo "No standard syslog file found."
fi
echo "=============================="
