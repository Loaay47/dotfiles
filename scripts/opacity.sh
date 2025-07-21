#!/bin/bash

PICOM_NORMAL="$HOME/.config/picom/picom.conf"
PICOM_FULL="$HOME/.config/picom/picom_off.conf"
PID=$(pgrep -x picom)

if [ -f /tmp/picom_full ]; then
    rm /tmp/picom_full
    [ "$PID" ] && kill "$PID"
    picom --config "$PICOM_NORMAL" -b
else
    touch /tmp/picom_full
    [ "$PID" ] && kill "$PID"
    picom --config "$PICOM_FULL" -b
fi

