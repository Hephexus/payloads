#!/bin/bash
# zombie_finder.sh - Identify zombie processes.
echo "=== Zombie Processes ==="
ps aux | awk '$8=="Z" {print $0}'
echo "========================"
