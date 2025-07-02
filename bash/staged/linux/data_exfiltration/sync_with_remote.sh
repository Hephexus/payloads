#!/bin/bash
# sync_with_remote.sh - Synchronize a directory with a remote host using rsync.
if [ "$#" -ne 3 ]; then
  echo "Usage: $0 <source_directory> <remote_user@remote_host> <destination_directory>"
  exit 1
fi
SRC="$1"
REMOTE="$2"
DEST="$3"
echo "Synchronizing $SRC with ${REMOTE}:$DEST..."
rsync -avz "$SRC" "${REMOTE}:$DEST"
echo "Synchronization complete."
