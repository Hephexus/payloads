#!/bin/bash
# window_manager.sh - Display information about the window manager.
echo "=== Window Manager Info ==="
xprop -root _NET_SUPPORTING_WM_CHECK 2>/dev/null || echo "Not running under X or no window manager detected."
echo "==========================="
