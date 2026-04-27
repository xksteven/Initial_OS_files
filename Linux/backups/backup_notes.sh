#!/bin/bash
# Backup ~/workspace/notes to Google Drive using rclone

set -e

SOURCE="$HOME/workspace/notes"
DEST="gdrive:Back_up_Files/notes"
LOG_FILE="$HOME/workspace/.gdrive_sync/backup.log"

timestamp() {
    date "+%Y-%m-%d %H:%M:%S"
}

echo "$(timestamp) Starting notes backup..." >> "$LOG_FILE"

if [ ! -d "$SOURCE" ]; then
    echo "$(timestamp) ERROR: Source directory not found: $SOURCE" >> "$LOG_FILE"
    exit 1
fi

if ! command -v rclone &> /dev/null; then
    echo "$(timestamp) ERROR: rclone not found" >> "$LOG_FILE"
    exit 1
fi

# Run rclone copy
rclone copy "$SOURCE" "$DEST" \
    --log-file="$LOG_FILE" \
    --log-level INFO \
    --update \
    --transfers 4

echo "$(timestamp) Backup completed successfully" >> "$LOG_FILE"
