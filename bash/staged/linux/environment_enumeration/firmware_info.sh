#!/bin/bash
# firmware_info.sh - Display firmware or BIOS information if available.
echo "=== Firmware/BIOS Information ==="
dmesg | grep -i firmware | head -n 20 2>/dev/null || echo "No firmware info found."
echo "================================="
