#!/bin/bash
# firmware_dump.sh - List potential firmware or BIOS-related files/directories.
echo "=== Potential Firmware/Bios Locations ==="
find / -type d \( -iname "*firmware*" -o -iname "*bios*" \) 2>/dev/null
echo "========================================="
