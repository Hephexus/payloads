#!/bin/bash
# network_config.sh - Display network configuration details.
echo "=== Network Configuration ==="
ifconfig -a || ip addr show
echo ""
echo "=== Network Routes ==="
ip route show
echo "========================"
