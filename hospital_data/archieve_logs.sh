#!/bin/bash

ACTIVE_DIR="active_logs"
ARCHIVE_DIR="archived_logs"

mkdir -p "$ACTIVE_DIR" "$ARCHIVE_DIR"

# Loop until valid input is given
while true; do
  echo "Select log to archive:"
  echo "1) Heart Rate"
  echo "2) Temperature"
  echo "3) Water Usage"
  read -p "Enter choice (1-3): " choice

  case "$choice" in
    1)
      FILE="heart_rate_log.log"
      PREFIX="heart_rate"
      break
      ;;
    2)
      FILE="temperature_log.log"
      PREFIX="temperature"
      break
      ;;
    3)
      FILE="water_usage_log.log"
      PREFIX="water_usage"
      break
      ;;
    *)
      echo "Invalid input. Please enter 1, 2, or 3."
      ;;
  esac
done

TIMESTAMP=$(date +"%Y-%m-%d_%H:%M:%S")
SRC_PATH="$ACTIVE_DIR/$FILE"
ARCHIVE_FILE="${PREFIX}_${TIMESTAMP}.log"
DEST_PATH="$ARCHIVE_DIR/$ARCHIVE_FILE"

if [ ! -f "$SRC_PATH" ]; then
  echo "Error: Log file $SRC_PATH not found."
  echo "Available files in $ACTIVE_DIR:"
  ls "$ACTIVE_DIR"
  exit 1
fi

echo "Archiving $FILE..."
mv "$SRC_PATH" "$DEST_PATH"
touch "$SRC_PATH"

echo "Successfully archived to $DEST_PATH"
