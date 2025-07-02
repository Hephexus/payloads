#!/bin/bash
# dotfiles_check.sh - List dotfiles in the current user's home directory.
echo "=== Dotfiles in $HOME ==="
ls -la $HOME/.[^.]* 2>/dev/null
echo "========================="
