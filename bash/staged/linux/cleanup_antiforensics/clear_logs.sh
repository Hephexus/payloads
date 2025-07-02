#!/bin/bash
# clear_logs.sh - Clear common system log files.
echo "Clearing system logs..."
sudo sh -c 'cat /dev/null > /var/log/syslog'
sudo sh -c 'cat /dev/null > /var/log/messages'
echo "Logs cleared."
