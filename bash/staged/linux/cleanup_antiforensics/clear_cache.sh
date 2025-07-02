#!/bin/bash
# clear_cache.sh - Clear system package cache.
echo "Clearing package cache..."
if [ -d /var/cache/apt ]; then
  sudo apt-get clean
elif [ -d /var/cache/pkg ]; then
  sudo pkg clean -a
else
  echo "No recognized package cache directory."
fi
