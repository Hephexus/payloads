#!/bin/bash
# installed_software.sh - List installed software packages.
echo "=== Installed Software Packages ==="
if [ -f /etc/debian_version ]; then
    dpkg -l
elif [ -f /etc/redhat-release ]; then
    rpm -qa
else
    echo "Package manager not identified."
fi
echo "==================================="
