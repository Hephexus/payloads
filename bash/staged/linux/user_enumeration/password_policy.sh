#!/bin/bash
# password_policy.sh - Display password policy settings.
echo "=== Password Policy (login.defs) ==="
cat /etc/login.defs | grep -E 'PASS_MAX_DAYS|PASS_MIN_DAYS|PASS_WARN_AGE'
echo "===================================="
