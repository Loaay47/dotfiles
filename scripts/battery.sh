#!/usr/bin/env bash

PREV_STATUS_FILE="/tmp/battery_status_prev"

battery_info=$(acpi -b)
battery_level=$(echo "$battery_info" | grep -o '[0-9]*%' | tr -d '%')
charging_status=$(echo "$battery_info" | grep -o 'Charging\|Discharging')
current_status="$charging_status $battery_level"

if [ -f "$PREV_STATUS_FILE" ]; then
    prev_status=$(cat "$PREV_STATUS_FILE")
else
    prev_status=""
fi

if [ "$current_status" != "$prev_status" ]; then
    echo "$current_status" > "$PREV_STATUS_FILE"
    pkill -SIGRTMIN+10 dwmblocks

    # Only notify when change is relevant
    if [ "$charging_status" != "Charging" ] && [ "$battery_level" -le 30 ]; then
      notify-send -u critical -i battery-caution "Battery Low" "Plug in your charger" &
      paplay "$HOME/sounds/alert.mp3"
      wait
    fi
fi

# Output battery icon and status
if [ "$charging_status" = "Charging" ]; then
    echo "  $battery_level%"
elif [ "$battery_level" -le 30 ]; then
    echo " $battery_level%"
elif [ "$battery_level" -le 50 ]; then
    echo " $battery_level%"
elif [ "$battery_level" -le 70 ]; then
    echo " $battery_level%"
elif [ "$battery_level" -le 90 ]; then
    echo " $battery_level%"
else
    echo " $battery_level%"
fi

