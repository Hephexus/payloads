#!/bin/bash
# gather_documents.sh - Collect common document files (doc, pdf, txt) from home directories.
echo "Gathering documents from /home..."
find /home -type f \( -iname "*.doc*" -o -iname "*.pdf" -o -iname "*.txt" \) 2>/dev/null
echo "Document gathering complete."
