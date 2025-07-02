#!/bin/bash
# systemd_journal.sh - Display recent journal logs using systemd.
echo "=== Systemd Journal Logs ==="
journalctl -n 50
echo "============================="
