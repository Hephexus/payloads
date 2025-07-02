#!/bin/bash
# scrub_disk.sh - Perform a quick scrub of free disk space.
echo "Scrubbing free disk space..."
sudo dd if=/dev/zero of=/tmp/scrub bs=1M; sudo rm -f /tmp/scrub
echo "Disk scrub completed."
