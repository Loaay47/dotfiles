#!/usr/bin/env bash
STATE_FILE="$HOME/.brightness_level"

if [ -f "$STATE_FILE" ]; then
    LEVEL=$(cat "$STATE_FILE")
    doas brightnessctl set "$LEVEL"
fi
