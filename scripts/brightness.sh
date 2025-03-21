#!/bin/bash

# Define screen names
LAPTOP="eDP-1"
EXTERNAL="HDMI-1"

case $1 in
    up)
        xrandr --output $LAPTOP --brightness $(awk "BEGIN {print $(xrandr --verbose | grep -m 1 -i brightness | awk '{print $2}') + 0.1}")
        xrandr --output $EXTERNAL --brightness $(awk "BEGIN {print $(xrandr --verbose | grep -m 1 -i brightness | awk '{print $2}') + 0.1}")
        ;;
    down)
        xrandr --output $LAPTOP --brightness $(awk "BEGIN {print $(xrandr --verbose | grep -m 1 -i brightness | awk '{print $2}') - 0.1}")
        xrandr --output $EXTERNAL --brightness $(awk "BEGIN {print $(xrandr --verbose | grep -m 1 -i brightness | awk '{print $2}') - 0.1}")
        ;;
    *)
        echo "Usage: $0 {up|down}"
        ;;
esac
