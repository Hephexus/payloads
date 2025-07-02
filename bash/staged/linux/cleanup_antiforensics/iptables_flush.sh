#!/bin/bash
# iptables_flush.sh - Flush all iptables rules.
echo "Flushing iptables rules..."
sudo iptables -F
echo "iptables rules flushed."
