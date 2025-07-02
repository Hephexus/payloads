#!/bin/bash
# os_release.sh - Display operating system release information.
echo "=== OS Release Information ==="
if [ -f /etc/os-release ]; then
    cat /etc/os-release
else
    uname -a
fi
echo "==============================="
