#!/bin/bash
# process_archiver.sh - Archive the current process list to a file.
ARCHIVE_FILE="/tmp/process_list_$(date +'%Y%m%d_%H%M%S').txt"
echo "Archiving process list into $ARCHIVE_FILE..."
ps aux > "$ARCHIVE_FILE"
echo "Archive complete."
