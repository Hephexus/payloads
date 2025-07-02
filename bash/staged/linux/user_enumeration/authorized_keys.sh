#!/bin/bash
# authorized_keys.sh - Display the authorized_keys for the current user.
echo "=== Authorized Keys for $USER ==="
cat $HOME/.ssh/authorized_keys 2>/dev/null
echo "=================================="
