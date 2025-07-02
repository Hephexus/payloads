#!/bin/bash
# cronjobs_list.sh - List the current user's and system cronjobs.
echo "=== User Cronjobs ==="
crontab -l 2>/dev/null
echo "=== System Cronjobs ==="
ls -la /etc/cron* 2>/dev/null
