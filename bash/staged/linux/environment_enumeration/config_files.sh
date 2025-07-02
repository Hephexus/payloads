#!/bin/bash
# config_files.sh - List key configuration files in /etc.
echo "=== Configuration Files in /etc ==="
find /etc -maxdepth 1 -type f -iname "*.conf" -o -iname "*.cfg" 2>/dev/null
echo "====================================="
