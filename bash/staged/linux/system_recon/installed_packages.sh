#!/bin/bash
# installed_packages.sh - List installed packages on the system.
echo "=== Installed Packages ==="
if [ -f /etc/debian_version ]; then
    dpkg -l
else
    rpm -qa
fi
echo "=========================="
