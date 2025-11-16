#!/usr/bin/env bash/
EVENT_DEVICE="$1"
ACTION="$2"

if [[ "$ACTION" == "disconnect" ]]; then
    playerctl pause
fi

