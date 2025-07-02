#!/bin/bash
# user_history.sh - Display the bash history of the current user.
echo "=== Bash History for $USER ==="
cat $HOME/.bash_history 2>/dev/null
echo "==============================="
