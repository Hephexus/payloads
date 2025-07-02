#!/bin/bash
# list_hidden_files.sh - List hidden files in the current user's home directory.
echo "=== Hidden Files in $HOME ==="
ls -la $HOME/.[^.]* 2>/dev/null
echo "============================="
