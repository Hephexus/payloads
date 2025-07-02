#!/bin/bash
# sysctl_params.sh - List all sysctl parameters.
echo "=== Sysctl Parameters ==="
sysctl -a | less
