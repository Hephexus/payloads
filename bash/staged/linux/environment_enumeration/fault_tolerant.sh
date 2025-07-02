#!/bin/bash
# fault_tolerant.sh - Display a summary of system fault tolerance settings.
echo "=== Fault Tolerance Summary ==="
echo "Checking for RAID configuration..."
if command -v mdadm >/dev/null 2>&1; then
    sudo mdadm --detail --scan
else
    echo "mdadm not installed."
fi
echo "================================"
