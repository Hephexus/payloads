#!/bin/bash
# secrets_extraction.sh - Search for potential secrets in /etc.
echo "=== Searching for keywords in /etc ==="
sudo grep -Ri 'password' /etc/* 2>/dev/null
echo "========================================"
