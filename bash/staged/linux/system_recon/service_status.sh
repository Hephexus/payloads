#!/bin/bash
# service_status.sh - Display status of critical services.
echo "=== Service Status ==="
systemctl status sshd
systemctl status apache2
echo "======================"
