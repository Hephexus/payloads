#!/bin/bash
# remove_shadow.sh - (Simulation) Remove shadow file copies.
echo "Simulating removal of duplicate shadow files..."
find / -type f -name "shadow.bak" 2>/dev/null -exec rm -f {} \;
echo "Shadow file duplicates removed."
