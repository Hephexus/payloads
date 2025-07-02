#!/bin/bash
# ssh_config_check.sh - Check SSH daemon configuration.
echo "=== SSH Daemon Configuration (/etc/ssh/sshd_config) ==="
sudo cat /etc/ssh/sshd_config | grep -v '^#'
echo "========================================================"
