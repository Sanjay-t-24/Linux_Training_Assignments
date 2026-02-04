#!/bin/bash

if [ "$#" -ne 3 ]; then
  echo "Usage: $0 <source_dir> <backup_dir> <file_extension>"
  exit 1
fi

SOURCE_DIR="$1"
BACKUP_DIR="$2"
EXT="$3"

if [ ! -d "$SOURCE_DIR" ]; then
  echo "Source directory does not exist"
  exit 1
fi

mkdir -p "$BACKUP_DIR" || { echo "Failed to create backup directory"; exit 1; }

shopt -s nullglob
FILES=("$SOURCE_DIR"/*"$EXT")
shopt -u nullglob

if [ "${#FILES[@]}" -eq 0 ]; then
  echo "No files found with extension $EXT"
  exit 1
fi

export BACKUP_COUNT=0
TOTAL_SIZE=0

echo "Files to be backed up:"
for file in "${FILES[@]}"; do
  size=$(stat -c%s "$file")
  echo "$(basename "$file") - $size bytes"
done

for file in "${FILES[@]}"; do
  filename=$(basename "$file")
  dest="$BACKUP_DIR/$filename"

  if [ -f "$dest" ]; then
    if [ "$file" -nt "$dest" ]; then
      cp "$file" "$dest"
    else
      continue
    fi
  else
    cp "$file" "$dest"
  fi

  size=$(stat -c%s "$file")
  TOTAL_SIZE=$((TOTAL_SIZE + size))
  BACKUP_COUNT=$((BACKUP_COUNT + 1))
done

REPORT="$BACKUP_DIR/backup_report.log"

{
  echo "Backup Summary Report"
  echo "---------------------"
  echo "Total files backed up: $BACKUP_COUNT"
  echo "Total size backed up: $TOTAL_SIZE bytes"
  echo "Backup directory: $BACKUP_DIR"
  echo "Backup completed on: $(date)"
} > "$REPORT"

echo "Backup completed. Report saved to $REPORT"
