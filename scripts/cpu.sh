#!/bin/bash

while true; do
    # Get CPU load (1-minute average)
    load=$(awk '{print $1}' /proc/loadavg)

    # Get CPU temperature (convert from millidegrees)
    temp=$(awk '{print $1/1000 "°C"}' /sys/class/thermal/thermal_zone0/temp)

    # Print formatted output for dwmblocks
    echo "CPU: $load - $temp"

    sleep 5 
done

