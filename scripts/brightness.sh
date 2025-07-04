#!/bin/bash

STEP="5%"
STATE_FILE="$HOME/.brightness_level"

case "$1" in
    up)
      doas brightnessctl set +$STEP
        ;;
    down)
      doas brightnessctl set $STEP-
        ;;
    *)
        echo "Usage: $0 {up|down}"
        exit 1
        ;;
esac
brightnessctl get > "$STATE_FILE"
