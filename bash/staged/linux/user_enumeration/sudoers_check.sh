#!/bin/bash
# sudoers_check.sh - Examine sudoers configuration.
echo "=== sudoers File Contents ==="
sudo grep -v '^#' /etc/sudoers
echo "=== Included Files ==="
sudo grep -R '' /etc/sudoers.d/
