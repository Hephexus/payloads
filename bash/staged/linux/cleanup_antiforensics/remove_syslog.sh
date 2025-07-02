#!/bin/bash
# remove_syslog.sh - Remove the contents of system log files for anti-forensics.
echo "Erasing system log contents..."
sudo truncate -s 0 /var/log/syslog
sudo truncate -s 0 /var/log/messages
echo "System logs erased."
