#!/bin/bash
# hide_artifacts.sh - Remove temporary files and browser caches.
echo "Hiding artifacts by clearing browser cache and temp directories..."
rm -rf ~/.cache/*
echo "Artifacts cleared."
