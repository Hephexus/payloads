#!/bin/bash
# shell_history.sh - Display the shell history of the current user.
echo "=== Shell History for $USER ==="
if [ -f "$HOME/.bash_history" ]; then
    cat "$HOME/.bash_history"
else
    echo "No bash history found."
fi
echo "================================="
