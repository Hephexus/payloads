#!/bin/bash
# db_dump.sh - Dump a local SQLite3 database.
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <database_file> <output_dump_file>"
  exit 1
fi
DB_FILE="$1"
OUTPUT_FILE="$2"
echo "Dumping SQLite database from $DB_FILE to $OUTPUT_FILE..."
sqlite3 "$DB_FILE" ".dump" > "$OUTPUT_FILE"
echo "Database dump complete."
