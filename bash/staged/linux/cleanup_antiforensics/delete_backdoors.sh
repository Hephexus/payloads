#!/bin/bash
# delete_backdoors.sh - Remove known backdoor scripts or files.
echo "Searching and deleting known backdoor files..."
find / -type f -name "*backdoor*" 2>/dev/null -exec rm -f {} \;
echo "Backdoor files removed."
