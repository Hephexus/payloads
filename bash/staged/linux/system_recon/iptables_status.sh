#!/bin/bash
# iptables_status.sh - Show iptables rules and statistics.
echo "=== Iptables Status ==="
sudo iptables -L -v -n
echo "======================="
