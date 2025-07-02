#!/bin/bash
# user_processes.sh - List processes for all users.
echo "=== Processes Owned by Users ==="
ps -eo user,pid,cmd --sort=user
echo "================================"
