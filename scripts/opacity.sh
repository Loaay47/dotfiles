#!/bin/bash

win_id=$(xdotool getactivewindow)

if xprop -id "$win_id" | grep -q "_PICOM_DISABLE_OPACITY"; then
    xprop -id "$win_id" -remove _PICOM_DISABLE_OPACITY
else
    xprop -id "$win_id" -f _PICOM_DISABLE_OPACITY 32c -set _PICOM_DISABLE_OPACITY 1
fi

