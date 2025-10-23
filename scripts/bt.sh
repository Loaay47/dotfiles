#!/usr/bin/env bash
DEVICE="10:28:74:1F:83:E1"

if bluetoothctl info "$DEVICE" | grep -q "Connected: yes"; then
    bluetoothctl disconnect "$DEVICE"
else
    bluetoothctl connect "$DEVICE"
fi

