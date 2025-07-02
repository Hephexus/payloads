#!/bin/bash
# wireless_info.sh - Display information about wireless interfaces.
echo "=== Wireless Information ==="
iwconfig 2>/dev/null || echo "No wireless interfaces found."
