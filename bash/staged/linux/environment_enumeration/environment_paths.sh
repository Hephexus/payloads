#!/bin/bash
# environment_paths.sh - Display the system PATH and help locate executables.
echo "=== System PATH ==="
echo "$PATH"
echo "=== Executable Lookup for common commands ==="
which bash python3 perl ruby 2>/dev/null
echo "============================================="
