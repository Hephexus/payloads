#!/bin/bash
# erase_metadata.sh - (Simulation) Remove metadata from specified files.
if [ -z "$1" ]; then
  echo "Usage: $0 <file>"
  exit 1
fi
echo "Erasing metadata from $1 using exiftool..."
exiftool -all= "$1"
echo "Metadata erased."
