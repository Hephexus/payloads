#!/bin/bash
# interface_config.sh - Display configuration details of all network interfaces.
echo "=== Interface Configuration ==="
ifconfig -a || ip addr show
