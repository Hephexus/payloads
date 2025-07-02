#!/bin/bash
# forensic_eraser.sh - Execute a full sequence to erase forensic traces.
echo "Starting forensic erasure..."
./clear_logs.sh
./remove_temp_files.sh
./history_clean.sh
./no_trace.sh
echo "Forensic erasure complete."
