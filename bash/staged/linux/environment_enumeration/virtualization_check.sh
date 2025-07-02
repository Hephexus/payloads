#!/bin/bash
# virtualization_check.sh - Check for virtualization using systemd-detect-virt.
echo "=== Virtualization Detection ==="
if command -v systemd-detect-virt >/dev/null 2>&1; then
    systemd-detect-virt
else
    echo "systemd-detect-virt not available."
fi
echo "================================"
