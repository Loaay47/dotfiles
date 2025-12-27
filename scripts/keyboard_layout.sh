#!/usr/bin/env bash
PID_FILE="/tmp/keyboard_layout.pid"

if [ ! -f "$PID_FILE" ]; then
    touch "$PID_FILE"
    echo "2" > "$PID_FILE"
else
    content=$(cat $PID_FILE)
    if [ "$content" = "1" ]; then
        echo "2" > $PID_FILE
        pkill -RTMIN+30 dwmblocks
        setxkbmap -layout us,ara -variant dvorak,digits -option grp:alt_shift_toggle,caps:escape
        xmodmap ~/.Xmodmap
    else
        echo "1" > $PID_FILE
        pkill -RTMIN+30 dwmblocks
        setxkbmap -layout us,ara -variant ,digits -option grp:alt_shift_toggle,caps:escape
        xmodmap ~/.Xmodmap
    fi
fi
