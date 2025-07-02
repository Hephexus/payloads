#!/bin/bash
# firewall_rules.sh - Display the current iptables firewall rules.
echo "=== Firewall Rules (iptables) ==="
sudo iptables -L -n -v
