#!/bin/bash
# printer_info.sh - Display available printer information.
echo "=== Printer Information ==="
if command -v lpstat >/dev/null 2>&1; then
    lpstat -p
else
    echo "lpstat not installed."
fi
echo "==========================="
