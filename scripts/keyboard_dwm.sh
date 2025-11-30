#!/usr/bin/env bash
PID_FILE="/tmp/keyboard_layout.pid"

# Get layout
if [ -f "$PID_FILE" ] && [ "$(cat "$PID_FILE")" = "2" ]; then
    layout="DV"
else
    layout="QW"
fi


# Get lang
LANG=$(xkblayout-state print "%s")

if [ "$LANG" = "us" ]; then
    lang="EN"

else
    lang="AR"
fi

echo "$layout->[$lang]"
