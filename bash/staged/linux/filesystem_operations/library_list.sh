#!/bin/bash
# library_list.sh - List shared libraries (typically .so files) in common system directories.
echo "=== Shared Libraries in /lib and /usr/lib ==="
find /lib /usr/lib -type f \( -iname "*.so" -o -iname "*.so.*" \) 2>/dev/null
echo "============================================="
