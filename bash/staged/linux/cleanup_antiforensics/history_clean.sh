#!/bin/bash
# history_clean.sh - Clear Bash command history.
echo "Clearing Bash history..."
cat /dev/null > ~/.bash_history
history -c
echo "History cleared."
