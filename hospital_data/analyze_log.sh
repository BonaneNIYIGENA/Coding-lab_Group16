#!/bin/bash

ACTIVE_DIR="active_logs"
REPORT_FILE="reports/analysis_report.txt"

mkdir -p "reports"  # make sure reports directory exists

while true; do
  echo "Select log file to analyze:"
  echo "1) Heart Rate (heart_rate_log.log)"
  echo "2) Temperature (temperature_log.log)"
  echo "3) Water Usage (water_usage_log.log)"
  read -p "Enter choice (1-3): " choice

  case "$choice" in
    1)
      FILE="heart_rate_log.log"
      LOG_NAME="Heart Rate"
      break
      ;;
    2)
      FILE="temperature_log.log"
      LOG_NAME="Temperature"
      break
      ;;
    3)
      FILE="water_usage_log.log"
      LOG_NAME="Water Usage"
      break
      ;;
    *)
      echo "Invalid input. Please enter 1, 2, or 3."
      ;;
  esac
done

LOG_PATH="$ACTIVE_DIR/$FILE"

if [ ! -f "$LOG_PATH" ]; then
  echo "Error: Log file $LOG_PATH not found."
  exit 1
fi

# Extract device IDs and count occurrences
# Assuming device ID is the 3rd field in the log entries

DEVICE_COUNTS=$(awk '{print $3}' "$LOG_PATH" | sort | uniq -c | sort -nr)

# Get timestamp of first and last entries
FIRST_TIMESTAMP=$(head -n 1 "$LOG_PATH" | awk '{print $1, $2}')
LAST_TIMESTAMP=$(tail -n 1 "$LOG_PATH" | awk '{print $1, $2}')

# Write report
{
  echo "----- Analysis Report -----"
  echo "Log File: $LOG_NAME ($FILE)"
  echo "Analysis Time: $(date)"
  echo "First entry timestamp: $FIRST_TIMESTAMP"
  echo "Last entry timestamp:  $LAST_TIMESTAMP"
  echo ""
  echo "Device Counts:"
  echo "$DEVICE_COUNTS"
  echo "---------------------------"
  echo ""
} >> "$REPORT_FILE"

echo "Analysis complete. Results appended to $REPORT_FILE"
