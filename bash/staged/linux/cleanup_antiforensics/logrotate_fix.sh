#!/bin/bash
# logrotate_fix.sh - Reset logrotate to prevent old logs from accumulating.
echo "Resetting logrotate state..."
sudo logrotate -f /etc/logrotate.conf
echo "Logrotate state reset."
