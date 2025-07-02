#!/bin/bash
# privilege_mapper.sh - Map current user privileges and potential escalation routes.
echo "=== Privilege Mapping ==="
id
groups
sudo -l 2>/dev/null
echo "========================="
