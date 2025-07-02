#!/bin/bash
# process_cgroup.sh - List process cgroups (for systems using systemd).
echo "=== Process Control Groups (cgroups) ==="
if command -v systemd-cgls >/dev/null 2>&1; then
  systemd-cgls
else
  echo "systemd-cgls not available."
fi
