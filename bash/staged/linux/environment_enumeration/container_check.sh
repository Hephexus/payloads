#!/bin/bash
# container_check.sh - Check if the system is running inside a container.
echo "=== Containerization Check ==="
if [ -f /proc/1/cgroup ] && grep -q "docker" /proc/1/cgroup; then
    echo "System appears to run inside a Docker container."
else
    echo "No containerization detected or not Docker."
fi
echo "==============================="
