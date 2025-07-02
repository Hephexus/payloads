#!/bin/bash
# anti_forensic.sh - Execute a sequence of cleanup commands to remove forensic traces.
echo "Executing anti-forensic cleanup..."
./clear_logs.sh
./remove_temp_files.sh
./history_clean.sh
echo "Anti-forensic steps complete."
