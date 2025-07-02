#!/bin/bash
# language_versions.sh - Display versions for scripting languages.
echo "=== Scripting Language Versions ==="
echo -n "Bash: "; bash --version | head -n 1
echo -n "Python: "; python3 --version
echo -n "Perl: "; perl -v | grep "v" | head -n 1
echo -n "Ruby: "; ruby --version
echo "==================================="
