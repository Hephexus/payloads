#!/bin/bash
# archive_logs.sh - Archive log files from /var/log and save to /tmp.
OUTPUT="/tmp/var_log_archive_$(date +'%Y%m%d').tar.gz"
echo "Archiving log files from /var/log into $OUTPUT..."
tar -czf "$OUTPUT" /var/log 2>/dev/null
echo "Archive complete."
