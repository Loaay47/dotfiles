#!/bin/bash

# Path to store the previous status
PREV_STATUS_FILE="/tmp/battery_status_prev"

# Check if BAT0 exists, fallback to BAT1 or set N/A
if [ -f "/sys/class/power_supply/BAT0/capacity" ]; then
    BAT="BAT0"
elif [ -f "/sys/class/power_supply/BAT1/capacity" ]; then
    BAT="BAT1"
else
    current_status="N/A"
fi

# Get current battery info if a battery is present
if [ -n "$BAT" ]; then
    battery_level=$(cat "/sys/class/power_supply/$BAT/capacity")
    charging=$(cat "/sys/class/power_supply/$BAT/status")
    # Define current_status for comparison
    current_status="$charging $battery_level"
fi

# Read previous status
if [ -f "$PREV_STATUS_FILE" ]; then
    prev_status=$(cat "$PREV_STATUS_FILE")
else
    prev_status=""
fi

# If status has changed, send signal to dwmblocks
if [ "$current_status" != "$prev_status" ]; then
    # Send SIGRTMIN+10 to dwmblocks (adjust signal number as needed)
    pkill -SIGRTMIN+10 dwmblocks
    # Update previous status file
    echo "$current_status" > "$PREV_STATUS_FILE"
fi

# Output the current status with emojis
if [ "$current_status" = "N/A" ]; then
    echo "🔋 N/A"
else
    if [ "$charging" = "Charging" ]; then
        echo "⚡🔋 $battery_level%"
    elif [ "$battery_level" -le 20 ]; then
        echo "🪫 $battery_level%"
    else
        echo "🔋 $battery_level%"
    fi
fi
