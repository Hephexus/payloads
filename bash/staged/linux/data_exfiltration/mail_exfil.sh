#!/bin/bash
# mail_exfil.sh - Send a file as an email attachment.
if [ "$#" -ne 3 ]; then
  echo "Usage: $0 <file> <recipient_email> <subject>"
  exit 1
fi
FILE="$1"
RECIPIENT="$2"
SUBJECT="$3"
echo "Sending $FILE to $RECIPIENT via mail..."
mail -s "$SUBJECT" "$RECIPIENT" < "$FILE"
echo "Email sent."
