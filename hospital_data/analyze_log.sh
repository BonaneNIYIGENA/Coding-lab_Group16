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
