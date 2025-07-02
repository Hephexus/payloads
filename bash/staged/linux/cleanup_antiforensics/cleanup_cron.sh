#!/bin/bash
# cleanup_cron.sh - Remove suspicious cronjobs from the current user's crontab.
echo "Cleaning up cron jobs..."
crontab -l | grep -v "backdoor" | crontab -
echo "Cron cleanup complete."
