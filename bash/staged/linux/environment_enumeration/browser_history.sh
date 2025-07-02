#!/bin/bash
# browser_history.sh - Attempt to display the browser history (for Firefox).
HISTORY_FILE="$HOME/.mozilla/firefox/*/places.sqlite"
if ls $HISTORY_FILE 1> /dev/null 2>&1; then
    echo "Browser history SQLite file(s) found during Firefox usage."
else
    echo "No Firefox history files found."
fi
