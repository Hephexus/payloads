#!/bin/bash
# lib_versions.sh - List versions of common shared libraries using ldconfig.
echo "=== Shared Libraries and Versions ==="
ldconfig -p | sort | uniq -c | sort -nr | head -n 20
echo "====================================="
