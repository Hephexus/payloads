#!/bin/bash
# escalation_vector.sh - Demonstrate a combined escalation vector using multiple techniques.
echo "=== Combined Escalation Vector Simulation ==="
sudo -l
find / -type f -perm -o+w 2>/dev/null
echo "============================================="
