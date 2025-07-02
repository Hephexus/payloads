#!/bin/bash
# keychain_entries.sh - Attempt to list keychain or stored credentials.
echo "=== Checking for Keychain/Stored Credentials ==="
find $HOME -maxdepth 2 -name "*keychain*" 2>/dev/null
echo "==================================================="
