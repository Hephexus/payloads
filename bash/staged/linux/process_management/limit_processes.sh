#!/bin/bash
# limit_processes.sh - Display and set process limits using ulimit.
echo "Current process limits:"
ulimit -a
echo "Setting max user processes to 512..."
ulimit -u 512
echo "New process limit:"
ulimit -u
