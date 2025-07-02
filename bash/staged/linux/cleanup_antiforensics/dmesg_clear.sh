#!/bin/bash
# dmesg_clear.sh - Clear the kernel ring buffer.
echo "Clearing dmesg buffer..."
sudo dmesg -C
echo "dmesg buffer cleared."
