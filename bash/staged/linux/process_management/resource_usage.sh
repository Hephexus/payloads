#!/bin/bash
# resource_usage.sh - Show resource usage sorted by CPU and memory.
echo "=== Top CPU and Memory Consuming Processes ==="
ps aux --sort=-%cpu,-%mem | head -n 20
echo "=============================================="
