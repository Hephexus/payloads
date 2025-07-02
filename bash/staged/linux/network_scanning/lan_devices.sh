#!/bin/bash
# lan_devices.sh - Scan the local network for active devices.
echo "=== Scanning LAN for active devices ==="
nmap -sn 192.168.1.0/24
