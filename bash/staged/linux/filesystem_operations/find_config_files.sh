#!/bin/bash
# find_config_files.sh - Locate common configuration files (.conf, .cfg).
echo "=== Configuration Files ==="
find / -type f \( -iname "*.conf" -o -iname "*.cfg" \) 2>/dev/null
echo "==========================="
