#!/bin/bash
# password_dump.sh - (Simulation) Dump password-related information.
echo "=== Password Dump Simulation ==="
sudo grep -Ei 'password|passwd' /etc/{shadow,passwd} 2>/dev/null || echo "Access Denied or file not present."
echo "================================="
