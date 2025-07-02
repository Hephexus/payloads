#!/bin/bash
# cronjob_monitor.sh - Display the current user's cron jobs.
echo "=== Current User Cron Jobs ==="
crontab -l 2>/dev/null || echo "No cron jobs found."
echo "==============================="
