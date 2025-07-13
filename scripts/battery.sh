#!/bin/bash

# Path to store the previous status
PREV_STATUS_FILE="/tmp/battery_status_prev"

# Get battery info using acpi
battery_info=$(acpi -b)
battery_level=$(echo "$battery_info" | grep -o '[0-9]*%' | tr -d '%')
charging_status=$(echo "$battery_info" | grep -o 'Charging\|Discharging')

# Define current status for comparison
current_status="$charging_status $battery_level"

# Read previous status
if [ -f "$PREV_STATUS_FILE" ]; then
    prev_status=$(cat "$PREV_STATUS_FILE")
else
    prev_status=""
fi

# If status has changed, send signal to dwmblocks
if [ "$current_status" != "$prev_status" ]; then
    pkill -SIGRTMIN+10 dwmblocks
    # Update previous status file
    echo "$current_status" > "$PREV_STATUS_FILE"
fi

# Output the current status with Nerd Font icons
if [ "$charging_status" = "Charging" ]; then
    echo "  $battery_level%"  # charging
elif [ "$battery_level" -le 30 ]; then
    echo " $battery_level%"    # low battery
    paplay "$HOME/sounds/output.wav"
    notify-send -u critical -i battery-caution "Battery Low" "Plug in your charger"
elif [ "$battery_level" -le 50 ]; then
    echo " $battery_level%"
elif [ "$battery_level" -le 70 ]; then
    echo " $battery_level%"
elif [ "$battery_level" -le 90 ]; then
    echo " $battery_level%"
else
    echo " $battery_level%"    # full battery
fi
