#!/bin/bash
# wipe_trash.sh - Remove contents of the Trash folder.
echo "Wiping user's Trash folder..."
rm -rf ~/.local/share/Trash/*
echo "Trash wiped."
