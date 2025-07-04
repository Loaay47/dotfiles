#!/bin/sh

arg=$1

[ $arg = "up" ] && amixer -q sset Master 5%+
[ $arg = "down" ] && amixer -q sset Master 5%-
[ "$arg" = "toggle" ] && {
    muted=$(amixer get Master | grep '\[off\]')
    if [ -n "$muted" ]; then
        amixer -q set Master unmute
        amixer -q set Speaker unmute
        amixer -q set Headphone unmute 2>/dev/null
    else
        amixer -q set Master mute
        amixer -q set Speaker mute
        amixer -q set Headphone mute 2>/dev/null
    fi
}

pkill -RTMIN+30 dwmblocks
#$HOME/script/volume_dwm.sh &
